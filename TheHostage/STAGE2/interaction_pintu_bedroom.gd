extends Interactable
@onready var pintu: Node3D = $".."
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var player: CharacterBody3D = $"../../Player"
@onready var statue_2: CharacterBody3D = $"../../Room+ACC/Statue2"

@export var normal_audio_2 : AudioStreamPlayer3D
func interact() -> void:
	pintu.position = Vector3(-5.773, -3.776, -1.478)
	pintu.rotation = Vector3(0, 15, 0)
	collision_shape_3d.disabled = true
	statue_2.pause_chase = false
	player.look_at_target(true)
	normal_audio_2.play()

	# TODO: REMOVE AFTER DEBUG
	#statue_2.enable_modal = true
