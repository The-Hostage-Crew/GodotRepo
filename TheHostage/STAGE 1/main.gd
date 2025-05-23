extends Node3D

@export var player : CharacterBody3D

func _ready() -> void:
	if player:
		player.set_movement_enabled(false)
		await get_tree().create_timer(3.0).timeout
		Notify.show_notification("You: Where am I....")
		Notify.show_notification("Daniel: Once again, I thank you for choosing and assisting me in my escape.")
		Notify.show_notification("Daniel: I am Daniel.")
		Notify.show_notification("Daniel: Unfortunately, I don't even know where we are too, or how do I get here.")
		Notify.show_notification("Daniel: But I hope you will still help me free from this trap, even though you're not here with me.")
		player.set_movement_enabled(true)
