extends Node2D
@export var player_ref: CharacterBody3D

var correct_sequence = [
	"black 8", "black 9", "white 13", "black 8",
	"white 13", "black 9", "black 11", "white 13", "black 8"
]

var current_sequence = []
var expected_index := 0
var failed := false
var lose_counter := 0

func register_click(color: String, number: int) -> void:
	var entry = "%s %d" % [color, number]

	if entry == correct_sequence[expected_index]:
		expected_index += 1
		# Player can play piano pattern correctly
		if expected_index == correct_sequence.size():
			self.visible = false
			player_ref.set_movement_enabled(true)
			$NormalAudio2.stop()
			$Scary1Audio2.stop()
			$Scary2Audio2.stop()
			expected_index = 0
	else:
		lose()


func lose() -> void:
	# Always stop and reset all audio first
	$NormalAudio2.stop()
	$Scary1Audio2.stop()
	$Scary2Audio2.stop()
	$NormalAudio2.seek(0)
	$Scary1Audio2.seek(0)
	$Scary2Audio2.seek(0)

	# Play audio based on current lose counter
	lose_counter += 1
	match lose_counter:
		0:
			$NormalAudio2.play()
		1:
			$Scary1Audio2.play()
			SanitySystem.decrease_sanity(10.0)
		2:
			$Scary2Audio2.play()
			SanitySystem.decrease_sanity(10.0)


	# Increment and reset if necessary
	#print("lose count:", lose_counter)

	if lose_counter > 2:
		print("RESET!")
		SanitySystem.decrease_sanity(30.0)
		self.visible = false
		player_ref.set_movement_enabled(true)
		lose_counter = 0
		$NormalAudio2.play()

	expected_index = 0



# ----------------------
# BLACK KEYS
# ----------------------

func _on_black1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/1".play()
		lose()

func _on_black2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/2".play()
		lose()
func _on_black3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/3".play()
		lose()
func _on_black4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/4".play()
		lose()
func _on_black5_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/5".play()
		lose()
func _on_black6_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/6".play()
		lose()
func _on_black7_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/7".play()
		lose()
func _on_black8_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/8".play()
		register_click("black", 8)

func _on_black9_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/9".play()
		register_click("black", 9)

func _on_black10_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/10".play()
		lose()
func _on_black11_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/11".play()
		register_click("black", 11)

func _on_black12_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_black/12".play()
		lose()
# ----------------------
# WHITE KEYS
# ----------------------

func _on_white1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/1".play()
		lose()
func _on_white2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/2".play()
		lose()
func _on_white3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/3".play()
		lose()
func _on_white4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/4".play()
		lose()
func _on_white5_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/5".play()
		lose()
func _on_white6_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/6".play()
		lose()
func _on_white7_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/7".play()
		lose()
func _on_white8_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/8".play()
		lose()
func _on_white9_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/9".play()
		lose()
func _on_white10_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/10".play()
		lose()
func _on_white11_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/11".play()
		lose()
func _on_white12_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/12".play()
		lose()
func _on_white13_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/13".play()
		register_click("white", 13)

func _on_white14_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/14".play()
		lose()
func _on_white15_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/15".play()
		lose()
func _on_white16_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"sound_white/16".play()
		lose()
