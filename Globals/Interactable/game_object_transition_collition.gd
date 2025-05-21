extends Interactable

@export var modal: Node
@export var trauma_viewport: VideoStreamPlayer

@onready var player: CharacterBody3D = %Player

# Nullable use if player not found
@export var player_ref: CharacterBody3D

var showed := false
var tirai_timer := Timer.new()

func _ready() -> void:
	add_child(tirai_timer)
	tirai_timer.timeout.connect(_on_tirai_timer_timeout)

func interact() -> void:
	if modal:
		var is_tirai: bool = modal.name == "tiraitertutup"

		if is_tirai:
			print(tirai_timer)
			modal.set_visible(true)
			Notify.show_notification("GET OFF OF ME!!!")
			showed = true
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
		print(modal)
		print("MODAL NOT FOUND")

func _on_tirai_timer_timeout():
	SanitySystem.decrease_sanity(5.0)
