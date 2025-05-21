extends Node

# Percentage base
var HOSTAGE_HP = 100.0
var MAX_HP = 100.0

func decrease_hp(amount):
	HOSTAGE_HP -= amount

func increase_sanity(amount):
	HOSTAGE_HP += amount

func reset_hp():
	HOSTAGE_HP = MAX_HP
