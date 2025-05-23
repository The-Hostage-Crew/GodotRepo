extends Control

signal safebox_done

@onready var animation_rotator: AnimationPlayer = $AnimationRotator
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var safebox_puzzle: Control = $".."

@onready var sound_open: AudioStreamPlayer = $SoundOpen
@onready var sound_locked: AudioStreamPlayer = $SoundLocked

# the correct combination
var correct_values := {
	"Slider":  75,
	"Slider2": 25,
	"Slider3": 100,
	"Slider4": 25,
	"Slider5": 75,
	"Slider6": 50,
}

var current_values    := {}
var is_pattern_correct := false
var is_opened          := false

func _ready() -> void:
	var parent = get_parent()  # SafeboxPuzzle

	for name in correct_values.keys():
		var slider = parent.get_node_or_null(name)
		if slider:
			# 1) Connect its change-signal:
			slider.connect("value_changed", _on_slider_value_changed)

			# 2) Initialize with its real starting value:
			var init_val = slider.get_current_value()
			current_values[name] = init_val
			print("Init %s = %d" % [name, init_val])
		else:
			push_error("❌ Could not find slider node '%s'" % name)

	# 3) Compute whether the pattern is already correct from these inits:
	is_pattern_correct = _is_correct_pattern()


func _on_slider_value_changed(slider_name: String, value: int) -> void:
	current_values[slider_name] = value
	is_pattern_correct = _is_correct_pattern()

func _is_correct_pattern() -> bool:
	for name in correct_values:
		if current_values[name] != correct_values[name]:
			return false
	return true

func _on_rotator_pressed() -> void:
	print("Rotator pressed | opened? %s  pattern ok? %s" % [is_opened, is_pattern_correct])
	if is_pattern_correct:
		if not is_opened:
			unlock()
	else:
		animation_rotator.play("rotator_locked")
		sound_locked.play()
		SanitySystem.decrease_sanity(5)

func unlock() -> void:
	is_opened = true
	
	animation_rotator.play("rotator_spin")
	sound_open.play()
	await animation_rotator.animation_finished
	animation_player.play("scissor")
	await animation_player.animation_finished
	
	safebox_puzzle.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	InventoryManager.add_item("scissor")
	
	safebox_done.emit()


func lock() -> void:
	is_opened = false
	is_pattern_correct = false
