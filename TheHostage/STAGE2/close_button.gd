extends Button

@onready var darken: ColorRect = $".."

func _on_pressed() -> void:
	darken.visible = false
