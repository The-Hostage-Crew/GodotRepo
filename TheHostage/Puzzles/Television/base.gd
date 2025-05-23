extends CanvasLayer
var count_click = 0
const max_channel = 4
var tv_on_state = false #TV is turn off
var current_channel = 0 #TV is turn off if this = 0
var isRemote = false #Status remote is currently equipped or not
var currentChild = ""
var animation_timer = 0.0  # Timer for texture animation
var current_texture_index = 0  # To track which texture is currently shown
var textures_to_animate = []  # Array to store texture names for animation
var is_glitching = false  # Flag to indicate if we're showing the glitch effect
var glitch_timer = 0.0  # Timer for the glitch effect
var next_channel = 0  # To store the next channel to change to after glitch
var channel_change_pending = false  # Flag to indicate a channel change is waiting
@onready var tv_area = $TVArea  # Reference to the TVArea Control node
@onready var tv_channels = $TVArea/Channels  # Reference to the Channels container
@onready var glitch_effect = null  # Reference to the glitch effect TextureRect
@onready var switch_sound = $SwitchSoundEffect  # Reference to the sound effect player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make sure both the TVArea and Channels container are visible
	if tv_area:
		tv_area.visible = true
		print("TVArea found and set visible")
		# Make sure the mouse filter is set to stop
		tv_area.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		print("ERROR: TVArea node not found")
		
	if tv_channels:
		# Only make channels visible if TV is on
		tv_channels.visible = tv_on_state
		print("Channels container found")
		# Make sure channels doesn't block input
		tv_channels.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		print("ERROR: Channels container not found")
	
	# Initialize the glitch effect if it exists
	if has_node("TVArea/Channels/GlitchEffect"):
		glitch_effect = $TVArea/Channels/GlitchEffect
		glitch_effect.visible = false
		glitch_effect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		print("Glitch effect TextureRect found and initialized")
	else:
		print("WARNING: GlitchEffect node not found, please add a TextureRect named 'GlitchEffect' to the Channels container")
	
	# Initialize the sound effect player if it exists
	if has_node("SwitchSoundEffect"):
		switch_sound = $SwitchSoundEffect
		print("Sound effect player found and initialized")
	else:
		print("WARNING: SwitchSoundEffect node not found, please add an AudioStreamPlayer named 'SwitchSoundEffect'")
		
	# Hide all channel textures initially since TV starts off
	hide_all_textures()
	
	# Connect input handling if remote is equipped
	if true:
		# Connect to the TVArea for input instead of the Channels container
		if !tv_area.is_connected("gui_input", Callable(self, "click_input_process")):
			tv_area.connect("gui_input", Callable(self, "click_input_process"))
			print("Connected gui_input signal")
	else:
		# Try to disconnect only if it was previously connected
		if tv_area.is_connected("gui_input", Callable(self, "click_input_process")):
			tv_area.disconnect("gui_input", Callable(self, "click_input_process"))
			
	print("TV initialized. On: ", tv_on_state, " Channel: ", current_channel)

func click_input_process(event):
	if event is InputEventMouseButton and check_remote_equipped():
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Click detected. Current channel: ", current_channel, " TV state: ", tv_on_state)
			
			# Determine the next channel or TV state
			if !tv_on_state:
				# If TV is off, we'll turn it on and set to channel 1
				next_channel = 1
				print("Will turn TV ON and set to channel 1")
			else:
				# If TV is on, cycle to next channel or turn off
				next_channel = current_channel + 1
				if next_channel > max_channel:
					next_channel = 0
					print("Will turn TV OFF")
				else:
					print("Will move to channel: ", next_channel)
			
			# Start the glitch effect and mark a channel change as pending
			is_glitching = true
			channel_change_pending = true
			glitch_timer = 0.0  # Reset the glitch timer
			
			# Show the glitch effect
			show_glitch_effect()
			
			# The actual channel change will happen in _process after the glitch effect
			
			# Ensure we get the next click by accepting the event
			get_viewport().set_input_as_handled()
	
func check_remote_equipped():
	#TO DO: WRITE LOGIC OF GLOBAL CHECKING REMOTE STATUS HERE
	if InventoryManager.items.has("battery") and InventoryManager.items.has("remote"):
		return true
	# For testing, always return true
	isRemote = InventoryManager.items.has("battery") and InventoryManager.items.has("remote")
	#print("Remote check: ", isRemote)
	return false
	
func show_channel():
	print("Show channel called for channel: ", current_channel)
	
	# Make sure the TV base is always visible
	if tv_area:
		tv_area.visible = true
	
	# Show the appropriate channel content based on current_channel
	if tv_on_state:
		# Make sure channels container is visible when TV is on
		if tv_channels:
			tv_channels.visible = true
			
		match current_channel:
			1:
				load_texture_single("Advertisement 1")
			2:
				load_texture_multiple("Advertisement 2", "Advertisement 3", 8)
			3:
				load_texture_single("Talk Show")
			4:
				load_texture_multiple("News 1", "News 2", 8)
			_:
				print("ERROR: Invalid channel number: ", current_channel)
	else:
		# TV is off - hide all channel textures
		hide_all_textures()
		print("TV is off, hiding all channels")
			
func load_texture_single(texture_name: String):
	print("Loading texture: ", texture_name)
	
	# Make sure the channels container is visible
	if tv_channels:
		tv_channels.visible = true
	
	# Loop through all children of the Channels container
	for child in tv_channels.get_children():
		if child is TextureRect:
			# Make sure texture rects don't block mouse input
			child.mouse_filter = Control.MOUSE_FILTER_IGNORE
			
			# Check if this is the channel we want to show
			if child.name == texture_name:
				child.visible = true
				currentChild = child.name
				print("Made visible: ", child.name)
			else:
				child.visible = false

func load_texture_multiple(texture_name_1: String, texture_name_2: String, max_loop: int):
	print("Loading multiple textures: ", texture_name_1, " and ", texture_name_2)
	
	# Make sure the channels container is visible
	if tv_channels:
		tv_channels.visible = true
	
	# Reset animation variables
	animation_timer = 0.0
	current_texture_index = 0
	is_glitching = false
	glitch_timer = 0.0
	
	# Store texture names to be animated
	textures_to_animate = [texture_name_1, texture_name_2]
	
	# Initially show the first texture and hide others
	for child in tv_channels.get_children():
		if child is TextureRect:
			# Make sure texture rects don't block mouse input
			child.mouse_filter = Control.MOUSE_FILTER_IGNORE
			
			# Skip glitch effect
			if child.name == "GlitchEffect":
				child.visible = false
				continue
				
			if child.name == texture_name_1:
				child.visible = true
				currentChild = child.name
				print("Initially showing: ", child.name)
			else:
				child.visible = false

func hide_all_textures():
	print("Hiding all textures")
	if tv_channels:
		for child in tv_channels.get_children():
			if child is TextureRect:
				child.visible = false
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle the glitch effect timing and channel changes
	if check_remote_equipped():
		$TVArea/Channels.visible = true
	else:
		$TVArea/Channels.visible = false
	if is_glitching:
		glitch_timer += delta
		
		# Glitch effect lasts for 0.2 seconds
		if glitch_timer >= 0.2:
			is_glitching = false
			
			# If this glitch was due to a channel change, apply the change now
			if channel_change_pending:
				channel_change_pending = false
				
				# Apply the pending channel change
				if next_channel == 0:
					# Turn off TV
					tv_on_state = false
					current_channel = 0
					print("TV turned OFF")
				else:
					# Change to the new channel
					tv_on_state = true
					current_channel = next_channel
					print("Changed to channel: ", current_channel)
				
				# Update the display
				show_channel()
			# If this was a glitch from the animation cycle
			elif tv_on_state and textures_to_animate.size() > 0 and (current_channel == 2 or current_channel == 4):
				# Show the next texture after glitching
				show_current_texture()
				
			# Hide the glitch effect
			if glitch_effect:
				glitch_effect.visible = false
				
			# Make sure sound stops if it's still playing (for very short sounds)
			# if switch_sound and switch_sound.is_playing() and switch_sound.get_playback_position() > 0.2:
			# 	switch_sound.stop()
	
	# Handle animation for multiple textures if TV is on and we have textures to animate
	elif tv_on_state and textures_to_animate.size() > 0 and (current_channel == 2 or current_channel == 4):
		# Only process animation if we're not glitching
		animation_timer += delta
		
		# Each texture stays visible for 1 second
		if animation_timer >= 1.0:
			animation_timer = 0.0
			
			# Show glitch effect between texture changes
			is_glitching = true
			glitch_timer = 0.0 # Reset the glitch timer
			
			# Update texture index for next time
			current_texture_index = (current_texture_index + 1) % textures_to_animate.size()
			
			# Show the glitch effect
			show_glitch_effect()

# Helper function to show the current texture
func show_current_texture():
	if tv_channels and current_texture_index < textures_to_animate.size():
		for child in tv_channels.get_children():
			if child is TextureRect:
				if child.name == textures_to_animate[current_texture_index]:
					child.visible = true
					currentChild = child.name
					print("Showing texture: ", child.name)
				elif child.name != "GlitchEffect":
					child.visible = false

# Helper function to show the glitch effect
func show_glitch_effect():
	if glitch_effect and $".".visible == true:
		# Hide all regular textures
		for child in tv_channels.get_children():
			if child is TextureRect and child.name != "GlitchEffect":
				child.visible = false
		
		# Show the glitch effect
		glitch_effect.visible = true
		
		# Play the channel switch sound
		if switch_sound and switch_sound.stream and Global.in_modal:
			switch_sound.play()
			await get_tree().create_timer(0.2).timeout
			switch_sound.stop()
			print("Playing switch sound effect")
		
		print("Showing glitch effect")
