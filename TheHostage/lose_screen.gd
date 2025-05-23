extends TextureRect


func _ready() -> void:
	SanitySystem.reset_sanity()
	HpSystem.reset_hp()

func _on_button_pressed() -> void:
	await get_tree().create_timer(1.0).timeout
	var MAIN = load("res://TheHostage/STAGE 1/main.tscn")
	get_tree().change_scene_to_packed(MAIN)
