extends Control

var input_text := ""
const MAX_LENGTH := 8
@export var CORRECT_CODE := "32348243"

func _ready():
	for child in $GridContainer.get_children():
		if child is Button:
			var button_name := child.name
			child.pressed.connect(func(): _on_button_pressed(button_name))

func _on_button_pressed(button_name: String) -> void:
	$ClickAudio.play()
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

	$Label.text = input_text

# Show glowing first, then resolve result
func handle_code_check() -> void:
	if input_text == CORRECT_CODE:
		$LampBase.visible = true
		$GlowingLampTrue.visible = true
		$SuccessAudio.play()
		await get_tree().create_timer(1.0).timeout 
		show_correct_lamp()
		await get_tree().create_timer(1.0).timeout 
		Fade._in()
		await Fade.transition_finished
		$WinScreen.visible = true
		Fade._out()
		await Fade.transition_finished
		await get_tree().create_timer(3.0).timeout 
		Fade._in()
		await Fade.transition_finished
		Global.stage1 = true
		Global.TheHostage_icon = false
		get_tree().change_scene_to_file("res://Desktop/MainDesktop/MainDesktop.tscn")
	else:
		$LampBase.visible = true
		$GlowingLampFalse.visible = true
		$FailAudio.play()
		await get_tree().create_timer(1.0).timeout 
		show_wrong_lamp()
		SanitySystem.decrease_sanity(10)

	input_text = ""  
	$Label.text = input_text 


func show_correct_lamp():
	$GlowingLampTrue.visible = false
	$GlowingLampFalse.visible = false
	$LampBase.visible = false
	$LampBaseTrue.visible = true

func show_wrong_lamp():
	$GlowingLampTrue.visible = false
	$GlowingLampFalse.visible = false
	$LampBase.visible = true
	$LampBaseTrue.visible = false
