extends Control

signal pinboard_done

var red_texture_controller
var correct_result_controller
var incorrect_result_controller
var mouse_click_connected = false
var pinboard
var c_d_clicked = false  # Track if C and D combo has been detected
var u1_t4_clicked = false
var u2_t5_clicked = false
var scissor_sound_player  # Reference to the AudioStreamPlayer
# Letters that SHOULD be cut (these will be hidden)
const correct_answer = ["C","D", "E1", "E2", "E3", "N1", "N2", "A", "H"] 
const correct_answer_num = 32348243  # For evaluation
var cut_combination_answer = []  # Tracks which letters are currently cut
var have_scissor := false

func _ready() -> void:
	# Connect button signals when scene loads
	for child in self.get_children():
		if child is Button:
			var button_name := child.name
			child.pressed.connect(func(): _on_button_pressed(button_name))
	
	# Get references to required nodes
	pinboard = self.get_parent()
	red_texture_controller = pinboard.get_node("RedTextureController")
	incorrect_result_controller = pinboard.get_node("IncorrectResultController")
	correct_result_controller = pinboard.get_node("CorrectResultController")
	
	# Get reference to the AudioStreamPlayer
	scissor_sound_player = pinboard.get_node("ScissorCut")
	
	# Make sure initial state is correct - don't show any result nodes initially
	for child in correct_result_controller.get_children():
		child.visible = false
	for child in incorrect_result_controller.get_children():
		child.visible = false
	
	if incorrect_result_controller:
		incorrect_result_controller.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if correct_result_controller:
		correct_result_controller.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
	# Also set it for all their children
	for child in incorrect_result_controller.get_children():
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child in correct_result_controller.get_children():
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE
			
func _on_button_pressed(button_name: String):
	if not check_scissor_equipped():
		if !Notify.get_is_notifying():
			Notify.show_notification("Need to something to cut it with..")
		print("Scissors not equipped!")
		return
		
	# Find the corresponding letter node in RedTextureController
	var letter_node = null
	for child in red_texture_controller.get_children():
		if child.name == button_name:
			letter_node = child
			break
	
	if letter_node:
		# Toggle cut state
		if button_name in cut_combination_answer:
			# Letter is cut, un-cut it
			cut_combination_answer.erase(button_name)
			letter_node.visible = true
			numerical_texture_layer_helper(button_name, false) #turn off the numerical texture
		else:
			# Letter is not cut, cut it
			cut_combination_answer.append(button_name)
			letter_node.visible = false
			numerical_texture_layer_helper(button_name, true) # turn on the numerical texture
			
			# Play scissor cut sound
		play_scissor_sound()
		
		# Check if both C and D have been clicked
		check_c_d_combination()
		check_u1_t4_combination()
		check_u2_t5_combination()
		# After changing the state, check if the puzzle is solved
		check_solution()

# Function to play scissor sound for 0.5 seconds
func play_scissor_sound():
	if scissor_sound_player:
		scissor_sound_player.play()
		
		# Create a timer to stop the sound after 0.5 seconds
		var timer = get_tree().create_timer(0.5)
		timer.timeout.connect(func(): scissor_sound_player.stop())

func check_u1_t4_combination():
	# Check if both C and D are in cut_combination_answer
	if "U1" in cut_combination_answer and "T4" in cut_combination_answer and !u1_t4_clicked:
		u1_t4_clicked = true
		print("Both U1 and T4 have been clicked!")
		numerical_texture_layer_helper("6A", true)
		# You can add additional effects or triggers here
		# For example, you could show a special message or activate something
		
		# Example: You could show a special visual effect
		# pinboard.get_node("SpecialEffect").visible = true
	elif not ("U1" in cut_combination_answer and "T4" in cut_combination_answer) and u1_t4_clicked:
		# Reset if one of C or D is unclicked
		u1_t4_clicked = false
		print("U1 and T4 combination broken")
		numerical_texture_layer_helper("6A", false)

		# After changing the state, check if the puzzle is solved
		#check_solution()

func check_u2_t5_combination():
	# Check if both C and D are in cut_combination_answer
	if "U2" in cut_combination_answer and "T5" in cut_combination_answer and !u2_t5_clicked:
		u2_t5_clicked = true
		print("Both U2 and T5 have been clicked!")
		numerical_texture_layer_helper("6B", true)
		# You can add additional effects or triggers here
		# For example, you could show a special message or activate something
		
		# Example: You could show a special visual effect
		# pinboard.get_node("SpecialEffect").visible = true
	elif not ("U2" in cut_combination_answer and "T5" in cut_combination_answer) and u2_t5_clicked:
		# Reset if one of C or D is unclicked
		u2_t5_clicked = false
		print("U2 and T5 combination broken")
		numerical_texture_layer_helper("6B", false)

func check_c_d_combination():
	# Check if both C and D are in cut_combination_answer
	if "C" in cut_combination_answer and "D" in cut_combination_answer and !c_d_clicked:
		c_d_clicked = true
		print("Both C and D have been clicked!")
		numerical_texture_layer_helper("8", true)
		# You can add additional effects or triggers here
		# For example, you could show a special message or activate something
		
		# Example: You could show a special visual effect
		# pinboard.get_node("SpecialEffect").visible = true
	elif not ("C" in cut_combination_answer and "D" in cut_combination_answer) and c_d_clicked:
		# Reset if one of C or D is unclicked
		c_d_clicked = false
		print("C and D combination broken")
		numerical_texture_layer_helper("8", false)
		# Hide any special effects here if needed

func numerical_texture_layer_helper(buttonName: String, state: bool):
	var in_incorrect = incorrect_result_controller.has_node(buttonName)
	var in_correct = correct_result_controller.has_node(buttonName)
	var child
	
	if in_incorrect and !in_correct:
		# get the corresponding child from IncorrectResultController
		child = incorrect_result_controller.get_node(buttonName)
		if state: deal_damage_to_HUD()
	elif in_correct and !in_incorrect:
		# get the corresponding child from CorrectResultController
		child = correct_result_controller.get_node(buttonName)
	
	if child:
		# Set visibility directly - we're managing individual nodes
		child.visible = state
		print("Setting visibility of " + buttonName + " to " + str(state))
	
func check_solution():
	# Determine which letters should NOT be cut (not in correct_answer)
	var all_letters = []
	for child in red_texture_controller.get_children():
		if child is Control:  # Assuming letters are Control nodes
			all_letters.append(child.name)
	
	var should_not_be_cut = []
	for letter in all_letters:
		if letter not in correct_answer:
			should_not_be_cut.append(letter)
	
	# Check if the solution is correct
	var is_correct = true
	
	# 1. All letters that SHOULD be cut (in correct_answer) must be in cut_combination_answer
	for letter in correct_answer:
		if letter not in cut_combination_answer:
			is_correct = false
			break
	
	# 2. All letters that should NOT be cut must NOT be in cut_combination_answer
	if is_correct:
		for letter in should_not_be_cut:
			if letter in cut_combination_answer:
				is_correct = false
				break
	
	if is_correct:
		print("Puzzle solved! Code: ", correct_answer_num)
		# Trigger success event
		reveal_correct_result()
	

func reveal_correct_result():
	# Show the correct result
	pinboard.get_node("White_correct_result").visible = true
	#pinboard.get_node("White_peritilan").visible = true
	pinboard.get_node("White_glow").visible = true
	pinboard.get_node("Peritilan").visible = false
	red_texture_controller.visible=false
	correct_result_controller.visible=false
	incorrect_result_controller.visible=false
	pinboard_done.emit()
	#if correct_result_controller:
		#for child in correct_result_controller.get_children():
			#child.visible = true

func deal_damage_to_HUD():
	#TO DO: call interface for HUD
	pass

func check_scissor_equipped():
	if have_scissor:
		return true
	else:
		return false

func set_scissor_true():
	have_scissor = true
	
