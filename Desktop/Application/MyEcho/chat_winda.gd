extends Node2D

var timestamp
@onready var timer := $Timer
var notif1 = true #boolean chat pertama luna
var time_bool = false #inisiai timer untuk jeda tiap chat 
var notif_sfx = true

func _ready() :
	if Global.stage1 == false :
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
	
	if Global.chat_edgar_count == 1 && notif1 :
			$"ScrollContainer/VBoxContainer/1".visible = true
			Global.last_chat_winda = "RENA??????"
			Global.winda_new_chat = true
			
			if notif_sfx:
				AudioPlayer.play_notif()
				notif_sfx = false
			var time_now = timestamp
			Global.winda_new = true
			$"ScrollContainer/VBoxContainer/2/Vbox/time".text = time_now
			Global.last_time_winda = time_now
			Global.winda = true
			if Global.chat_winda :
				time_bool = true
				notif1 = false
				Global.winda_new_chat = false
				
			
	if time_bool : # waiting untuk jeda tiap balasan winda
			Global.winda_writing = true #aktifkan winda sedang mengetik
			timer.start()
			time_bool = false
			#print("error di time_bool winda")
			
	if Global.chat_winda : #chat winda lagi di buka
		if Global.winda_reply : #klo chatnya winda bisa dibales 
			if Global.winda_count == 1 && Global.chat_winda_count == 1:
				$"ScrollContainer/VBoxContainer/3".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/3/Vbox/time".text = time_now
				Global.last_time_winda = time_now
				Global.last_chat_winda = "Bukan. Gw kakaknya"
				Global.winda_new = false
				Global.reply = false
				Global.winda_reply = false
				time_bool = true
			elif Global.winda_count == 2 && Global.chat_winda_count == 2:
				$"ScrollContainer/VBoxContainer/5".visible = true #iya. Lu tau tentang hilangnya adek gw?
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/5/Vbox/time".text = time_now
				Global.last_time_winda = time_now
				Global.last_chat_winda = "Iya. lu tau adek gw lagi kenapa-napa?"
				Global.winda_new = false
				Global.reply = false
				Global.winda_reply = false
				timer.wait_time = 2.0
				time_bool = true
			elif Global.winda_count == 3 && Global.chat_winda_count == 3 :
				$"ScrollContainer/VBoxContainer/7".visible = true # game apa?
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/7/Vbox/time".text = time_now
				Global.last_time_winda = time_now
				Global.last_chat_winda = "Hah? Game apa?"
				Global.reply = false
				Global.winda_reply = false
				Global.winda_new = false
			else :
				pass
				#print("error di reply winda" + str(Global.winda_count) +str(Global.chat_winda_count))
				
				
func _on_timer_timeout() -> void:
	Global.winda_writing = false
	var num = Global.winda_count
	
	if num == 0 :
		Global.winda_new = true
		$"ScrollContainer/VBoxContainer/2".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/2/Vbox/time".text = time_now
		Global.last_time_winda = time_now
		AudioPlayer.play_notif()
		Global.last_chat_winda = "INI BENERAN LU? U OKAY"
		Global.reply = true
		Global.winda_reply = true
		Global.winda_count +=1
	elif num == 1:
		Global.winda_count +=1
		var total_length = 10
		var name_length = Global.user_name.length()
		var question_count = max(0, total_length - name_length)
		var question_marks = "?".repeat(question_count)
		$"ScrollContainer/VBoxContainer/4/MarginContainer/Label".text = "    Kak " + Global.user_name + question_marks
		AudioPlayer.play_notif()
		Global.winda_new = true
		Global.last_chat_winda = "kak " + Global.user_name
		$"ScrollContainer/VBoxContainer/4".visible = true #kak lizi?
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/4/Vbox/time".text = time_now
		Global.last_time_winda = time_now
		AudioPlayer.play_notif()
		Global.reply = true
		Global.winda_reply = true
	elif num == 2:
		Global.winda_count +=1
		$"ScrollContainer/VBoxContainer/6".visible = true
		var time_now = timestamp
		Global.winda_new = true
		$"ScrollContainer/VBoxContainer/6/Vbox/time".text = time_now
		Global.last_time_winda = time_now
		AudioPlayer.play_notif()
		Global.last_chat_winda = "Terakhir yang aku tau Rena main game yg"
		Global.reply = true
		Global.winda_reply = true
		
		
	else :
		pass
		#print("error di timeout winda")
		#print(Global.winda_count)
		#print(Global.chat_winda_count)
		#
