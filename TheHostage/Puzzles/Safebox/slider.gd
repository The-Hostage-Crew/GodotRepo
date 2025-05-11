@tool
extends Control

@export var initial_step: Step = Step.STEP_25
@export var slider_lower_texture: Texture2D
@export var slider_upper_texture: Texture2D
@export var button_texture: Texture2D

@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var button: TextureButton = $Button

enum Step {
	STEP_25 = 25,
	STEP_50 = 50,
	STEP_75 = 75,
	STEP_100 = 100
}

var step_values = [Step.STEP_25, Step.STEP_50, Step.STEP_75, Step.STEP_100]
var current_step_index := 0

var button_positions = {
	Step.STEP_25: 510,
	Step.STEP_50: 340,
	Step.STEP_75: 170,
	Step.STEP_100: 0
}

func _ready() -> void:
	if slider_lower_texture && slider_upper_texture && button_texture:
		progress_bar.texture_under = slider_lower_texture
		progress_bar.texture_progress = slider_upper_texture
		button.texture_normal = button_texture
	
	current_step_index = step_values.find(initial_step)
	if current_step_index == -1:
		current_step_index = 0  # fallback
	update_slider()


func _on_button_pressed() -> void:
	current_step_index = (current_step_index + 1) % step_values.size()
	update_slider()


func update_slider() -> void:
	var step_value = step_values[current_step_index]
	progress_bar.value = step_value
	button.position.y = button_positions[step_value]
