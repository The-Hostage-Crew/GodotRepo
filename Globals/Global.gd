# Global.gd
extends Node

# Pause Menu
var cursor_enabled : bool = false
var in_modal: bool = false

var user_name: String = "lizi"
var my_echo: bool = false
var reply: bool = false
var my_echo_app = false #aplikasi myecho lg dibuka atau tidak

var TheHostage_icon: bool = false
var TheHostage: bool = false

var glitch : bool = false
var level : int = 0 #klo 1 berarti easy ( sanity off ), 2 = hard ( sanity on )

#chat edgar
var last_chat_edgar: String = "TESSSS" #ini buat last chat yang ditampilin di histori
var chat_edgar_count: int = 0 # basenya 0 #ini tu buat cek apakah kita ngereply chat edgar?
var chat_edgar: bool = false #ini chat nya lg dibuka atau ngga?
var edgar: bool = false #apakah ada chat masuk dari edgar? klo false histori nya ga ada
var edgar_new : bool = false #apakah ada chat baru dri edgar?
var edgar_writing : bool =  false # apakah edgar sedang mengetik?
var edgar_new2 : bool = false
var edgar_reply : bool = false # player bisa reply chat edgar ngga?
var edgar_count : int = 0 #hitung ini lg baris chat kebeara buat memperkirakan baris chat
var last_time_edgar : String = ""
var edgar_new_chat : bool = false

#chat Winda
var last_chat_winda: String = "RENA??????" #last chat untuk ditampilin di history
var chat_winda_count: int = 0 #utuk perhitungan reply
var chat_winda: bool = false #ini chat nya lg dibuka atau ngga?
var winda: bool = false #apakah ada chat masuk dari winda? klo false histori nya ga ada
var winda_new : bool = false #apakah ada chat baru dri winda?
var winda_writing : bool =  false # apakah winda  sedang mengetik?
var winda_reply : bool = false # player bisa reply chat edgar ngga?
var winda_count : int = 0
var last_time_winda : String = ""
var winda_new_chat : bool = false

#chat Luna
var last_chat_luna: String = "Ren? Have you completed the new task?" #last chat untuk ditampilin di history
var chat_luna_count: int = 0 #base nya 0 #utuk perhitungan reply
var luna: bool = false #apakah ada chat masuk dari luna? klo false histori nya ga ada
var luna_new : bool = false #apakah ada chat baru dri luna?
var luna_writing : bool =  false # apakah luna sedang mengetik?
var luna_count : int = 1 # base nya 1
var luna_reply : bool = false # player bisa reply chat luna ngga?
var chat_luna: bool = false #ini chat nya lg dibuka atau ngga?
var last_time_luna : String = ""
var luna_new_chat : bool = false

#chat xxx
var last_chat_xxx: String = "" #last chat untuk ditampilin di history
var chat_xxx_count: int = 0 #base nya 0 #utuk perhitungan reply
var xxx: bool = false #apakah ada chat masuk dari xxx? klo false histori nya ga ada
var xxx_new : bool = false #apakah ada chat baru dri xxx?
var xxx_writing : bool =  false # apakah xxx sedang mengetik?
var xxx_count : int = 0 # base nya 1
var xxx_reply : bool = false # player bisa reply chat xxx ngga?
var chat_xxx: bool = false #ini chat nya lg dibuka atau ngga?
var last_time_xxx : String = ""
var xxx_new_chat : bool = false

#ambil timestamp
var timestamp: String = get_current_time_string()

#apakah stage 1-2-3 sudah terlewati?
var stage1 = false #klo stage1 menang ganti jadi True
var stage2 = false #klo stage1 menang ganti jadi True

var is_stage1_safebox = true
var is_stage2_safebox = false
var is_stage2_safebox_done = false


var is_remote = false
func get_current_time_string() -> String:
	var time_dict = Time.get_time_dict_from_system()
	var hour = "%02d" % time_dict.hour
	var minute = "%02d" % time_dict.minute
	return "%s:%s" % [hour, minute]

func reset():
	cursor_enabled = false
	in_modal = false
	user_name = "lizi"
	my_echo = false
	reply = false
	TheHostage_icon = false
	TheHostage = false
	glitch = false
	last_chat_edgar = "TESSSS"
	chat_edgar_count = 0
	chat_edgar = false
	edgar = false
	edgar_new = false
	edgar_writing = false
	edgar_new2 = false
	edgar_reply = false
	edgar_count = 0
	last_time_edgar = ""
	edgar_new_chat = false
	last_chat_winda = "RENA??????"
	chat_winda_count = 0
	chat_winda = false
	winda = false
	winda_new = false
	winda_writing = false
	winda_reply = false
	winda_count = 0
	last_time_winda = ""
	winda_new_chat = false
	last_chat_luna = "Ren? Have you completed the new task?"
	chat_luna_count = 0
	luna = false
	luna_new = false
	luna_writing = false
	luna_count = 1
	luna_reply = false
	chat_luna = false
	last_time_luna = ""
	luna_new_chat = false
	last_chat_xxx = ""
	chat_xxx_count = 0
	xxx = false
	xxx_new = false
	xxx_writing = false
	xxx_count = 0
	xxx_reply = false
	chat_xxx = false
	last_time_xxx = ""
	xxx_new_chat = false
	timestamp = get_current_time_string()
	my_echo_app = false
	stage1 = false
	stage2 = false
	is_stage1_safebox = true
	is_stage2_safebox = false
