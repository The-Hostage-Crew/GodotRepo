extends Label

func _process(delta):
	var timestamp = Time.get_unix_time_from_system()
	var datetime = Time.get_datetime_dict_from_unix_time(timestamp)

	var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
	var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

	var day_name = days[datetime.weekday]  # 0 = Sunday
	var month_name = months[datetime.month - 1]  # 1-based month
	var date = datetime.day

	text = "%s, %d %s" % [day_name, date, month_name]
