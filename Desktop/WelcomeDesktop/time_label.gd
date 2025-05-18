extends Label

func _process(delta):
	var time_dict = Time.get_time_dict_from_system()
	var hour = time_dict.hour
	var minute = time_dict.minute
	text = "%02d:%02d" % [hour, minute]
