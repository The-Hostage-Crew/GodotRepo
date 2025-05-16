extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Optional: run manually once when first shown
	if self.visible:
		animation_player.play("show")

func _on_visibility_changed() -> void:
	if self.visible:
		animation_player.play("show")
