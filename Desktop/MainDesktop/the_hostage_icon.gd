extends Node2D

@onready var icon_on: TextureRect = $icon_on
@onready var connecting_animation: AnimatedSprite2D = $connecting_animation
@onready var timer: Timer = $Timer

const MAIN_MENU_SCENE = "res://TheHostage/MainMenu/MainMenu.tscn"

var last_click_time := 0.0
const DOUBLE_CLICK_THRESHOLD := 0.3  # detik

var is_transitioning := false

func _on_area_2d_mouse_entered() -> void:
	icon_on.visible = true

func _on_area_2d_mouse_exited() -> void:
	icon_on.visible = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if is_transitioning:
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var current_time = Time.get_ticks_msec() / 1000.0
		$mouse_click2.play()
		if current_time - last_click_time <= DOUBLE_CLICK_THRESHOLD:
			is_transitioning = true
			connecting_animation.visible = true
			connecting_animation.play("connect")  # pastikan animasi "connect" ada di AnimatedSprite2D
			timer.start(2.0)  # Timer akan hitung mundur 3 detik
		else:
			Global.stage1 = true
			Global.TheHostage_icon = false
		last_click_time = current_time

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)
