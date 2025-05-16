extends Node # Still not CanvasLayer, this script is just the manager

const TRANSITION_SCENE = preload("res://Globals/CanvasTransition/canvas_transition.tscn")

func _in():
	var transition = TRANSITION_SCENE.instantiate()
	get_tree().root.add_child(transition)
	transition.fade_in()

func _out():
	var transition = TRANSITION_SCENE.instantiate()
	get_tree().root.add_child(transition)
	transition.fade_out()
