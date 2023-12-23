extends Area2D

signal player_enter
signal player_exit

func _on_body_entered():
	player_enter.emit()

func _on_body_exited():
	player_exit.emit()
