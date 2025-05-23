extends Control

signal value_changed(slider_name: String, value: int)

@export var initial_step: Step = Step.STEP_25
@export var slider_lower_texture: Texture2D
@export var slider_upper_texture: Texture2D
@export var button_texture: Texture2D

@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var button: TextureButton = $Button
@onready var slide_sound: AudioStreamPlayer = $SlideSound

enum Step {
	STEP_25 = 25,
	STEP_50 = 50,
	STEP_75 = 75,
	STEP_100 = 100
}

var step_values = [Step.STEP_25, Step.STEP_50, Step.STEP_75, Step.STEP_100]
var current_step_index := 0

var button_positions = {
	Step.STEP_25: 50.0,
	Step.STEP_50: -137.5,
	Step.STEP_75: -325.0,
	Step.STEP_100: -450.0,
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
	slide_sound.pitch_scale = randf_range(0.95, 1.05)  # Slight pitch variation
	slide_sound.play()
	
	var sanity_percentage = SanitySystem.HOSTAGE_SANITY
	var random_sanity_check = randi_range(0,100)
	if random_sanity_check > sanity_percentage:
		current_step_index = (current_step_index + random_sanity_check) % step_values.size()
	else:
		current_step_index = (current_step_index + 1) % step_values.size()
	update_slider()
	
	var step_value = step_values[current_step_index]
	emit_signal("value_changed", name, step_value)


func update_slider() -> void:
	var step_value = step_values[current_step_index]
	var target_y = button_positions[step_value]

	var tween := create_tween()
	tween.tween_property(button, "position:y", target_y, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(progress_bar, "value", step_value, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func get_current_value() -> int:
	return initial_step
