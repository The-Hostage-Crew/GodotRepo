extends Control

const MAIN_MENU = preload("res://TheHostage/MainMenu/MainMenu.tscn")
const MAIN = preload("uid://cqeuxvexway52")

@onready var fuzzy_text_animation: AnimatedSprite2D = $Hostages/Hostage1/FuzzyTextAnimation
@onready var fuzzy_text_animation2: AnimatedSprite2D = $Hostages/Hostage2/FuzzyTextAnimation
@onready var fuzzy_text_animation3: AnimatedSprite2D = $Hostages/Hostage3/FuzzyTextAnimation
@onready var intro_typing: ColorRect = $IntroTyping
@onready var animation_typing: AnimationPlayer = $IntroTyping/AnimationTyping

func _on_hostage_1_mouse_entered() -> void:
	AudioPlayer.play_sfx_hover()
	fuzzy_text_animation.visible = true
	fuzzy_text_animation.play("fuzzy")

func _on_hostage_1_mouse_exited() -> void:
	fuzzy_text_animation.visible = false
	fuzzy_text_animation.stop()


func _on_hostage_2_mouse_entered() -> void:
	AudioPlayer.play_sfx_hover()
	fuzzy_text_animation2.visible = true
	fuzzy_text_animation2.play("fuzzy")

func _on_hostage_2_mouse_exited() -> void:
	fuzzy_text_animation2.visible = false
	fuzzy_text_animation2.stop()


func _on_hostage_3_mouse_entered() -> void:
	AudioPlayer.play_sfx_hover()
	fuzzy_text_animation3.visible = true
	fuzzy_text_animation3.play("fuzzy")

func _on_hostage_3_mouse_exited() -> void:
	fuzzy_text_animation3.visible = false
	fuzzy_text_animation3.stop()


func _on_button_mouse_entered() -> void:
	AudioPlayer.play_sfx_hover()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)


func _on_hostage_pressed() -> void:
	AudioPlayer.stop()
	SanitySystem.reset_sanity()
	intro_typing.set_visible(true)
	animation_typing.play("typewriter")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(MAIN)
