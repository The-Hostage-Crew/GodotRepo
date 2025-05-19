extends Node2D

@onready var timer = $Desktop/Timer
@onready var sprite = $Desktop/AnimatedSprite2D
@onready var myecho_stage1 = $Desktop/myecho_stage1
@onready var area_notif =$Desktop/area_notification
@onready var myecho_true = $TaskBar/HBoxContainer/MyEcho/myecho_true  # Memperbaiki referensi myecho_true
@onready var area_myecho = $TaskBar/myecho  # Memperbaiki referensi area_myecho
@onready var TheHostage_icon : Node2D = $Desktop/TheHostage_Icon
var stage1_pass = true
var luna_notif_click = true

var timer_bool = true

func _ready():
	# Set durasi timer ke 2 detik dan nyalakan
	sprite.play("default")
	$Desktop/area_notification.visible = false
	
func _process(delta: float) -> void:
	
	if Global.glitch : 
		$Glitch.visible = true
	else :
		$Glitch.visible = false
		
		
	if timer_bool : 
		timer.wait_time = 2.0
		timer.one_shot = true
		timer.start()
		timer_bool = false
		
	if Global.reply == true :
		sprite.visible = false
	if Global.TheHostage_icon :
		TheHostage_icon.visible = true
	else : 
		TheHostage_icon.visible = false
		
	if Global.my_echo_app :
		myecho_stage1.visible = true  # Tampilkan myecho_stage1 jika sebelumnya tidak terlihat
	else:
		myecho_stage1.visible = false  # Sembunyikan myecho_stage1 jika sebelumnya terlihat
		
	if Global.stage1 && stage1_pass : #buat inisiasi chatnya Luna after stage1
		timer_bool = true
		stage1_pass = false
		
	
	
func _on_timer_timeout() -> void:
	if Global.stage1 == false : 
		sprite.play("edgar_first_chat_animation")
		AudioPlayer.play_notif()
		area_notif.visible = true
		Global.edgar = true
	elif Global.stage1 == true : #chat luna
		sprite.visible = true
		sprite.play("luna_first_chat_animation")
		AudioPlayer.play_notif()
		$Desktop/area_notification.visible = true
		Global.luna = true
		

func _on_area_edgar_first_chat_mouse_entered() -> void:
	if Global.stage1 == false : 
		sprite.play("edgar_first_chat_on")
	elif Global.stage1 == true :
		sprite.play("luna_first_chat_on")

func _on_area_edgar_first_chat_mouse_exited() -> void:
	if Global.stage1 == false : 
		sprite.play("edgar_first_chat")
	elif Global.stage1 == true :
		sprite.play("luna_first_chat")
		
func _on_area_edgar_first_chat_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if Global.stage1 == false : #jika stage 1 belum pass
			# Jika diklik, tampilkan myecho_stage1 dan sembunyikan area_edgar_first_chat
			myecho_stage1.visible = true
			$Desktop/area_notification.visible = false
			Global.my_echo = true 
			Global.my_echo_app = true
			Global.chat_edgar = true
			myecho_true.visible = true  # Memastikan myecho_true ditampilkan
			sprite.visible = false
			AudioPlayer.play_click()
		elif Global.stage1 == true && luna_notif_click == true : #jika stage 1 sudah terlewati dan notir luna blm di klik 
			myecho_stage1.visible = true #buka my echo
			$Desktop/area_notification.visible = false #area cliknya di matikan
			Global.my_echo = true 
			Global.my_echo_app = true
			myecho_true.visible = true  # Memastikan myecho_true ditampilkan
			sprite.visible = false
			luna_notif_click = false
			Global.luna = true
			Global.luna_new =true
			Global.chat_luna = true
			Global.chat_edgar = false
			Global.chat_winda = false
			AudioPlayer.play_click()
			

func _on_myecho_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		AudioPlayer.play_click()
		if myecho_stage1.visible == false:
			Global.my_echo_app = true  # Tampilkan myecho_stage1 jika sebelumnya tidak terlihat
		else:
			Global.my_echo_app = false  # Sembunyikan myecho_stage1 jika sebelumnya terlihat
