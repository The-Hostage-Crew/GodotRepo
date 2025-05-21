extends Area2D

var statue_code_on = false
@onready var statue_code = $Sprite2D

func _ready() -> void:
	statue_code.visible = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if statue_code_on ==false:
				statue_code.visible = true
				statue_code_on = true
			else:
				statue_code.visible = false
				statue_code_on = false
