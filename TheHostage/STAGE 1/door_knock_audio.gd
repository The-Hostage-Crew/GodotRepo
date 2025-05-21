extends AudioStreamPlayer3D

func _ready():
	await get_tree().create_timer(1.1).timeout
	play()
