extends Node2D

@onready var edgar_message : MarginContainer =  $VBoxContainer/Edgar
@onready var edgar: TextureRect = $VBoxContainer/Edgar/edgar
@onready var edgar_chat: TextureRect = $VBoxContainer/Edgar/edgar_global
@onready var edgar_last_chat: Label = $VBoxContainer/Edgar/HBoxContainer/VBoxContainer/last_chat_edgar
@onready var edgar_info : HBoxContainer = $chat_info/edgar_info

@onready var winda_message : MarginContainer = $VBoxContainer/Winda
@onready var winda : TextureRect = $VBoxContainer/Winda/winda
@onready var winda_chat: TextureRect = $VBoxContainer/Winda/winda_global
@onready var winda_last_chat: Label = $VBoxContainer/Winda/HBoxContainer/VBoxContainer/last_chat_winda
@onready var winda_info : HBoxContainer = $chat_info/winda_info

@onready var luna_message : MarginContainer = $VBoxContainer/Luna
@onready var luna : TextureRect = $VBoxContainer/Luna/luna
@onready var luna_chat: TextureRect = $VBoxContainer/Luna/luna_global
@onready var luna_last_chat: Label = $VBoxContainer/Luna/HBoxContainer/VBoxContainer/last_chat_luna
@onready var luna_info : HBoxContainer = $chat_info/luna_info

@onready var xxx_message : MarginContainer = $VBoxContainer/XXX
@onready var xxx : TextureRect = $VBoxContainer/XXX/xxx
@onready var xxx_chat: TextureRect = $VBoxContainer/XXX/xxx_global
@onready var xxx_last_chat: Label = $VBoxContainer/XXX/HBoxContainer/VBoxContainer/last_chat_xxx
@onready var xxx_info : HBoxContainer =$chat_info/xxx_info           


func _ready():
	# awal awal di hide semua
	$BG.visible = false
	edgar_message.visible = false
	winda_message.visible = false
	
	edgar_info.visible = false
	winda_info.visible = false
	
	luna_info.visible = false
	luna_message.visible = false
	
	xxx_info.visible = false
	xxx_message.visible = false
	
	if Global.stage1:
		print("SS")
		Global.edgar_new2 = false

	
func _process(delta: float) -> void:
	
	if Global.edgar_new_chat:
		$VBoxContainer.move_child($VBoxContainer/Edgar, 0)

	if Global.winda_new_chat:
		$VBoxContainer.move_child($VBoxContainer/Winda, 0)

	if Global.luna_new_chat:
		$VBoxContainer.move_child($VBoxContainer/Luna, 0)

	if Global.xxx_new_chat:
		$VBoxContainer.move_child($VBoxContainer/XXX, 0)


	#sedang mengetik atau tidak
	if Global.winda_writing :
		$chat_info/winda_info/VBoxContainer/winda_writing.text = "Sedang mengetik ..."
	else : 
		$chat_info/winda_info/VBoxContainer/winda_writing.text = ""
		
	if Global.edgar_writing :
		$chat_info/edgar_info/VBoxContainer/edgar_writing.text = "Sedang mengetik ..."
	else : 
		$chat_info/edgar_info/VBoxContainer/edgar_writing.text = ""
		
	if Global.luna_writing :
		$chat_info/luna_info/VBoxContainer/luna_writing.text = "Sedang mengetik ..."
	else : 
		$chat_info/luna_info/VBoxContainer/luna_writing.text = ""
		
	#apakah ada chat baru? ini untuk menampilkan simbol ada chat baru, simbol merah
	if Global.edgar_new2 :
		$VBoxContainer/Edgar/Control.visible = true
	else : 
		$VBoxContainer/Edgar/Control.visible = false
	
	if Global.winda_new :
		$VBoxContainer/Winda/Control.visible = true
	else : 
		$VBoxContainer/Winda/Control.visible = false
	
	if Global.luna_new :
		$VBoxContainer/Luna/Control.visible = true
	else : 
		$VBoxContainer/Luna/Control.visible = false
		
	if Global.edgar : #ada chat edgar masuk
		$VBoxContainer/Edgar/Control2/last_time_edgar. text = Global.last_time_edgar
		edgar_message.visible = true
		edgar_last_chat.text = Global.last_chat_edgar  # Memperbarui teks label dengan nilai terbaru dari Global.last_chat_edgar
		if Global.chat_edgar: #kalau cht edgar lgi di buka
			edgar_chat.visible = true
			edgar_info.visible = true
			$luna_reply.visible = false
			$winda_reply.visible = false
			if Global.edgar_reply :
				$edgar_reply.visible = true
			else :
				$edgar_reply.visible = false
		else : 
			edgar_chat.visible = false
			edgar_info.visible = false
			
	if Global.winda : #ada chat luna yang masuk
		$VBoxContainer/Winda/Control2/last_time_winda.text = Global.last_time_winda
		winda_last_chat.text = Global.last_chat_winda  # Memperbarui teks label dengan nilai terbaru dari Global.last_chat_edgar
		winda_message.visible = true
		
		if Global.chat_winda : #kalau chat winda lgi di klik
			winda_chat.visible = true
			winda_info.visible = true
			$luna_reply.visible = false
			$edgar_reply.visible = false
			$xxx_reply.visible = false
			if Global.winda_reply :
				$winda_reply.visible = true
			else :
				$winda_reply.visible = false
		else : 
			winda_chat.visible = false
			winda_info.visible = false
			
	if Global.luna : #ada chat winda yang masuk
		$VBoxContainer/Luna/Control2/last_time_luna.text = Global.last_time_luna
		luna_last_chat.text = Global.last_chat_luna  # Memperbarui teks label dengan nilai terbaru dari Global.last_chat_luna
		luna_message.visible = true

		if Global.chat_luna : #kalau chat luna lagi di buka
			luna_chat.visible = true
			luna_info.visible = true
			$winda_reply.visible = false
			$edgar_reply.visible = false
			$xxx_reply.visible = false
			if Global.luna_reply :
				$luna_reply.visible = true
			else :
				$luna_reply.visible = false
		else : 
			luna_chat.visible = false
			luna_info.visible = false
			
	if Global.xxx : #ada chat xxx yang masuk
		$VBoxContainer/XXX/Control2/last_time_xxx.text = Global.last_time_xxx
		xxx_last_chat.text = Global.last_chat_xxx  # Memperbarui teks label dengan nilai terbaru dari Global.last_chat_luna
		xxx_message.visible = true

		if Global.chat_xxx : #kalau chat xxx lagi di buka
			xxx_chat.visible = true
			xxx_info.visible = true
			$winda_reply.visible = false
			$edgar_reply.visible = false
			$luna_reply.visible = false
			if Global.luna_reply :
				$xxx_reply.visible = true
			else :
				$xxx_reply.visible = false
		else : 
			xxx_chat.visible = false
			xxx_info.visible = false

			
func _on_edgar_2_mouse_entered() -> void:
	edgar.visible = true

func _on_edgar_2_mouse_exited() -> void:
	edgar.visible = false


func _on_winda_2_mouse_entered() -> void:
	winda.visible = true



func _on_winda_2_mouse_exited() -> void:
	winda.visible = false


func _on_luna_2_mouse_entered() -> void:
	luna.visible = true


func _on_luna_2_mouse_exited() -> void:
	luna.visible = false


func _on_xxx_2_mouse_entered() -> void:
	xxx.visible = true


func _on_xxx_2_mouse_exited() -> void:
	xxx.visible = false

func _on_winda_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed :
		Global.chat_winda = true # ini berarti lg buka chatnya winda
		Global.chat_edgar = false
		Global.chat_luna = false
		Global.chat_xxx = false
		AudioPlayer.play_click()

func _on_edgar_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed :
		Global.chat_winda = false 
		Global.chat_edgar = true# ini berarti lg buka chatnya edgar
		Global.chat_luna = false
		Global.chat_xxx = false
		AudioPlayer.play_click()


func _on_luna_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed :  # ini berarti lg buka chatnya luna
		Global.chat_winda = false 
		Global.chat_edgar = false
		Global.chat_luna = true
		Global.chat_xxx = false
		AudioPlayer.play_click()


func _on_xxx_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed :  # ini berarti lg buka chatnya luna
		Global.chat_winda = false 
		Global.chat_edgar = false
		Global.chat_luna = false
		Global.chat_xxx = true
		AudioPlayer.play_click()
