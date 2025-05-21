extends Node2D

var timestamp
@onready var timer := $Timer

var notif1 = true #boolean chat pertama edgar
var notif2 = true #pindah dari winda ke edgar
var notif3 = true #pindah dari luna ke edgar
var notif4 = true #lu dpt chat dari XXX666


var timer_bool = false #inisiai timer untuk jeda tiap chat 

@onready var download_button := $"ScrollContainer/VBoxContainer/download/MarginContainer2/VBoxContainer/download button/on"
@onready var show_button := $"ScrollContainer/VBoxContainer/download/MarginContainer2/VBoxContainer/download button/show_on"
var counter := 1
var download = false
var click = 1

var notif_sfx = true

func _ready() :

	#sembunyikan chat chatnya dulu
	$"ScrollContainer/VBoxContainer/1".visible = false
	$"ScrollContainer/VBoxContainer/2".visible = false
	$"ScrollContainer/VBoxContainer/3".visible = false
	$"ScrollContainer/VBoxContainer/4".visible = false
	$"ScrollContainer/VBoxContainer/5".visible = false
	$"ScrollContainer/VBoxContainer/6".visible = false
	$"ScrollContainer/VBoxContainer/7".visible = false
	$"ScrollContainer/VBoxContainer/download".visible = false
	$"ScrollContainer/VBoxContainer/8".visible = false
	$"ScrollContainer/VBoxContainer/9".visible = false
	$"ScrollContainer/VBoxContainer/11".visible = false
	$"ScrollContainer/VBoxContainer/12".visible = false
	$"ScrollContainer/VBoxContainer/12-foto2".visible = false
	$"ScrollContainer/VBoxContainer/13".visible = false
	$"ScrollContainer/VBoxContainer/14-foto".visible = false
	$"ScrollContainer/VBoxContainer/15".visible = false
	$"ScrollContainer/VBoxContainer/16".visible = false
	$"ScrollContainer/VBoxContainer/17".visible = false
	$"ScrollContainer/VBoxContainer/18".visible = false
	$"ScrollContainer/VBoxContainer/27".visible = false
	$"ScrollContainer/VBoxContainer/28".visible = false
	$"ScrollContainer/VBoxContainer/19".visible = false
	$"ScrollContainer/VBoxContainer/20".visible = false
	$"ScrollContainer/VBoxContainer/21".visible = false
	$"ScrollContainer/VBoxContainer/22".visible = false
	$"ScrollContainer/VBoxContainer/23".visible = false
	$"ScrollContainer/VBoxContainer/24".visible = false
	$"ScrollContainer/VBoxContainer/25".visible = false
	$"ScrollContainer/VBoxContainer/26".visible = false
	$"ScrollContainer/VBoxContainer/screen-rusak".visible = false
	
	if Global.stage1:
		$"ScrollContainer/VBoxContainer/1".visible = true
		$"ScrollContainer/VBoxContainer/2".visible = true
		$"ScrollContainer/VBoxContainer/3".visible = true
		$"ScrollContainer/VBoxContainer/4".visible = true
		$"ScrollContainer/VBoxContainer/5".visible = true
		$"ScrollContainer/VBoxContainer/6".visible = true
		$"ScrollContainer/VBoxContainer/7".visible = true
		$"ScrollContainer/VBoxContainer/download".visible = true
		$"ScrollContainer/VBoxContainer/8".visible = true
		$"ScrollContainer/VBoxContainer/9".visible = true
	#inisiasi timer
	timer.wait_time = 1.0
	timer.one_shot = true  # Pastikan hanya sekali
	if not timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.connect(_on_timer_timeout)

func _process(delta):
	
	
	#timestamp 
	var time_dict = Time.get_time_dict_from_system()
	var hour = "%02d" % time_dict.hour
	var minute = "%02d" % time_dict.minute
	timestamp =  "%s:%s" % [hour, minute]
	
	if Global.edgar : #jika edgar sudah menghubungi player
		if notif1 and !Global.stage1:
			Global.edgar_new2 = true #simbol chat baru dari edgar
			var time_now = timestamp
			$"ScrollContainer/VBoxContainer/1".visible = true
			$"ScrollContainer/VBoxContainer/1/Vbox/time".text = time_now
			Global.last_time_edgar = time_now
			if Global.chat_edgar :
				timer_bool = true
				notif1 = false
		elif notif2 && Global.winda_count == 3 && Global.chat_winda_count == 3:
			timer_bool = true 
			notif2 = false
		elif notif3 && Global.luna_count == 20  :
			Global.edgar_new2 = true
			$"ScrollContainer/VBoxContainer/11".visible = true
			$"ScrollContainer/VBoxContainer/11/MarginContainer/TextureRect2/Control/Label".text = "   Cuyy, " + Global.user_name +"!"
			var time_now = timestamp
			$"ScrollContainer/VBoxContainer/11/Vbox/time".text = time_now
			await get_tree().process_frame
			$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			if notif_sfx :
				AudioPlayer.play_notif()
				notif_sfx = false
			Global.last_chat_edgar =  "Cuyy, " + Global.user_name +"!"
			Global.edgar_new_chat = true
			if Global.chat_edgar :
				print("edgar Global.luna_count: ", Global.luna_count)
				print("edgar Global.chat_luna_count: ", Global.chat_luna_count)
				print("edgar Global.edgar_count: ", Global.edgar_count)
				timer_bool = true
				notif3 = false
		elif notif4 && Global.xxx_count == 1 : # cuy lu dapet chat dari
			Global.edgar_new2 = true
			$"ScrollContainer/VBoxContainer/22".visible = true
			var time_now = timestamp
			$"ScrollContainer/VBoxContainer/22/Vbox/time".text = time_now
			await get_tree().process_frame
			$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			AudioPlayer.play_notif()
			notif_sfx = false
			Global.last_chat_edgar =  "Lu dapet chat dari XXX666?"
			Global.edgar_new_chat = true
			await get_tree().process_frame
			Global.edgar_new_chat = false
			timer_bool = true
			notif4 = false
				
	if timer_bool: # waiting untuk jeda tiap balasan edgar
			Global.edgar_writing = true #aktifkan edgar sedang mengetik
			timer.start()
			timer_bool= false
			print("error di timer_bool edgar")

			
	if Global.chat_edgar : #chat edgar lagi di buka
		if Global.edgar_reply : #klo chatnya edgar bisa dibales 
			if Global.edgar_count == 1 && Global.chat_edgar_count == 1:
				$"ScrollContainer/VBoxContainer/3".visible = true # bukan gw kakaknya
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/3/Vbox/time".text = time_now
				Global.last_chat_edgar = "sip"
				Global.edgar_new2 = false #karena sudah dibales, ilangin logo new chat yang merah 
				Global.edgar_reply = false
			elif Global.edgar_count == 3 && Global.chat_edgar_count == 2 :
				$"ScrollContainer/VBoxContainer/6".visible = true #gw dpt info klo rena abis main game
				Global.last_chat_edgar = "Gw dpt info klo Rena abis main game"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/6/Vbox/time".text = time_now
				Global.edgar_new2 = false
				timer.wait_time = 2.0
				timer_bool = true
				Global.reply = false 
				Global.edgar_reply = false
			elif Global.edgar_count == 8 && Global.chat_edgar_count == 3 :
				$"ScrollContainer/VBoxContainer/14-foto".visible = true #gw dpt info klo rena abis main game
				Global.last_chat_edgar = "You send a picture"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/14-foto/Vbox/time".text = time_now
				Global.edgar_new2 = false
				timer.wait_time = 2.0
				timer_bool = true
				Global.edgar_reply = false
			elif Global.edgar_count == 11 && Global.chat_edgar_count == 4 :
				$"ScrollContainer/VBoxContainer/18".visible = true #gw dpt info klo rena abis main game
				Global.last_chat_edgar = "Tiba-tiba ada chat masuk, kayaknya temennya"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/18/Vbox/time".text = time_now
			elif Global.edgar_count == 11 && Global.chat_edgar_count == 5 :
				$"ScrollContainer/VBoxContainer/27".visible = true #gw dpt info klo rena abis main game
				Global.last_chat_edgar = "You send a picture"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/27/Vbox/time".text = time_now
			elif Global.edgar_count == 11 && Global.chat_edgar_count == 6 :
				$"ScrollContainer/VBoxContainer/28".visible = true #gw dpt info klo rena abis main game
				Global.last_chat_edgar = "You send a picture"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/28/Vbox/time".text = time_now
			elif Global.edgar_count == 11 && Global.chat_edgar_count == 7 :
				$"ScrollContainer/VBoxContainer/screen-rusak".visible = true #gw dpt info klo rena abis main game
				Global.last_chat_edgar = "Screen gw juga tiba-tiba rusak. Ada yang ga beres"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/screen-rusak/Vbox/time".text = time_now
				Global.edgar_new2 = false
				Global.edgar_reply = false
				timer_bool = true
			elif Global.edgar_count == 13 && Global.chat_edgar_count == 8 :
				$"ScrollContainer/VBoxContainer/21".visible = true #gw dpt info klo rena abis main game
				Global.last_chat_edgar = "Iya, kayaknya begitu. Ini laptop adek gw kayaknya"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/21/Vbox/time".text = time_now
				Global.edgar_new2 = false
				Global.edgar_reply = false
			elif Global.edgar_count == 14 && ( Global.chat_edgar_count == 9 or Global.chat_edgar_count == 8 ) :
				$"ScrollContainer/VBoxContainer/24".visible = true #gw dpt info klo rena abis main game
				Global.last_chat_edgar = "Iya, gw juga dapet"
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/24/Vbox/time".text = time_now
				Global.edgar_new2 = false
				Global.edgar_reply = false
				timer_bool = true
			else:
				print("error di reply edgar " + str(Global.edgar_count) + " " +str(Global.chat_edgar_count))
				

func _on_timer_timeout() -> void:
	Global.edgar_writing = false
	var num = Global.edgar_count
	
	if num == 0 :
		$"ScrollContainer/VBoxContainer/2".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Chat disini aja y. Biar ez klo ada sesuatu yg"
		var time_now = timestamp
		Global.edgar_new2 = true
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/2/Vbox/time".text = time_now
		Global.edgar_reply = true
		Global.last_time_edgar = time_now
	elif num == 1 :
		$"ScrollContainer/VBoxContainer/4".visible = true
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Ada berita orang hilang lagi nih"
		Global.edgar_new_chat = true
		Global.edgar_new2 = true
		var time_now = timestamp
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/4/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		timer_bool= true
		Global.edgar_new = true
		
	elif num == 2 :
		Global.edgar_new_chat = false
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/5".visible = true
		Global.last_chat_edgar = "Edgar send a picture"
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		Global.edgar_new2 = true
		var time_now = timestamp
		Global.last_time_edgar = time_now
		$"ScrollContainer/VBoxContainer/5/Vbox/time".text = time_now
		AudioPlayer.play_notif()
		Global.reply = true
		Global.edgar_reply = true
	elif num == 3 :
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/7".visible = true # edgar nemu game
		Global.last_chat_edgar = "HAH? Kebetulan pas gw ubek-ubek sosmed"
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.edgar_new2 = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/7/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		timer_bool = true
	elif num == 4: 
		Global.edgar_count +=1
		$ScrollContainer/VBoxContainer/download.visible = true
		var time_now = timestamp
		$ScrollContainer/VBoxContainer/download/Vbox/time.text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "file"
	elif num == 5 :
		if Global.chat_edgar && Global.edgar_new:
			Global.edgar_count +=1
			$"ScrollContainer/VBoxContainer/12".visible = true
			var time_now = timestamp
			$"ScrollContainer/VBoxContainer/12/Vbox/time".text = time_now
			Global.last_time_edgar = time_now
			await get_tree().process_frame
			$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
			AudioPlayer.play_notif()
			Global.last_chat_edgar = "Ini nama adek lo kok disebut dalem game?"
			Global.edgar_new_chat = false
			timer.wait_time = 1.0
			timer_bool = true
	elif num == 6 :
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/12-foto2".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/12-foto2/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Edgar send a picture"
		timer_bool = true
	elif num == 7 :
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/13".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/13/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Kasih liat ending game lo dong"
		Global.edgar_reply = true
	elif num == 8 :
		Global.edgar_new2 = true
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/15".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/15/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Bentar ..."
		timer.wait_time = 2.0
		timer_bool = true
	elif num == 9 :
		Global.edgar_new2 = true
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/16".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/16/Vbox/time".text = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Wtf itu Daniel orang hilang yang gw kasih"
		timer.wait_time = 1.0
		timer_bool = true
	elif num == 10 :
		Global.edgar_new2 = true
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/17".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/17/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Ga beres anjr"
		Global.edgar_reply = true
	elif num == 11 :
		Global.edgar_new2 = true
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/19".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/19/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Gila"
		timer_bool = true
	elif num == 12 :
		Global.edgar_new2 = true
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/20".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/20/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Yang gw tangkep, klo kita gak lanjut mainin gamenya, "
		Global.edgar_reply = true
	elif num == 13 :
		Global.edgar_new2 = true
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/23".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/23/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "dpt  kontak gw darimana anjr"
		Global.edgar_new_chat = true
		await get_tree().process_frame
		Global.edgar_new_chat = false
		Global.edgar_reply = true
	elif num == 14 :
		Global.edgar_new2 = true
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/25".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/25/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		Global.edgar_new_chat = true
		await get_tree().process_frame
		Global.edgar_new_chat = false
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Berdasarkan chat temennya adek lo, kalau berhenti"
		timer_bool = true
	elif num == 15 :
		Global.edgar_new2 = false
		Global.edgar_count +=1
		$"ScrollContainer/VBoxContainer/26".visible = true
		var time_now = timestamp
		$"ScrollContainer/VBoxContainer/26/Vbox/time".text = time_now
		Global.last_time_edgar = time_now
		await get_tree().process_frame
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
		Global.edgar_new_chat = true
		await get_tree().process_frame
		Global.edgar_new_chat = false
		AudioPlayer.play_notif()
		Global.last_chat_edgar = "Gw download dan main lg deh klo gitu."
		timer_bool = true
		

	else :
		print("error di timeout edgar")
		print("edgar_count" + str(Global.edgar_count))
		print(Global.chat_edgar_count)
		
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
			Global.edgar_new2 = false
		$"ScrollContainer/VBoxContainer/download/MarginContainer2/VBoxContainer/download button/downloading".visible = true
		while counter <= 100:
			$"ScrollContainer/VBoxContainer/download/MarginContainer2/VBoxContainer/download button/downloading/Label".text = str(counter) + "%"
			counter += 1
			if counter == 18 :
				Global.glitch = true
			elif counter == 42 :
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/8/Vbox/time".text = time_now
				$"ScrollContainer/VBoxContainer/8".visible = true
				Global.last_time_edgar = time_now
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				Global.edgar_new2 = true
				Global.last_chat_edgar = "file"
				Global.last_chat_edgar = "Mungkin kita harus coba mainin buat"
				AudioPlayer.play_notif()
			elif counter == 87 :
				$"ScrollContainer/VBoxContainer/9".visible = true
				await get_tree().process_frame
				$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
				var time_now = timestamp
				$"ScrollContainer/VBoxContainer/9/Vbox/time".text = time_now
				Global.last_chat_edgar = "Gw coba deh"
				Global.last_time_edgar = time_now
				AudioPlayer.play_notif()
			await get_tree().create_timer(0.05).timeout  # jeda 0.05 detik antar angka
		download = true
		Global.glitch = false
		$"ScrollContainer/VBoxContainer/download/MarginContainer2/VBoxContainer/download button/show".visible = true
		if Global.stage1 == false : 
			Global.TheHostage_icon = true
		if click >2 && download && Global.stage1 == false: 
			Global.edgar_new2 = false
			print("here")
			Global.my_echo_app = false
