extends Control

var showed := false

func _on_visibility_changed() -> void:
	if !showed:
		Notify.show_notification("Need a passcode huh...")
		showed = true
