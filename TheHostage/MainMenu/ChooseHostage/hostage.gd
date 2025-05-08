extends TextureButton

const MAIN = preload("uid://cqeuxvexway52")

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN)
