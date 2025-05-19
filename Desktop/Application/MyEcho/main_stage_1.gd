extends Node2D

@onready var timer = $Timer
@onready var message_on = $message_bar/message_on

@onready var chat_winda : Node2D = $ChatWinda
@onready var chat_edgar : Node2D = $ChatEdgar
@onready var chat_luna : Node2D = $ChatLuna
@onready var chat_xxx : Node2D = $ChatTheXXX

var chat1 = true
var chat2 = true
var reply = Global.reply
func _ready():
	timer.wait_time = 0.2
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

func _process(delta: float) -> void:

	if Global.chat_winda :
		chat_winda.visible = true
	else : 
		chat_winda.visible = false
		
	if Global.chat_edgar :
		chat_edgar.visible = true
	else : 
		chat_edgar.visible = false
		
	if Global.chat_luna :
		chat_luna.visible = true
	else : 
		chat_luna.visible = false
		
	if Global.chat_xxx :
		chat_xxx.visible = true
	else : 
		chat_xxx.visible = false

func _on_message_mouse_entered() -> void:
	message_on.visible = true

func _on_message_mouse_exited() -> void:
	message_on.visible = false

func _on_message_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed && Global.edgar_reply && Global.chat_edgar : #klo klik reply
		Global.chat_edgar_count += 1
		AudioPlayer.play_click()
	elif event is InputEventMouseButton and event.pressed && Global.winda_reply && Global.chat_winda : #klo klik reply
		Global.chat_winda_count += 1
		AudioPlayer.play_click()
	elif event is InputEventMouseButton and event.pressed && Global.luna_reply && Global.chat_luna : #klo klik reply
		Global.chat_luna_count += 1
		AudioPlayer.play_click()
	elif event is InputEventMouseButton and event.pressed && Global.luna_reply && Global.chat_luna : #klo klik reply
		Global.chat_luna_count += 1
		AudioPlayer.play_click()
			
func _on_timer_timeout() -> void:
	pass
