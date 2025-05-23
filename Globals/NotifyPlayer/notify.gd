extends CanvasLayer

@onready var label: Label = $Label
@onready var animation_label: AnimationPlayer = $AnimationLabel

var notification_queue: Array[String] = [] # Array to store pending notification messages
var is_currently_showing: bool = false # Flag to track if a notification is active

func _ready():
	label.text = "" # Ensure label is empty initially
	label.visible_ratio = 0 # Ensure label is not visible initially

# Call this function from other scenes to show a notification
func show_notification(message_text: String):
	# Jangan tambahkan ke queue kalau sudah aktif dan pesan sama dengan yang sedang tampil
	if is_currently_showing and message_text == label.text:
		print("Notification ignored (duplicate while showing): '", message_text, "'")
		return
	
	# Cek jika message sudah ada di queue, skip
	if message_text in notification_queue:
		print("Notification ignored (duplicate in queue): '", message_text, "'")
		return

	if is_currently_showing:
		notification_queue.append(message_text)
		print("Notification queued: '", message_text, "'")
	else:
		_display_message(message_text)


func _display_message(message_text: String):
	is_currently_showing = true
	label.text = message_text

	
	if animation_label and animation_label.has_animation("notify"):
		animation_label.play("notify")
	else:
		print_rich("[color=red]Error: Animation 'notify' not found in AnimationPlayer node.[/color]")
		label.visible_ratio = 1.0
		var timer = get_tree().create_timer(2.0) # Show for 2 seconds if no animation
		timer.timeout.connect(_on_animation_finished.bind("notify")) # Manually call with "notify"

func _on_animation_finished(anim_name: StringName):
	if anim_name == "notify":
		print("Notify animation finished for: '", label.text, "'")
		# Current notification has finished
		
		if not notification_queue.is_empty():
			# If there are messages in the queue, get the next one
			var next_message = notification_queue.pop_front() # Get and remove the first item
			_display_message(next_message)
		else:
			# No more messages in the queue
			is_currently_showing = false
			label.text = "" # Clear text after the last notification
			label.visible_ratio = 0 # Ensure it's hidden
			print("Notification queue empty.")

func get_is_notifying():
	return is_currently_showing
