extends Node2D

var timestamp
@onready var timer := $Timer
var notif1 = true #boolean chat pertama luna
var time_bool = false #inisiai timer untuk jeda tiap chat 


func _ready() :
	# sembunyikan chat-chatnya dulu
	$ScrollContainer/VBoxContainer/X_post.visible = false
	$"ScrollContainer/VBoxContainer/1".visible = false
	$"ScrollContainer/VBoxContainer/2".visible = false
	$"ScrollContainer/VBoxContainer/3".visible = false
	$"ScrollContainer/VBoxContainer/4".visible = false
	$"ScrollContainer/VBoxContainer/5".visible = false
	$"ScrollContainer/VBoxContainer/6".visible = false
	$"ScrollContainer/VBoxContainer/7".visible = false
	$"ScrollContainer/VBoxContainer/8".visible = false
	$"ScrollContainer/VBoxContainer/9".visible = false
	$"ScrollContainer/VBoxContainer/10".visible = false
	$"ScrollContainer/VBoxContainer/11".visible = false
	$"ScrollContainer/VBoxContainer/12".visible = false
	$"ScrollContainer/VBoxContainer/13".visible = false
	$"ScrollContainer/VBoxContainer/14".visible = false
	$"ScrollContainer/VBoxContainer/15".visible = false
	$"ScrollContainer/VBoxContainer/16".visible = false
	$"ScrollContainer/VBoxContainer/17".visible = false
	$"ScrollContainer/VBoxContainer/18".visible = false
	$"ScrollContainer/VBoxContainer/19".visible = false
	$"ScrollContainer/VBoxContainer/20".visible = false
	$"ScrollContainer/VBoxContainer/21".visible = false
	$"ScrollContainer/VBoxContainer/22".visible = false
	$"ScrollContainer/VBoxContainer/23".visible = false
	$"ScrollContainer/VBoxContainer/24".visible = false
	$"ScrollContainer/VBoxContainer/25".visible = false
	$"ScrollContainer/VBoxContainer/26".visible = false
	$"ScrollContainer/VBoxContainer/27".visible = false
	$"ScrollContainer/VBoxContainer/28".visible = false
	$"ScrollContainer/VBoxContainer/29".visible = false
	$"ScrollContainer/VBoxContainer/30".visible = false
	$"ScrollContainer/VBoxContainer/31".visible = false
	$ScrollContainer/VBoxContainer/send_pic.visible = false
	
	#inisiasi timer
	timer.wait_time = 1.0
	timer.one_shot = true  # Pastikan hanya sekali
	if not timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.connect(_on_timer_timeout)

func _process(delta):
	#nanti hapus
	
	
	#timestamp 
	var time_dict = Time.get_time_dict_from_system()
	var hour = "%02d" % time_dict.hour
	var minute = "%02d" % time_dict.minute
	timestamp =  "%s:%s" % [hour, minute]
	
	if Global.luna : #jika luna sudah menghubungi player
		if notif1 :
			Global.luna_new = true #simbol chat baru dari luna
			var time_now = timestamp
			Global.last_time_luna = time_now
			$"ScrollContainer/VBoxContainer/1".visible = true
			$"ScrollContainer/VBoxContainer/1/Vbox/time".text = time_now
			Global.luna_new_chat = true
			notif1 = false
			Global.luna_count +=1
			time_bool = true
			
	if Global.chat_luna : #chat lune lagi di buka
		if time_bool : # waiting untuk jeda tiap balasan luna
			Global.luna_writing = true #aktifkan luna sedang mengetik
			timer.start()
			time_bool = false
		
		if Global.luna_reply : #klo chatnya luna bisa dibales 
			if Global.chat_luna_count == 1:
				$"ScrollContainer/VBoxContainer/4".visible = true # bukan gw kakaknya
				var time_now = timestamp
				Global.last_time_luna = time_now
				$"ScrollContainer/VBoxContainer/4/Vbox/time".text = time_now
				Global.last_chat_luna = "ini kakaknya Rena. Adek gue hilang dari"
			elif Global.chat_luna_count == 2 && Global.luna_count == 4 :
				$"ScrollContainer/VBoxContainer/5".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/5/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.luna_new = false #karena sudah dibales, ilangin logo new chat yang merah 
				Global.last_chat_luna = "task yang lu maksud tuh The Hostage?"
				Global.luna_reply = false #udh g bisa bales chat luna lg
				time_bool = true
			elif Global.chat_luna_count == 3  :
				$"ScrollContainer/VBoxContainer/8".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/8/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.last_chat_luna = "Gw serius. Gw kakaknya, bukan Rena."
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 4  :
				$ScrollContainer/VBoxContainer/X_post.visible = true # send pic
				var time_now = timestamp
				$ScrollContainer/VBoxContainer/X_post/Vbox/time.text = time_now
				Global.last_chat_luna = "You send a picture"
				Global.last_time_luna = time_now
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 5  && Global.luna_count == 6 :
				$"ScrollContainer/VBoxContainer/9".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/9/Vbox/time".text = time_now
				Global.last_chat_luna = "Sebenernya ada apa dengan gamenya?"
				Global.luna_reply = false #udh g bisa bales chat luna lg
				Global.luna_new = false
				Global.last_time_luna = time_now
				time_bool = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 6 && Global.luna_count == 8 :
				$"ScrollContainer/VBoxContainer/12".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/12/Vbox/time".text = time_now
				Global.last_chat_luna = "Tadi gw udh coba main. emang ada apa"
				Global.luna_reply = false #udh g bisa bales chat luna lg
				Global.luna_new = false
				Global.last_time_luna = time_now
				time_bool = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 7 && Global.luna_count == 10 :
				$ScrollContainer/VBoxContainer/send_pic.visible = true # bukan gw kakaknya
				var time_now = timestamp
				$ScrollContainer/VBoxContainer/X_post/Vbox/time.text = time_now
				Global.last_time_luna = time_now
				Global.luna_new = false
				Global.last_chat_luna = "You send a picture"
				Global.luna_reply = false #udh g bisa bales chat luna lg
				time_bool = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 8 && Global.luna_count == 11 :
				$"ScrollContainer/VBoxContainer/16".visible = true # 
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/16/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.last_chat_luna = "Gue bantu dia keluar dari sebuah kamar"
				Global.luna_reply = false #udh g bisa bales chat luna lg
				Global.luna_new = false
				time_bool = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 9 && Global.luna_count == 12 :
				$"ScrollContainer/VBoxContainer/18".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/18/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.last_chat_luna = "Arahin?"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 10 && Global.luna_count == 12 :
				$"ScrollContainer/VBoxContainer/19".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/19/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.last_chat_luna = "Ada safebox, foto , jendela. Terus ada siluet orang"
				Global.luna_reply = false #udh g bisa bales chat luna lg
				Global.luna_new = false
				time_bool = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 11 && Global.luna_count == 15 :
				$"ScrollContainer/VBoxContainer/23".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/23/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.last_chat_luna = "Hah? Daniel itu orang beneran? Ini game"
				Global.luna_reply = false #udh g bisa bales chat luna lg
				Global.luna_new = false
				time_bool = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 12 && Global.luna_count == 17 :
				$"ScrollContainer/VBoxContainer/26".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/26/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.last_chat_luna = "Hah? Kenapa chat lu kayak gitu?"
				Global.luna_new = false
				Global.luna_reply = false #udh g bisa bales chat luna lg
				time_bool = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 13 && Global.luna_count == 20 :
				$"ScrollContainer/VBoxContainer/30".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/30/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.last_chat_luna = "Hah? Lu kenapa?"
				await get_tree().process_frame
				Global.glitch = false
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			elif Global.chat_luna_count == 14 && Global.luna_count == 20 :
				$"ScrollContainer/VBoxContainer/31".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/31/Vbox/time".text = time_now
				Global.last_time_luna = time_now
				Global.last_chat_luna = "Ada apa dengam The Hostage?"
				Global.luna_new = false
				Global.luna_reply = false #udh g bisa bales chat luna lg
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				Global.edgar = true
				Global.edgar_new = true
				#
				#print(" ada apa dgn Global.luna_count: ", Global.luna_count)
				#print("ada apa dgnGlobal.chat_luna_count: ", Global.chat_luna_count)
				#print("ada apa dgn Global.edgar_count: ", Global.edgar_count)
				
func _on_timer_timeout() -> void:
	Global.luna_writing = false
	var num = Global.luna_count
	
	if num == 2 :
		$"ScrollContainer/VBoxContainer/2".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Oh my God... gue ngga bisa. Hostage gue"
		Global.luna_new_chat = false
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/2/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		time_bool = true #jeda ke next chat lagi dari luna
	elif num == 3 :
		$"ScrollContainer/VBoxContainer/3".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Gimana Ren? What am i supposed to do?"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/3/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_reply = true # player bisa bales chat luna sekarang
	elif num == 4 :
		$"ScrollContainer/VBoxContainer/6".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Please... dont joke lah Ren"
		Global.luna_new = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/6/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		time_bool = true #jeda ke next chat lagi dari luna
	elif num == 5 :
		$"ScrollContainer/VBoxContainer/7".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Lu bercanda kan?"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/7/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_reply = true # player bisa bales chat luna sekarang
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif num == 6 :
		$"ScrollContainer/VBoxContainer/10".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Oh godd, it's already on a news?"
		Global.luna_new = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/10/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		time_bool = true
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif num == 7 :
		$"ScrollContainer/VBoxContainer/11".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "It's not just a game"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/11/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_reply = true # player bisa bales chat luna sekarang
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif num == 8 :
		$"ScrollContainer/VBoxContainer/13".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Oh ... sht"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/13/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_new = true
		Global.luna_count +=1
		time_bool = true
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif num == 9 :
		$"ScrollContainer/VBoxContainer/14".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Which hostage did you save?"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/14/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_reply = true # player bisa bales chat luna sekarang
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		#print(Global.luna_count)
		#print(Global.chat_luna_count)
	elif num == 10 :
		$"ScrollContainer/VBoxContainer/15".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "What did you do to him? "
		var time_now = timestamp
		Global.luna_new = true
		$"ScrollContainer/VBoxContainer/15/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_reply = true # player bisa bales chat luna sekarang
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif num == 11 :
		$"ScrollContainer/VBoxContainer/17".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "No, I mean ... What did you lead him to?"
		Global.luna_new = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/17/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_reply = true # player bisa bales chat luna sekarang
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif num == 12 :
		$"ScrollContainer/VBoxContainer/20".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Well, Daniel is my friend. He played the game"
		Global.luna_new = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/20/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		time_bool = true
	elif num == 13 :
		$"ScrollContainer/VBoxContainer/21".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "His parents ... they're monsters. Abusive as hell"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/21/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		time_bool = true
	elif num == 14 :
		$"ScrollContainer/VBoxContainer/22".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "I know it sounds insane ... but that stage"
		Global.luna_new = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/22/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_reply = true # player bisa bales chat luna sekarang
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif num == 15 :
		$"ScrollContainer/VBoxContainer/24".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Tolong gw %718hj Pls !*@)"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/24/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_new =true
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		time_bool = true
		Global.glitch = true
	elif num == 16 :
		$"ScrollContainer/VBoxContainer/25".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "ansjdh!761iodjio1327qkl"
		Global.luna_new = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/25/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1 #17
		Global.luna_reply = true # player bisa bales chat luna sekarang
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
	elif num == 17 :
		$"ScrollContainer/VBoxContainer/27".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "Jangan... 23@!87123b3!#&"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/27/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		Global.luna_new =true
		await get_tree().process_frame
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		time_bool = true
		$ScrollContainer
	elif num == 18 :
		$"ScrollContainer/VBoxContainer/28".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "@717jaj Jangan berhenti 218!*&81 main I !(@*8"
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/28/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		time_bool = true
	elif num == 19 :
		$"ScrollContainer/VBoxContainer/29".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_luna = "HEL&@!&*^PP&@"
		Global.luna_new = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/29/Vbox/time".text = time_now
		Global.last_time_luna = time_now
		Global.luna_count +=1 #20
		Global.luna_reply = true # player bisa bales chat luna sekarang
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		
	else :
		#print("error di timeout")
		#print(Global.luna_count)
		#print(Global.chat_luna_count)
		pass
		#
