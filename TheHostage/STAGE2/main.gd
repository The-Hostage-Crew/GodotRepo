extends Node3D

func _ready() -> void:
	InventoryManager.items = []
	InventoryManager.rebuild_inventory()
