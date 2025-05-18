# Global.gd
extends Node

var user_name: String = "lizi"
var my_echo: bool = false
var reply: bool = false
var my_echo_app = false #aplikasi myecho lg dibuka atau tidak

var TheHostage_icon: bool = false
var TheHostage: bool = false

var glitch : bool = false

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


#chat Winda
var last_chat_winda: String = "RENA??????" #last chat untuk ditampilin di history
var chat_winda_count: int = 0 #utuk perhitungan reply
var chat_winda: bool = false #ini chat nya lg dibuka atau ngga?
var winda: bool = false #apakah ada chat masuk dari winda? klo false histori nya ga ada
var winda_new : bool = false #apakah ada chat baru dri winda?
var winda_writing : bool =  false # apakah winda  sedang mengetik?
var winda_reply : bool = false # player bisa reply chat edgar ngga?
var winda_count : int = 0

#chat Luna
var last_chat_luna: String = "Ren? Have you completed the new task?" #last chat untuk ditampilin di history
var chat_luna_count: int = 0 #base nya 0 #utuk perhitungan reply
var luna: bool = false #apakah ada chat masuk dari luna? klo false histori nya ga ada
var luna_new : bool = false #apakah ada chat baru dri luna?
var luna_writing : bool =  false # apakah luna sedang mengetik?
var luna_count : int = 1 # base nya 1
var luna_reply : bool = false # player bisa reply chat luna ngga?
var chat_luna: bool = false #ini chat nya lg dibuka atau ngga?

#chat xxx
var last_chat_xxx: String = "" #last chat untuk ditampilin di history
var chat_xxx_count: int = 0 #base nya 0 #utuk perhitungan reply
var xxx: bool = false #apakah ada chat masuk dari xxx? klo false histori nya ga ada
var xxx_new : bool = false #apakah ada chat baru dri xxx?
var xxx_writing : bool =  false # apakah xxx sedang mengetik?
var xxx_count : int = 0 # base nya 1
var xxx_reply : bool = false # player bisa reply chat xxx ngga?
var chat_xxx: bool = false #ini chat nya lg dibuka atau ngga?


#ambil timestamp
var timestamp: String = get_current_time_string()

#apakah stage 1-2-3 sudah terlewati?
var stage1 = false #klo stage1 menang ganti jadi True
var stage2 = false #klo stage1 menang ganti jadi True

func get_current_time_string() -> String:
	var time_dict = Time.get_time_dict_from_system()
	var hour = "%02d" % time_dict.hour
	var minute = "%02d" % time_dict.minute
	return "%s:%s" % [hour, minute]
