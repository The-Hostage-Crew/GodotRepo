extends CharacterBody3D
@onready var nav: NavigationAgent3D = $NavigationAgent3D

@onready var statue: Node3D = $"."

@export var chase_player = false
var pause_chase_distance = false
@export var pause_chase = true
@export var enable_modal = false
@export var player: CharacterBody3D
@export var speed: float
@export var acceleration: float

@onready var interaction: StaticBody3D = $Interaction

@export var player_camera: Camera3D

func _ready() -> void:
	nav.target_position = player.global_position
	interaction.enabled = false

func _physics_process(delta: float) -> void:
	var statue_pos = Vector2(global_position.x, global_position.z)
	var player_pos = Vector2(player.global_position.x, player.global_position.z)
	var distance_to_player = statue_pos.distance_to(player_pos)
	
	if enable_modal:
		pause_chase = true
		interaction.enabled = true
		$CollisionShape3D.disabled = true
		$Interaction/CollisionShape3D.disabled = false
	
	if is_statue_visible() or enable_modal:
		#print("statue is visible")
		chase_player = false
	else:
		#print("statue is not visible")
		chase_player = true
	
	if chase_player and not pause_chase and not pause_chase_distance:
		nav.target_position = player.global_position
		var direction = Vector3()
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		
		# Statue rotation to face player
		var to_player = player.global_position - statue.global_position
		to_player.y = 0
		to_player = to_player.normalized()

		# Flip direction (180 degrees)
		statue.look_at(statue.global_position - to_player, Vector3.UP)
		
		velocity = velocity.lerp(direction * speed / 2, acceleration * delta / 2)
		
		move_and_slide()
		
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider().name == "Player":
				pause_chase_distance = true
				HpSystem.decrease_hp(10)
				SanitySystem.decrease_sanity(5)
				break
	else:
		if distance_to_player > 10:
			pause_chase_distance = false

#
#func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	#if is_statue_visible():
		#print("statue is visible")
		#chase_player = false
	#else:
		#print("statue is not visible")
		#chase_player = true


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	chase_player = true

func is_statue_visible() -> bool:
	var from = player_camera.global_transform.origin
	var to = statue.global_transform.origin
	var space_state = get_world_3d().direct_space_state
	
	var ray_params = PhysicsRayQueryParameters3D.create(from, to)
	ray_params.exclude = [player_camera]  # Exclude the camera or any object you don’t want to collide with
	ray_params.collision_mask = 1  # Make sure this matches the layers of statue/walls

	var result = space_state.intersect_ray(ray_params)
	
	# print(result)
	
	if result.is_empty() or (result.has("collider") and result["collider"] == statue ):
		return true
	return false
