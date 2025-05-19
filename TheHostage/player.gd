extends CharacterBody3D

signal toggle_inventory

@export var speed: float = 10.0
@export var crouch_speed: float = 5.0  # Kecepatan saat jongkok
@export var sprint_speed: float = 15.0  # Kecepatan saat sprint
@export var acceleration: float = 5.0
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
var current_speed: float
var movement_enabled: bool = true

@onready var footstep_audio: AudioStreamPlayer3D = $Footstep
var footstep_timer := 0.0
var footstep_interval := 0.5  # seconds between steps

@onready var nav: NavigationAgent3D = $NavigationAgent3D

@onready var falling_camera: Camera3D = $Head/FallingCamera
@onready var animation_player: AnimationPlayer = $Head/AnimationPlayer
var has_fallen = false
# Add these variables at the top of your script/class
var has_stopped_at_waypoint = false
var stop_distance = 15.0  # Distance from target where character stops
var pause_duration = 2.0  # How long to pause (in seconds)
var pause_timer = 0.0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	default_camera_position = camera.position
	current_speed = speed

func _input(event):
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
	if not movement_enabled:
		return

	var movement_vector = Vector3.ZERO

	if not follow_target:
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
		var direction = Vector3()
		var waiting_point = target_position.global_position - Vector3(0, 0, 15)

		if not has_stopped_at_waypoint:
			# Phase 1: Move to waiting point
			nav.target_position = waiting_point
			direction = nav.get_next_path_position() - global_position
			direction = direction.normalized()
			
			# Keep cameras looking at the final destination
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
			camera.look_at(target_position.global_position, Vector3(0,1,0))
			falling_camera.look_at(target_position.global_position, Vector3(0,1,0))
			
			# Continue movement toward final target
			velocity = velocity.lerp(direction * speed / 2, acceleration * delta / 2)

		# Check final distance for fall sequence trigger
		var final_pos_2d = Vector2(global_position.x, global_position.z)
		var target_2d = Vector2(target_position.global_position.x, target_position.global_position.z)
		var final_distance = final_pos_2d.distance_to(target_2d)

		#print("Final Distance: ", final_distance)
		if final_distance < 8.75:
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

	falling_camera.make_current()
	falling_camera.look_at(target_position.global_position, Vector3.UP)

	var tween = get_tree().create_tween()
	
	var move_forward = falling_camera.global_transform.origin + Vector3(0, 0, 5)
	tween.tween_property(
		falling_camera, "global_transform:origin", move_forward, 3.0
	).set_trans(Tween.TRANS_LINEAR)

	tween.play()
	
	await tween.finished
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false  # Ensure game isn't paused

	SceneTransition.change_scene(preload("res://TheHostage/MainMenu/MainMenu.tscn"))
	
	

func set_movement_enabled(enabled: bool) -> void:
	movement_enabled = enabled
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if enabled else Input.MOUSE_MODE_VISIBLE)
