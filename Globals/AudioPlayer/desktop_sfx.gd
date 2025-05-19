extends Node2D

@onready var mouse_click : AudioStreamPlayer2D = $mouse_click
@onready var notif : AudioStreamPlayer2D = $notif

func play_mouse_click() -> void:
	$mouse_click.play()

func play_notif() -> void:
	$notif.play()
