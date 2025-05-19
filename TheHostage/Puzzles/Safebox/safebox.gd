extends Control

@export var safebox_collision: Interactable
@export var player: CharacterBody3D

func _on_steel_rotator_safebox_done() -> void:
	if safebox_collision:
		safebox_collision.enabled = false
	player.set_movement_enabled(true)
