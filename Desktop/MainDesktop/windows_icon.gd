extends Node2D
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var confirmation : Node2D = $Button_click

func _ready() -> void:
	$Button_click.visible =  false
	animation.play("default")
	$button.visible = false
	
func _on_button_mouse_entered() -> void:
	$button_on.visible = true


func _on_button_mouse_exited() -> void:
	$button_on.visible = false


func _on_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed :
		AudioPlayer.play_click()
		if confirmation.visible == true :
			confirmation.visible = false
		elif confirmation.visible == false :
			confirmation.visible = true
			
	


func _on_shutdown_mouse_entered() -> void:
	$Button_click/shutdown_on.visible = true


func _on_shutdown_mouse_exited() -> void:
	$Button_click/shutdown_on.visible = false


func _on_shutdown_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed  :
		AudioPlayer.play_click()
		get_tree().quit()
