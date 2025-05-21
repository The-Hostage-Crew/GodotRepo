extends Node


@onready var hover_label: Label = null


var inventory_slots := []
var items := []
var item_data := {
	"apple": preload("uid://b2vtg5xeqs1ri"),
	"bread": preload("uid://6v50oy0lh2ks"),
	"coffee": preload("uid://cijol7feymbu0"),
	"scissor": preload("uid://kbkk3f48yx56"),
	"medkit": preload("uid://c6kd2ckhvrjb8"),
	"remote_ice": preload("res://assets/TheHostage/2D/inventoryitem/Remote_Ice_Inventory.png"),
	"battery_ice": preload("res://assets/TheHostage/2D/inventoryitem/Battery_Ice_Inventory.png"),
	"remote": preload("res://assets/TheHostage/2D/inventoryitem/Remote_Inventory.png"),
	"battery": preload("res://assets/TheHostage/2D/inventoryitem/Battery_Inventory.png"),
}


func register_slot(slot):
	if slot not in inventory_slots:
		inventory_slots.append(slot)


func add_item(item_name: String) -> void:
	if not item_data.has(item_name):
		push_error("❌ Unknown item: %s" % item_name)
		return

	var texture: Texture2D = item_data[item_name]

	for slot in inventory_slots:
		if slot.is_empty():
			slot.set_item(texture, item_name)
			items.append(item_name)
			return

	print("📦 Inventory full!")


func remove_item(item_name: String) -> void:
	if not item_data.has(item_name):
		push_error("❌ Unknown item: %s" % item_name)
		return

	var target_texture: Texture2D = item_data[item_name]

	for i in range(inventory_slots.size() - 1, -1, -1):
		var slot = inventory_slots[i]
		if slot.item.texture == target_texture:
			slot.clear()
			items.erase(item_name)
			print("🗑 Removed:", item_name)
			_rebuild_inventory()
			return

	print("❌ Item not found in inventory:", item_name)


func _rebuild_inventory():
	# Clear all slots first
	for slot in inventory_slots:
		slot.clear()

	# Re-assign all items left in the list
	for i in range(min(items.size(), inventory_slots.size())):
		var item_name = items[i]
		var texture = item_data[item_name]
		inventory_slots[i].set_item(texture, item_name)
	


func register_hover_label(label_node: Label):
	hover_label = label_node

func update_hover_label(text: String):
	if hover_label:
		hover_label.text = text
