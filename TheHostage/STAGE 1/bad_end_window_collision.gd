extends Interactable

@onready var player: CharacterBody3D = %Player
@onready var texture_rect: RayCast3D = %Player/Head/Camera3D/RayCast3D

func interact() -> void:
	player.follow_target = true
