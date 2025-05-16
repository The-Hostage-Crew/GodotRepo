extends Control

var input_text := ""
const MAX_LENGTH := 8
const CORRECT_CODE := "80732243"

func _ready():
	for child in $GridContainer.get_children():
		if child is Button:
			var button_name := child.name
			child.pressed.connect(func(): _on_button_pressed(button_name))

func _on_button_pressed(button_name: String) -> void:
	match button_name:
		"Delete":
			if input_text.length() > 0:
				input_text = input_text.substr(0, input_text.length() - 1)

		"OK":
			handle_code_check()

		_:
			if input_text.length() < MAX_LENGTH:
				input_text += button_name

	$Label.text = input_text

# Show glowing first, then resolve result
func handle_code_check() -> void:
	if input_text == CORRECT_CODE:
		$LampBase.visible = true
		$GlowingLampTrue.visible = true
		await get_tree().create_timer(1.0).timeout 
		show_correct_lamp()
		await get_tree().create_timer(1.0).timeout 
		Fade._in()
	else:
		$LampBase.visible = true
		$GlowingLampFalse.visible = true
		await get_tree().create_timer(1.0).timeout 
		show_wrong_lamp()

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
