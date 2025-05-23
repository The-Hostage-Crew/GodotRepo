extends Control

signal safebox_to_pinboard

@export var safebox_collision: Interactable
@export var player: CharacterBody3D

var showed = false

func _on_steel_rotator_safebox_done() -> void:
	if safebox_collision:
		safebox_collision.enabled = false
	player.set_movement_enabled(true)
	safebox_to_pinboard.emit()
	Notify.show_notification("Scissor Acquired... [Press TAB to Show Inventory]")

func _on_visibility_changed() -> void:
	if !showed:
		Notify.show_notification("Colored sliders...? is someone setting me up for this?")
		showed = true
