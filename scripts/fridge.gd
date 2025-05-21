extends Node2D

@onready var fridge_bg = $FridgeBackground
@onready var ices = $IceInFridge

@onready var remote_ice: Area2D = $IceInFridge/RemoteIce
@onready var battery_ice: Area2D = $IceInFridge/BatteryIce

func _ready() -> void:
	if has_remote():
		remote_ice.hide()
	if has_battery():
		battery_ice.hide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and visible == true:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if has_remote() and has_battery():
				Notify.show_notification("There are no more items to take.")
				return
			else:
				if not has_remote():
					print("Remote Ice Clicked!")
					remote_ice.hide()
					InventoryManager.add_item("remote_ice")
				if not has_battery():
					print("Battery Ice Clicked!")
					battery_ice.hide()
					InventoryManager.add_item("battery_ice")
					
func has_remote() -> bool:
	return InventoryManager.items.has("remote_ice") or InventoryManager.items.has("remote")
	
func has_battery() -> bool:
	return InventoryManager.items.has("battery_ice") or InventoryManager.items.has("battery")
