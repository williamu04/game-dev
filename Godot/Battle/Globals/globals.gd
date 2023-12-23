extends Node

signal stat_up

var laser_amount = 5:
	set(v):
		laser_amount = v
		stat_up.emit()
var gren_amount = 5:
	set(v):
		gren_amount = v
		stat_up.emit()
var health = 10:
	set(v):
		health = v
		stat_up.emit()
