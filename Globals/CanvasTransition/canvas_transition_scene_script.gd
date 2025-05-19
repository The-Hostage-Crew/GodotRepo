extends CanvasLayer

@onready var animation_transition: AnimationPlayer = $AnimationTransition
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	self.layer = 10
	self.visible = false

func fade_in():
	self.visible = true
	animation_transition.play("fade_in")
	await animation_transition.animation_finished
	self.queue_free()

func fade_out():
	self.visible = true
	animation_transition.play("fade_out")
	await animation_transition.animation_finished
	self.queue_free()
