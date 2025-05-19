extends RayCast3D

var current_collider
@onready var texture_rect: TextureRect = $TextureRect

var curtain_interacted := false  # Flag khusus untuk CurtainInteraction
var safebox_interacted := false  

#func _ready() -> void:
	#self.connect("safe")


func _process(delta):
	var collider = get_collider()
	texture_rect.hide()

	if is_colliding() and collider is Interactable:
		if collider.get_enabled():
			var is_curtain: bool = collider.name == "CurtainInteraction"


			# Jika itu CurtainInteraction dan sudah pernah dipanggil, skip
			if is_curtain and curtain_interacted:
				return

			texture_rect.show()
			if Input.is_action_just_pressed("interact"):
				collider.interact()

				# Tandai CurtainInteraction sebagai sudah diinteract
				if is_curtain:
					curtain_interacted = true
