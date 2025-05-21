extends Node3D

@export var player : CharacterBody3D

func _ready() -> void:
	if player:
		player.set_movement_enabled(false)
		await get_tree().create_timer(3.0).timeout
		player.set_movement_enabled(true)
