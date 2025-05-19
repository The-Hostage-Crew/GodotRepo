extends Node2D

var timestamp
@onready var timer := $Timer
var notif1 = true #boolean chat pertama luna
var timer_bool = false #inisiai timer untuk jeda tiap chat 

@onready var download_button := $"ScrollContainer/VBoxContainer/3/MarginContainer2/VBoxContainer/download button/on"
@onready var show_button :=$"ScrollContainer/VBoxContainer/3/MarginContainer2/VBoxContainer/download button/show_on"
var counter := 1
var download = false
var click = 1


func _ready() :
	#nanti hapus
	$"ScrollContainer/VBoxContainer/1".visible = false
	$"ScrollContainer/VBoxContainer/2".visible = false
	$"ScrollContainer/VBoxContainer/3".visible = false
	$"ScrollContainer/VBoxContainer/4".visible = false
	$"ScrollContainer/VBoxContainer/5".visible = false
	$"ScrollContainer/VBoxContainer/6".visible = false
	$"ScrollContainer/VBoxContainer/7".visible = false


	#inisiasi timer
	timer.wait_time = 1.0
	timer.one_shot = true  # Pastikan hanya sekali
	timer.timeout.connect(_on_timer_timeout)

func _process(delta):

	#timestamp 
	var time_dict = Time.get_time_dict_from_system()
	var hour = "%02d" % time_dict.hour
	var minute = "%02d" % time_dict.minute
	timestamp =  "%s:%s" % [hour, minute]
	
	if  notif1 && Global.edgar_count == 13 :
			$"ScrollContainer/VBoxContainer/1".visible = true
			$"ScrollContainer/VBoxContainer/1/MarginContainer2/TextureRect/Control/Label".text = "Hi, " + Global.user_name + "!"
			Global.last_chat_xxx = "Hi, " + Global.user_name + "!"
			var time_now = timestamp
			Global.xxx_new = true
			$"ScrollContainer/VBoxContainer/1/Vbox/time".text = time_now
			Global.xxx = true
			if Global.chat_xxx :
				timer_bool = true
				notif1 = false
			
	if timer_bool : # waiting untuk jeda tiap balasan winda
			Global.winda_writing = true #aktifkan winda sedang mengetik
			timer.start()
			timer_bool = false
			#print("error di time_bool winda")
			
	if Global.chat_xxx : #chat winda lagi di buka
		if Global.xxx_reply : #klo chatnya winda bisa dibales 
			#if Global.winda_count == 1 && Global.chat_winda_count == 1:
				#$"ScrollContainer/VBoxContainer/3".visible = true # bukan gw kakaknya
				#var time_now = timestamp
				#$"ScrollContainer/VBoxContainer/3/Vbox/time".text = time_now
				#Global.last_chat_winda = "Bukan. Gw kakaknya"
				#Global.winda_new = false
				#Global.reply = false
				#Global.winda_reply = false
				#timer_bool = true
			pass

			#else :
				#pass
				#print("error di reply winda" + str(Global.winda_count) +str(Global.chat_winda_count))
				
				
func _on_timer_timeout() -> void:
	Global.xxx_writing = false
	var num = Global.xxx_count
	
	if num == 0 :
		Global.xxx_new = true
		$"ScrollContainer/VBoxContainer/2".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/2/Vbox/time".text = time_now
		AudioPlayer.play_notif()
		Global.last_chat_xxx= "There's a new stage in The Hostage!"
		timer_bool = true
		Global.xxx_count +=1
	elif num == 1:
		$"ScrollContainer/VBoxContainer/3".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/3/Vbox/time".text = time_now
		AudioPlayer.play_notif()
		Global.last_chat_xxx= "The XXX send a file"
		Global.xxx_count +=1
		timer_bool = true
	elif num == 2:
		$"ScrollContainer/VBoxContainer/4".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/4/Vbox/time".text = time_now
		AudioPlayer.play_notif()
		Global.last_chat_xxx= "or die :)"
		Global.xxx_count +=1
		timer_bool = true
	elif num == 3:
		$"ScrollContainer/VBoxContainer/5".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/5/Vbox/time".text = time_now
		AudioPlayer.play_notif()
		Global.last_chat_xxx= "You have one hour from now before the file expires :)"
		Global.xxx_count +=1
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		
	else :
		print("error di timeout winda")
		print(Global.winda_count)
		print(Global.chat_winda_count)
		


func _on_area_download_mouse_entered() -> void:
	download_button.visible = true
	if download : 
		show_button.visible = true

func _on_area_download_mouse_exited() -> void:
	download_button.visible = false
	if download : 
		show_button.visible = false


func _on_area_download_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed :
		AudioPlayer.play_click()
		click +=1
		if click == 2 : 
			Global.xxx_new = false
		$"ScrollContainer/VBoxContainer/3/MarginContainer2/VBoxContainer/download button/downloading".visible = true
		while counter <= 100:
			$"ScrollContainer/VBoxContainer/3/MarginContainer2/VBoxContainer/download button/downloading/Label".text = str(counter) + "%"
			counter += 1
			if counter == 24 :
				Global.glitch = true
			elif counter == 87 :
				$"ScrollContainer/VBoxContainer/7".visible = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/7/Vbox/time".text = time_now
				Global.last_chat_xxx = "Good luck!!!"
				AudioPlayer.play_notif()
				Global.glitch = false
			await get_tree().create_timer(0.05).timeout  # jeda 0.05 detik antar angka
		download = true
		$"ScrollContainer/VBoxContainer/3/MarginContainer2/VBoxContainer/download button/show".visible = true
		if Global.stage2 == false : 
			Global.TheHostage_icon = true
		if click >2 && download && Global.stage2 == false: 
			Global.xxx_new = false
			Global.my_echo_app = false
