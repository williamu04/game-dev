extends level_parent


func _on_gate_player_enter_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	Transisi.change_scene("res://Scene/levels/indor.tscn")


