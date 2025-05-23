extends Control

@onready var pause_scene: Control = $"."

func _on_continue_button_pressed() -> void:
	print("button_pressed")
	get_tree().paused = false
	if Global.cursor_enabled:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_scene.hide()
