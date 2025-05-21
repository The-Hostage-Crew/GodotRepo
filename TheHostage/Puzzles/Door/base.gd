extends Control

var input_text := ""
const MAX_LENGTH := 8
@export var correct_code := "80732243"

func _ready():
	for child in $Base/GridContainer.get_children():
		if child is Button:
			var button_name := child.name
			child.pressed.connect(func(): _on_button_pressed(button_name))

func _on_button_pressed(button_name: String) -> void:
	$Base/ClickAudio.play()
	match button_name:
		"Delete":
			if input_text.length() > 0:
				input_text = input_text.substr(0, input_text.length() - 1)

		"OK":
			handle_code_check()

		_:
			if input_text.length() < MAX_LENGTH:
				var random_sanity_check = randi_range(0, 100)
				if random_sanity_check > SanitySystem.HOSTAGE_SANITY:
					input_text += str(randi_range(0,9))
				else:
					input_text += button_name

	$Base/Label.text = input_text

# Show glowing first, then resolve result
func handle_code_check() -> void:
	if input_text == correct_code:
		$Base/LampBase.visible = true
		$Base/GlowingLampTrue.visible = true
		$Base/SuccessAudio.play()
		await get_tree().create_timer(1.0).timeout 
		show_correct_lamp()
		await get_tree().create_timer(1.0).timeout 
		Fade._in()
	else:
		$Base/LampBase.visible = true
		$Base/GlowingLampFalse.visible = true
		await get_tree().create_timer(1.0).timeout 
		show_wrong_lamp()
		$Base/FailAudio.play()
		await Fade.transition_finished
		$Base/WinScreen.visible = true
		Fade._out()
		await Fade.transition_finished
		await get_tree().create_timer(3.0).timeout 
		Fade._in()
		await Fade.transition_finished
		get_tree().change_scene_to_file("res://Desktop/MainDesktop/MainDesktop.tscn")

	input_text = ""  
	$Base/Label.text = input_text 


func show_correct_lamp():
	$Base/GlowingLampTrue.visible = false
	$Base/GlowingLampFalse.visible = false
	$Base/LampBase.visible = false
	$Base/LampBaseTrue.visible = true

func show_wrong_lamp():
	$Base/GlowingLampTrue.visible = false
	$Base/GlowingLampFalse.visible = false
	$Base/LampBase.visible = true
	$Base/LampBaseTrue.visible = false
