extends Interactable

@export var modal: Node

var showed := false

func interact():
	#print("Changing to scene ", scene.to_string())
	#SceneTransition.change_scene(scene)
	if modal:
		if !showed:
			modal.set_visible(true)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			showed = true
		else:
			modal.set_visible(false)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			showed = false
	else:
		print("MODAL NOT FOUND")
		pass
