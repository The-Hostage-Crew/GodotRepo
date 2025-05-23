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
			Notify.show_notification("Oh. An old photo.")
			Notify.show_notification("Daniel: Hmmm. Something about their heights... and the color of their shirts?")
			Notify.show_notification("Daniel: Why are their faces gone?")
			showed = true
