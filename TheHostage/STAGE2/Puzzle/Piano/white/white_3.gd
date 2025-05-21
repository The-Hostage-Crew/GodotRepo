extends Node2D

func _ready() -> void:
	$enter.visible = false
	$click.visible = false


func _on_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			$click.visible = true
		else:
			$click.visible = false



func _on_area_mouse_entered() -> void:
	$enter.visible = true


func _on_area_mouse_exited() -> void:
	$enter.visible = false
