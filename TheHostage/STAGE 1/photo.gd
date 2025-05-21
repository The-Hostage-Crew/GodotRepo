extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var showed := false

func _ready() -> void:
	# Optional: run manually once when first shown
	if self.visible:
		animation_player.play("show")

func _on_visibility_changed() -> void:
	if self.visible:
		if !showed:
			Notify.show_notification("Hmm.. an old photo")
			showed = true
		audio_stream_player.play()
		animation_player.play("show")
		
		# Debug Sanity System, remove later
		#SanitySystem.decrease_sanity(10.0)
