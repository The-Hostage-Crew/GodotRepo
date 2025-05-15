extends Control

@export var safebox_collision: Interactable

func _on_steel_rotator_safebox_done() -> void:
	if safebox_collision:
		safebox_collision.enabled = false
