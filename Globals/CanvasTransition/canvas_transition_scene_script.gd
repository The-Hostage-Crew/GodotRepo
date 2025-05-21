extends CanvasLayer

signal canvas_finished

@onready var animation_transition: AnimationPlayer = $AnimationTransition
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	self.layer = 10
	self.visible = false

func fade_in():
	self.visible = true
	animation_transition.play("fade_in")
	await animation_transition.animation_finished
	canvas_finished.emit()

func fade_out():
	self.visible = true
	animation_transition.play("fade_out")
	await animation_transition.animation_finished
	canvas_finished.emit()
