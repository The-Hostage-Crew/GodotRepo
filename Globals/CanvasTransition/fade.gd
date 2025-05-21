extends Node # Still not CanvasLayer, this script is just the manager

signal transition_finished

const TRANSITION_SCENE = preload("res://Globals/CanvasTransition/canvas_transition.tscn")

func _in():
	var transition = TRANSITION_SCENE.instantiate()
	get_tree().root.add_child(transition)
	transition.fade_in()
	await transition.canvas_finished
	transition_finished.emit()
	print("Global Fade In Completed")
	await get_tree().create_timer(0.5).timeout 
	transition.queue_free() 

func _out():
	var transition = TRANSITION_SCENE.instantiate()
	get_tree().root.add_child(transition)
	transition.fade_out()
	await transition.canvas_finished
	transition_finished.emit()
	print("Global Fade Out Completed")
	await get_tree().create_timer(0.5).timeout 
	transition.queue_free() 
