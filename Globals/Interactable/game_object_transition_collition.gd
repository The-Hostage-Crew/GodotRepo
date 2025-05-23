extends Interactable

@export var modal: Node
@export var trauma_viewport: VideoStreamPlayer
@export var music_button: Button
@export var mesh: MeshInstance3D

# Nullable use if player not found
@export var player_ref: CharacterBody3D

var showed := false
var tirai_timer := Timer.new()
var confirm_curtain := false

func _ready() -> void:
	add_child(tirai_timer)
	tirai_timer.timeout.connect(_on_tirai_timer_timeout)

func interact() -> void:
	if modal:
		var is_tirai: bool = modal.name == "tiraitertutup"

		if is_tirai:
			mesh.position.z = -19
			modal.set_visible(true)
			showed = false
			Notify.show_notification("GET OFF OF ME!!!")
			trauma_viewport.stream = load("res://assets/TheHostage/2D/constraint_[trauma]/ConstraintTraumaEnemyAngryAudio.ogv")
			trauma_viewport.custom_minimum_size = Vector2(1920, 1080)  # ✅

			trauma_viewport.play()
			await get_tree().create_timer(1.5).timeout
			modal.set_visible(false)
			showed = false
			
			# Start sanity decrease timer
			tirai_timer.wait_time = 5.0
			tirai_timer.one_shot = false
			tirai_timer.start()

			return

		if !showed:
			if player_ref:
				player_ref.set_movement_enabled(false)
				if Global.is_stage2_safebox_done == true:
					if music_button:
						music_button.visible = true
			
			if modal.name == "WithRemote":
				if Global.is_remote == true:
					pass
				else:
					pass
			Global.in_modal = true
			modal.set_visible(true)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			showed = true
		else:
			if player_ref:
				player_ref.set_movement_enabled(true)
				
			Global.in_modal = false
			modal.set_visible(false)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			showed = false
	else:
		print(modal)
		print("MODAL NOT FOUND")

func _on_tirai_timer_timeout():
	SanitySystem.decrease_sanity(5.0)
