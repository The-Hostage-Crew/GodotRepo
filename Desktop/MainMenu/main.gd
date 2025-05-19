extends Node2D

@onready var input: LineEdit = $ScrollContainer/VBoxContainer/input/HBoxContainer/LineEdit
#@onready var label: Label = $Label
@onready var error_input: MarginContainer = $ScrollContainer/VBoxContainer/error_input
@onready var vbox: VBoxContainer = $ScrollContainer/VBoxContainer
@onready var text_input: MarginContainer = $ScrollContainer/VBoxContainer/input
@onready var name_input: LineEdit = $ScrollContainer/VBoxContainer/name_input/HBoxContainer/name_input
@onready var name_input_cont: MarginContainer = $ScrollContainer/VBoxContainer/name_input

const Desktop_main = "res://Desktop/WelcomeDesktop/welcome.tscn"

func _ready():
	# Set fullscreen
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	input.grab_focus()
	if not input.text_submitted.is_connected(_on_line_edit_text_submitted):
		input.text_submitted.connect(_on_line_edit_text_submitted)

func _on_line_edit_text_submitted(new_text: String) -> void:
	print("User input:", new_text)

	if new_text == "1":
		var name_clone = name_input_cont.duplicate()
		vbox.add_child(name_clone)
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value

		name_clone.visible = true
		var new_name_input = name_clone.get_node("HBoxContainer/name_input") as LineEdit
		new_name_input.text = ""
		new_name_input.grab_focus()
		if not new_name_input.text_submitted.is_connected(_on_name_input_text_submitted):
			new_name_input.text_submitted.connect(_on_name_input_text_submitted)
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif new_text == "3":
		get_tree().quit()
	else:
		var error_clone = error_input.duplicate()
		vbox.add_child(error_clone)
		error_clone.visible = true

		var text_input_clone = text_input.duplicate()
		vbox.add_child(text_input_clone)

		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value

		var new_input = text_input_clone.get_node("HBoxContainer/LineEdit") as LineEdit
		new_input.text = ""
		new_input.grab_focus()
		new_input.text_submitted.connect(_on_line_edit_text_submitted)


func _on_name_input_text_submitted(new_name: String) -> void:
	# Simpan nama ke variabel global (pastikan sudah ada di Global.gd)
	Global.user_name = new_name
	get_tree().change_scene_to_file(Desktop_main)
