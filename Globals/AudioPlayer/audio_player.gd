extends AudioStreamPlayer

const bgm_menu = preload("uid://cpexcdf1b4cg5")
const sfx_hover = preload("uid://cbebxjus0ojkt")

func _play_sound(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_bgm_menu():
	_play_sound(bgm_menu)


func _play_sfx(stream: AudioStream, volume = 0.0):
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = stream
	sfx_player.volume_db = volume
	sfx_player.name = "SFXPlayer"
	add_child(sfx_player)
	sfx_player.play()
	
	await sfx_player.finished
	
	sfx_player.queue_free()

func play_sfx_hover():
	_play_sfx(sfx_hover)
