extends StaticBody2D

signal player_enter_gate(body)

func _on_area_2d_body_entered(body):
	player_enter_gate.emit(body)
