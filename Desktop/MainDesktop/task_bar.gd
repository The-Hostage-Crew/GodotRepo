extends Node2D

@onready var SearchOn = $HBoxContainer/SearchIcon/Search_On
@onready var WindowsOn = $HBoxContainer/WindowsIcon/WindowsIcon_On
@onready var FolderOn = $HBoxContainer/Folder/FolderOn
@onready var MyEchoOn = $HBoxContainer/MyEcho/MyEchoOn
@onready var BrowserOn = $HBoxContainer/Browser/BrowserOn
@onready var MyEchoTrue = $HBoxContainer/MyEcho/myecho_true
@onready var animation_windows: AnimatedSprite2D = $WindowsIcon/AnimatedSprite2D
var windows_click = true

func _on_aera_search_mouse_entered() -> void:
	SearchOn.visible = true

func _on_aera_search_mouse_exited() -> void:
	SearchOn.visible = false

func _on_windows_mouse_entered() -> void:
	WindowsOn.visible = true

func _on_windows_mouse_exited() -> void:
	WindowsOn.visible = false

func _on_folder_mouse_entered() -> void:
	FolderOn.visible = true

func _on_folder_mouse_exited() -> void:
	FolderOn.visible = false

func _on_myecho_mouse_entered() -> void:
	MyEchoOn.visible = true

func _on_myecho_mouse_exited() -> void:
	MyEchoOn.visible = false

func _on_browser_mouse_entered() -> void:
	BrowserOn.visible = true

func _on_browser_mouse_exited() -> void:
	BrowserOn.visible = false


func _on_windows_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$mouse_click.play()
		if windows_click == false :
			animation_windows.play("Out")
			windows_click = true
			$WindowsIcon/button.visible = false
			$WindowsIcon/Button_click.visible = false
		elif  windows_click == true : 
			animation_windows.play("enter")
			windows_click = false
			$WindowsIcon/button.visible = true
			
