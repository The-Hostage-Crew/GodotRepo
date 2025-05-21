extends Control

signal pinboard_to_3d

@onready var button_container: Control = $Pinboard/ButtonContainer

func _on_button_container_pinboard_done() -> void:
	pinboard_to_3d.emit()

func have_scissor():
	button_container.set_scissor_true()
