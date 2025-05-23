extends Node2D

var put_first = "remote" # or "battery"
var num_clicks = 0

var thaw_state = 0
var thaw_timer = 0.0
var thawing_active = false
var thawing_finish = false

var has_ice := false
@export var puzzle_container : Interactable

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and visible == true:
		if not check_scissor_equipped():
			Notify.show_notification("You don't have the necessary equipment for this")
			return
			
		if thawing_active:
			print("Thawing in progress. Please wait.")
			return

		if thawing_finish:
			$Stove/Stove/AnimatedSprite2D.play("base")
			thawing_finish = false
			InventoryManager.remove_item("remote_ice")
			InventoryManager.remove_item("battery_ice")
			InventoryManager.add_item("remote")
			InventoryManager.add_item("battery")
			return

		num_clicks += 1
		print("Click: ",num_clicks)

		match num_clicks:
			1:
				match put_first:
					"remote":
						$Stove/Stove/AnimatedSprite2D.play("remote_first")
					"battery":
						$Stove/Stove/AnimatedSprite2D.play("battery_first")
			2:
				start_thawing()
			3:
				has_ice = false
				puzzle_container.interact()


func _process(delta: float) -> void:
	if thawing_active:
		thaw_timer += delta

		match thaw_state:
			1:
				if thaw_timer >= 3.0:
					advance_to_thawing()

			2:
				if thaw_timer >= 2.5:
					advance_to_thaw_finish()

			3:
				if thaw_timer >= 2.5:
					complete_thawing()

func start_thawing():
	thawing_active = true
	thaw_state = 1
	thaw_timer = 0.0
	$Stove/Stove/AnimatedSprite2D.play("remote_and_battery")

func advance_to_thawing():
	thaw_state = 2
	thaw_timer = 0.0
	$Stove/Stove/AnimatedSprite2D.play("thawing")

func advance_to_thaw_finish():
	thaw_state = 3
	thaw_timer = 0.0
	$Stove/Stove/AnimatedSprite2D.play("thaw_finish")

func complete_thawing():
	thawing_active = false
	thawing_finish = true
	print("Thawing complete!")
	Global.is_remote = true


func check_scissor_equipped():
	if InventoryManager.items.has("remote_ice") and InventoryManager.items.has("battery_ice"):
		return true
	else:
		return false

func set_scissor_true():
	has_ice = true
