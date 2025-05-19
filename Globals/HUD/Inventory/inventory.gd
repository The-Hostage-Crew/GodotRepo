extends Control

@onready var label: Label = %Label

func _ready():
	InventoryManager.register_hover_label(label)


func _on_button_pressed() -> void:
	InventoryManager.add_item("apple")

func _on_button_2_pressed() -> void:
	InventoryManager.remove_item("apple")


func _on_button_3_pressed() -> void:
	InventoryManager.add_item("scissor")

func _on_button_4_pressed() -> void:
	InventoryManager.remove_item("scissor")


func _on_button_5_pressed() -> void:
	InventoryManager.add_item("medkit")

func _on_button_6_pressed() -> void:
	InventoryManager.remove_item("medkit")


func _on_player_toggle_inventory() -> void:
	if !visible:
		set_visible(true)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		set_visible(false)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
