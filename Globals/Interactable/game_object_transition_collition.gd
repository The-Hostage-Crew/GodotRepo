extends Interactable

@export var scene : PackedScene

func _ready() -> void:
	pass

func interact():
	print("Changing to scene ", scene.to_string())
	SceneTransition.change_scene(scene)
