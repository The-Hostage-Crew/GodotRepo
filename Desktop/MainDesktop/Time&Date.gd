extends Label

@onready var timer := Timer.new()

func _ready():
	horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	update_time()
	
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(update_time)
	add_child(timer)
	timer.start()

func update_time():
	var time = Time.get_datetime_dict_from_system()
	
	var hour = str(time["hour"]).pad_zeros(2)
	var minute = str(time["minute"]).pad_zeros(2)
	var time_str = "%s:%s" % [hour, minute]

	var day = str(time["day"]).pad_zeros(2)
	var month = str(time["month"]).pad_zeros(2)
	var year = str(time["year"])
	var date_str = "%s/%s/%s" % [day, month, year]

	text = "%s\n%s" % [time_str, date_str]
