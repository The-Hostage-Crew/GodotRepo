extends Control

signal safebox_to_pinboard

@export var safebox_collision: Interactable
@export var player: CharacterBody3D
var count_dialogue = 0

var showed = false

func _on_steel_rotator_safebox_done() -> void:
	if safebox_collision:
		safebox_collision.enabled = false
	player.set_movement_enabled(true)
	safebox_to_pinboard.emit()
	Notify.show_notification("Scissor Acquired... [Press TAB to Show Inventory]")

func _on_visibility_changed() -> void:
	if !showed:
		if count_dialogue == 0:
			Notify.show_notification("Daniel: Using colors and levels of something to disclose things.")
			Notify.show_notification("Daniel: That's one way to hide a deepest secret, wouldn't you agree?")
			Notify.show_notification("You: ....")
			count_dialogue+=1
		showed = true
