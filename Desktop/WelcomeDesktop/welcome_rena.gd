extends Node2D

@onready var signin_on: TextureRect = $VBoxContainer2/SignIn/Signin_on
const MAIN_DESKTOP = "res://Desktop/MainDesktop/MainDesktop.tscn"

func _on_area_2d_mouse_entered() -> void:
	signin_on.visible = true

func _on_area_2d_mouse_exited() -> void:
	signin_on.visible = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		AudioPlayer.play_click()
		get_tree().change_scene_to_file(MAIN_DESKTOP)
