extends Control

@onready var page_12: Control = $DiaryBook/Page12
@onready var page_34: Control = $DiaryBook/Page34
@onready var page_56: Control = $DiaryBook/Page56

@onready var darker_right: Polygon2D = $DarkerRight
@onready var darker_left: Polygon2D = $DarkerLeft

var current_page := 1
var showed = false

func _on_button_right_pressed() -> void:
	if current_page < 3:
		current_page += 1
		flip_page()
	else:
		return

func _on_button_left_pressed() -> void:
	if current_page > 1:
		current_page -= 1
		flip_page()
	else:
		return

func flip_page():
	if current_page == 1:
		page_12.set_visible(true)
		page_34.set_visible(false)
		page_56.set_visible(false)
		darker_left.set_visible(false)
	if current_page == 2:
		page_12.set_visible(false)
		page_34.set_visible(true)
		page_56.set_visible(false)
	if current_page == 3:
		page_12.set_visible(false)
		page_34.set_visible(false)
		page_56.set_visible(true)
		darker_right.set_visible(false)


func _on_button_right_mouse_entered() -> void:
	if current_page == 1 or current_page == 2:
		darker_right.set_visible(true)

func _on_button_right_mouse_exited() -> void:
	if current_page == 1 or current_page == 2:
		darker_right.set_visible(false)

func _on_button_left_mouse_entered() -> void:
	if current_page == 2 or current_page == 3:
		darker_left.set_visible(true)

func _on_button_left_mouse_exited() -> void:
	if current_page == 2 or current_page == 3:
		darker_left.set_visible(false)


func _on_visibility_changed() -> void:
	if !showed:
		Notify.show_notification("Whose diary is this?")
		Notify.show_notification("What's with the colored initial letter? Would that be useful for the pin board?")
		showed = true
