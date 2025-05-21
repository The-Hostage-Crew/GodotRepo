extends Control

@onready var pause_scene: Control = $"."

func _on_continue_button_pressed() -> void:
	print("button_pressed")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_scene.hide()
