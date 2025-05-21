extends Control

signal pinboard_to_3d

@onready var button_container: Control = $Pinboard/ButtonContainer

var showed := false

func _on_button_container_pinboard_done() -> void:
	pinboard_to_3d.emit()

func have_scissor():
	button_container.set_scissor_true()

func _on_visibility_changed() -> void:
	if !showed:
		Notify.show_notification("What are they trying to say?")
		showed = true
