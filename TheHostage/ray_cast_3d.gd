extends RayCast3D

var current_collider
@onready var prompt: Label = $Prompt
@onready var texture_rect: TextureRect = $TextureRect

func _ready():
	pass

func _process(delta):
	prompt.text =""
	var collider = get_collider()
	texture_rect.hide()
	if is_colliding() and collider is Interactable:
		#prompt.text = collider.get_prompt()
		texture_rect.show()
		if Input.is_action_just_pressed("interact"):
			collider.interact()
