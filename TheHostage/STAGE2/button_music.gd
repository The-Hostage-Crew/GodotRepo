extends Button
@onready var darken: ColorRect = $Darken


func _on_pressed() -> void:
	darken.visible = true
	
