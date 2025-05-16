extends TextureButton

@onready var glow: ColorRect = $Glow
@onready var item: TextureRect = $Item

var item_name: String = "" # ← store item name here

func _ready() -> void:
	InventoryManager.register_slot(self)


func _on_mouse_entered() -> void:
	glow.visible = true
	if item.texture != null:
		InventoryManager.update_hover_label(item_name.capitalize())

func _on_mouse_exited() -> void:
	glow.visible = false
	InventoryManager.update_hover_label("") # clear on exit


func is_empty() -> bool:
	return item.texture == null

func set_item(texture: Texture2D, name: String = "") -> void:
	item.texture = texture
	item_name = name

func clear():
	item.texture = null
	item_name = ""
