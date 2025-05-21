extends Node2D

func _ready():
	$VBoxContainer/Background.position = get_viewport_rect().size / 2
	$VBoxContainer/EffectIce.position = get_viewport_rect().size / 2
