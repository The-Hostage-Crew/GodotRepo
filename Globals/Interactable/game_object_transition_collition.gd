extends Interactable

@export var modal: Node
@export var trauma_viewport: VideoStreamPlayer
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
			modal.set_visible(true)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			showed = true
		else:
			modal.set_visible(false)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			showed = false
	else:
		print("MODAL NOT FOUND")
