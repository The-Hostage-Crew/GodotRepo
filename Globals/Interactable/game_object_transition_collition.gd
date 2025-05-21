extends Interactable

@export var modal: Node
@export var trauma_viewport: VideoStreamPlayer

@onready var player: CharacterBody3D = %Player
@onready var knock_timer := $DoorKnockAudio/DoorTimer
@onready var knock_audio := $DoorKnockAudio

var showed := false


func _on_knock_timer_timeout():
	# Only play if audio isn't already playing (prevent overlap)
	print("KNOCK")
	knock_audio.play()
	#knock_timer.start()

func interact() -> void:
	if modal:
		var is_tirai: bool = modal.name == "tiraitertutup"

		if is_tirai:
			modal.set_visible(true)
			showed = true
			trauma_viewport.stream = load("res://assets/TheHostage/2D/constraint_[trauma]/ConstraintTraumaEnemyAngryAudio.ogv")
			trauma_viewport.custom_minimum_size = Vector2(1920, 1080)  # ✅

			trauma_viewport.play()
			await get_tree().create_timer(1.5).timeout
			modal.set_visible(false)
			showed = false
			return

		if !showed:
			player.set_movement_enabled(false)
			modal.set_visible(true)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			showed = true
		else:
			player.set_movement_enabled(true)
			modal.set_visible(false)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			showed = false
	else:
		print("MODAL NOT FOUND")


func _on_door_knock_audio_finished() -> void:
	knock_timer.start()
