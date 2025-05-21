extends Control

@export var backgrounds: Array[Texture2D] = []
@onready var background: TextureRect = $Background

# Variables for background cycling
var current_bg_index: int = 0
var bg_timer: float = 0.0
var bg_change_interval: float = 3.0

func _ready() -> void:
	AudioPlayer.play_bgm_menu()

func _process(delta):
	# Update timer
	bg_timer += delta
	
	# Check if it's time to change the background
	if bg_timer >= bg_change_interval:
		change_background()
		bg_timer = 0.0  # Reset timer

func change_background():
	if backgrounds.size() == 0:
		return
	
	# Move to next background
	current_bg_index = (current_bg_index + 1) % backgrounds.size()
	background.texture = backgrounds[current_bg_index]


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://TheHostage/MainMenu/ChooseHostage/ChooseHostage.tscn")
	
	
func _on_exit_button_pressed() -> void:
	return


func _on_start_button_mouse_entered() -> void:
	AudioPlayer.play_sfx_hover()


func _on_exit_button_mouse_entered() -> void:
	AudioPlayer.play_sfx_hover()
