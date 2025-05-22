extends Node

var HOSTAGE_SANITY = 100.0
var MAX_SANITY = 100.0

func decrease_sanity(amount):
	return
	#HOSTAGE_SANITY -= amount

func increase_sanity(amount):
	HOSTAGE_SANITY += amount

func reset_sanity():
	HOSTAGE_SANITY = MAX_SANITY
