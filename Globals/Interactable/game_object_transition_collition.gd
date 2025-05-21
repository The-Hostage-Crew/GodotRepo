extends Interactable

@export var modal: Node
@export var trauma_viewport: VideoStreamPlayer

@onready var player: CharacterBody3D = %Player

# Nullable use if player not found
@export var player_ref: CharacterBody3D

var showed := false


func interact() -> void:
	if modal:
		var is_tirai: bool = modal.name == "tiraitertutup"

		if is_tirai:
			modal.set_visible(true)
			showed = true
			trauma_viewport.stream = load("res://assets/TheHostage/2D/constraint_[trauma]/ConstraintTraumaEnemyAngry.ogv")
			trauma_viewport.play()
			await get_tree().create_timer(1.5).timeout
			modal.set_visible(false)
			showed = false
			return

		# Logika untuk selain tirai
		if !showed:
			if player_ref:
				player_ref.set_movement_enabled(false)
			else:
				player.set_movement_enabled(false)
				
			modal.set_visible(true)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			showed = true
		else:
			if player_ref:
				player_ref.set_movement_enabled(true)
			else:
				player.set_movement_enabled(true)
				
			modal.set_visible(false)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			showed = false
	else:
		print("MODAL NOT FOUND")
