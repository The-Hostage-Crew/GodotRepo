extends Node2D

@onready var dot_on = $HBoxContainer/MarginContainer3/dot_on
@onready var call_on = $HBoxContainer/MarginContainer2/call_on
@onready var search_on = $HBoxContainer/MarginContainer/search_on


func _on_search_mouse_entered() -> void:
	search_on.visible = true

func _on_search_mouse_exited() -> void:
	search_on.visible = false

func _on_call_mouse_entered() -> void:
	call_on.visible = true

func _on_call_mouse_exited() -> void:
	call_on.visible = false

func _on_dot_mouse_entered() -> void:
	dot_on.visible = true

func _on_dot_mouse_exited() -> void:
	dot_on.visible = false
