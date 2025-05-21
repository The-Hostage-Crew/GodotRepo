extends Sprite3D


@onready var white_glow: Sprite3D = $White_glow
@onready var white_peritilan: Sprite3D = $White_peritilan
@onready var white_base: Sprite3D = $White_base

@onready var base: Sprite3D = $Base
@onready var glow: Sprite3D = $Glow

func pinboard_done_3d():
	white_glow.set_visible(true)
	white_peritilan.set_visible(true)
	white_base.set_visible(true)
	
	base.set_visible(false)
	glow.set_visible(false)
