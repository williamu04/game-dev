extends Node2D


func _on_area_2d_body_entered(_body):
	print("body has entered")


func _on_area_2d_body_exited(_body):
	print("body has exited")
