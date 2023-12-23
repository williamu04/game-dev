extends Node2D

class_name level_parent

var laser_scene: PackedScene = preload("res://Scene/projectile/laser.tscn")
var grenade_scene: PackedScene = preload("res://Scene/projectile/grenade.tscn")

func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectile.add_child(grenade)
	$UI.update_gren()

func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectile.add_child(laser)
	$UI.update_laser()

func _on_house_player_enter():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8,0.8), 1)

func _on_house_player_exit():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.4,0.4),1)


func _on_player_update_stat():
	$UI.update_laser()
	$UI.update_gren()
	$UI.update_health()
