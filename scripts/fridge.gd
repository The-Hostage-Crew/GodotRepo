extends Node2D

@onready var fridge_bg = $FridgeBackground
@onready var ices = $IceInFridge

func _ready():
	fridge_bg.centered = true
	ices.centered = true
	var center = get_viewport_rect().size / 2
	fridge_bg.position = center
	ices.position = center
