extends CharacterBody3D

signal toggle_inventory

@export var speed: float = 6.0
@export var crouch_speed: float = 5.0  # Kecepatan saat jongkok
@export var sprint_speed: float = 10.0  # Kecepatan saat sprint
@export var acceleration: float = 10.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.3
@export var crouch_height: float = -0.5  # Penyesuaian ketinggian saat jongkok
@export var follow_target: bool = false
@export var target_position: Marker3D

@onready var camera: Camera3D = $Head/Camera3D
var camera_x_rotation: float = 0.0

@onready var head: Node3D = $Head
var is_crouching: bool = false
var is_sprinting: bool = false
var default_camera_position: Vector3
var default_falling_camera_position: Vector3
var default_head_position: Vector3
var current_speed: float
var movement_enabled: bool = true
const LOSE_SCREEN = preload("res://TheHostage/LoseScreen.tscn")

@onready var footstep_audio: AudioStreamPlayer3D = $Footstep
var footstep_timer := 0.0
var footstep_interval := 0.5  # seconds between steps

@onready var nav: NavigationAgent3D = $NavigationAgent3D

# Falling animation
@onready var falling_camera: Camera3D = $Head/FallingCamera
var has_fallen = false
var has_stopped_at_waypoint = false
var stop_distance = 15.0  # Distance from target where character stops
var pause_duration = 2.0  # How long to pause (in seconds)
var pause_timer = 0.0

# Sanity
var time_since_last_sanity_check = 0.0
var sanity_check_interval = 2.0
var rng = RandomNumberGenerator.new()
var last_camera_rotation: Vector3

# HUD
@onready var hp_bar: TextureProgressBar = $Hud/HpBar
@onready var sanity_bar: TextureProgressBar = $Hud/SanityBar

# Trauma Constraint
@onready var low_trauma: TextureRect = $Hud/Trauma_Constraint/LowTrauma
@onready var high_trauma: TextureRect = $Hud/Trauma_Constraint/HighTrauma

# Bad End Window
@onready var ray_cast_3d: RayCast3D = $Head/Camera3D/RayCast3D

# Statue relation - Stage 2
@export var statue: CharacterBody3D

@onready var pause_overlay: Control = $CanvasPauseModal/PauseScene

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	default_camera_position = camera.position
	default_falling_camera_position = falling_camera.position
	default_head_position = head.position
	current_speed = speed
	
	hp_bar.value = 100
	sanity_bar.value = 100

func _input(event):
	if Input.is_action_just_pressed("pause"):
		pause_overlay.show()
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if movement_enabled and event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation

	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Toggle crouch
	if Input.is_action_pressed("crouch"):
		if not is_crouching:
			camera.position.y += crouch_height
			is_crouching = true
			current_speed = crouch_speed
	elif Input.is_action_just_released("crouch"):
		camera.position = default_camera_position
		is_crouching = false
		current_speed = speed

	# Sprinting
	if Input.is_action_pressed("sprint") and not is_crouching:
		is_sprinting = true
		current_speed = sprint_speed
	elif Input.is_action_just_released("sprint"):
		is_sprinting = false
		current_speed = speed
	
	# Inventory
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()

func _physics_process(delta):
	
	time_since_last_sanity_check += delta
	var sanity_percentage = SanitySystem.HOSTAGE_SANITY
	var hp_percentage = HpSystem.HOSTAGE_HP

	hp_bar.value = hp_percentage
	sanity_bar.value = 10 + sanity_percentage * 0.8
	
	if sanity_percentage < 40.0:
		high_trauma.visible = true
	elif sanity_percentage < 60.0:
		low_trauma.visible = true 

	if time_since_last_sanity_check > sanity_check_interval:
		var random_sanity = rng.randf_range(0.0, 100.0)
		if random_sanity > sanity_percentage:
			last_camera_rotation = camera.rotation
			follow_target = true
		time_since_last_sanity_check = 0
	
	if hp_percentage <= 0:
		follow_target = true

	if not movement_enabled:
		# Tetap aplikasikan gravitasi
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Setel kecepatan horizontal ke nol agar tidak ada "sisa momentum"
		velocity.x = 0
		velocity.z = 0

		move_and_slide()
		return

	var movement_vector = Vector3.ZERO

	if not follow_target:
		ray_cast_3d.enabled = true
		if Input.is_action_pressed("movement_forward"):
			movement_vector -= head.basis.z
		if Input.is_action_pressed("movement_backward"):
			movement_vector += head.basis.z
		if Input.is_action_pressed("movement_left"):
			movement_vector -= head.basis.x
		if Input.is_action_pressed("movement_right"):
			movement_vector += head.basis.x

		movement_vector = movement_vector.normalized()
		velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
		velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)
	else:
		ray_cast_3d.enabled = false
		# Check for any input to potentially escape fall sequence
		var has_input = Input.is_action_pressed("movement_forward") || Input.is_action_pressed("movement_backward") || Input.is_action_pressed("movement_left") || Input.is_action_pressed("movement_right")
		
		if has_input:
			var random_safe_bad_end_check = rng.randf_range(0.0, 100.0)
			if random_safe_bad_end_check < sanity_percentage and hp_percentage > 0:
				# Cancel fall sequence
				follow_target = false
				has_fallen = false
				has_stopped_at_waypoint = false  # Reset waypoint state
				pause_timer = 0.0  # Reset pause timer
				
				# Make main camera current first
				falling_camera.global_transform = camera.global_transform
				camera.make_current()
				
				# Reset camera position relative to character (adjust these values to match your setup)
				camera.position = default_camera_position
				camera.rotation = Vector3.ZERO  # Reset rotation only, not full transform
				
				# Reset falling camera to default position
				falling_camera.position = default_falling_camera_position
				falling_camera.rotation = Vector3.ZERO
				
				# Reset character rotation (keep position)
				rotation = Vector3.ZERO
				
				# Reset head rotation (this is crucial for movement controls)
				head.position = default_head_position
				head.rotation = Vector3.ZERO
				
				# Optional: Stop any active tweens
				var all_tweens = get_tree().get_nodes_in_group("active_tweens")
				for tween in all_tweens:
					if tween:
						tween.kill()

		var direction = Vector3()
		var waiting_point = target_position.global_position - Vector3(0, 0, 5)

		if not has_stopped_at_waypoint:
			# Phase 1: Move to waiting point
			nav.target_position = waiting_point
			direction = nav.get_next_path_position() - global_position
			direction = direction.normalized()
			
			# Keep cameras looking at the final destination
			head.look_at(target_position.global_position, Vector3(0,1,0))
			camera.look_at(target_position.global_position, Vector3(0,1,0))
			falling_camera.look_at(target_position.global_position, Vector3(0,1,0))
			
			# Check if reached waiting point
			var waiting_pos_2d = Vector2(global_position.x, global_position.z)
			var waiting_2d = Vector2(waiting_point.x, waiting_point.z)
			var distance_to_waiting = waiting_pos_2d.distance_to(waiting_2d)
			
			if distance_to_waiting <= 1.0:  # Close enough to waiting point
				# Stop and start pause timer
				velocity = velocity.lerp(Vector3.ZERO, acceleration * delta)
				pause_timer += delta
				
				# Reset camera to look at final target during pause
				head.look_at(target_position.global_position, Vector3(0,1,0))
				camera.look_at(target_position.global_position, Vector3(0,1,0))
				falling_camera.look_at(target_position.global_position, Vector3(0,1,0))
				
				# After pause, move to final phase
				if pause_timer >= pause_duration:
					has_stopped_at_waypoint = true
					pause_timer = 0.0
			else:
				# Continue moving toward waiting point
				velocity = velocity.lerp(direction * speed / 2, acceleration * delta / 2)
		else:
			# Phase 2: Move from waiting point to final target (straight line)
			nav.target_position = target_position.global_position
			direction = (target_position.global_position - global_position).normalized()
			
			# Keep cameras looking at final target for straight-line approach
			head.look_at(target_position.global_position, Vector3(0,1,0))
			camera.look_at(target_position.global_position, Vector3(0,1,0))
			falling_camera.look_at(target_position.global_position, Vector3(0,1,0))
			
			# Continue movement toward final target
			velocity = velocity.lerp(direction * speed / 2, acceleration * delta / 2)

		# Check final distance for fall sequence trigger
		var final_pos_2d = Vector2(global_position.x, global_position.z)
		var target_2d = Vector2(target_position.global_position.x, target_position.global_position.z)
		var final_distance = final_pos_2d.distance_to(target_2d)

		#print(final_distance)
		if final_distance < 1.5:
			trigger_fall_sequence()

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power

	move_and_slide()
	
	var moving_input = Input.is_action_pressed("movement_forward") || Input.is_action_pressed("movement_backward") || Input.is_action_pressed("movement_left")|| Input.is_action_pressed("movement_right")

	var is_moving = moving_input and is_on_floor() and velocity.length() > 0.1

#	Footstep Sound
	if is_moving:
		footstep_timer -= delta
		if footstep_timer <= 0.0:
			# Play footstep with randomized pitch
			footstep_audio.pitch_scale = randf_range(0.85, 1.15)
			footstep_audio.play()
			footstep_timer = footstep_interval
	else:
		footstep_timer = 0.0  # Reset so it plays immediately on move

func trigger_fall_sequence():
	if has_fallen:
		return

	has_fallen = true

	# falling_camera.global_transform = camera.global_transform
	# falling_camera.make_current()
	# falling_camera.look_at(target_position.global_position, Vector3.UP)

	# var tween = get_tree().create_tween()
	
	# var move_forward = falling_camera.global_transform.origin + Vector3(0, 0, 5)
	# tween.tween_property(
	# 	falling_camera, "global_transform:origin", move_forward, 3.0
	# ).set_trans(Tween.TRANS_LINEAR)

	# tween.play()
	
	# await tween.finished
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false  # Ensure game isn't paused

	SceneTransition.change_scene(LOSE_SCREEN)
	
	

func set_movement_enabled(enabled: bool) -> void:
	movement_enabled = enabled
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if enabled else Input.MOUSE_MODE_VISIBLE)


func look_at_target(animate: bool):
	var target_pos = statue.global_position
	var up = Vector3.UP

	if animate:
		movement_enabled = false
		# Animate the head
		var head_look_dir = (target_pos - head.global_position + Vector3(0,5,0)).normalized()
		var head_target_basis = Basis().looking_at(head_look_dir, up)
		create_tween().tween_property(head, "global_transform:basis", head_target_basis, 3)

		# Animate the main camera
		var cam_look_dir = (target_pos - camera.global_position + Vector3(0,5,0)).normalized()
		var cam_target_basis = Basis().looking_at(cam_look_dir, up)
		create_tween().tween_property(camera, "global_transform:basis", cam_target_basis, 3)

		# Animate the falling camera
		var fall_look_dir = (target_pos - falling_camera.global_position + Vector3(0,5,0)).normalized()
		var fall_target_basis = Basis().looking_at(fall_look_dir, up)
		create_tween().tween_property(falling_camera, "global_transform:basis", fall_target_basis, 3)

		await get_tree().create_timer(3).timeout
		movement_enabled = true
	else:
		head.look_at(target_pos, up)
		camera.look_at(target_pos, up)
		falling_camera.look_at(target_pos, up)
