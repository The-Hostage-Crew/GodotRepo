extends ColorRect


func _on_play_again_pressed() -> void:
	Global.reset()
	SanitySystem.reset_sanity()
	HpSystem.reset_hp()
	get_tree().change_scene_to_file("res://Desktop/MainMenu/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
