extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var showed := false

func _on_visibility_changed() -> void:
	if self.visible:
		audio_stream_player.play()
		animation_player.play("show")
		if !showed:
			await get_tree().create_timer(1.0).timeout
			Notify.show_notification("Hmm.. an old photo.")
			Notify.show_notification("The heights of these people seem peculiar. Would that be useful?")
			showed = true
