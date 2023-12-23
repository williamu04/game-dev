extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)
signal update_stat

var onLaser: bool = true
var onGrenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#input movement
	var direct = Input.get_vector("left", "right", "up", "down")
	velocity = direct*speed
	move_and_slide()
	
	#rotate
	look_at(get_global_mouse_position())
	
	#laser shooting
	if Input.is_action_just_pressed("primary") and onLaser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_pos = $LaserStart.get_children()
		var mark = laser_pos[randi()%laser_pos.size()]
		var player_direct = (get_global_mouse_position()-position).normalized()
		onLaser = false
		$Timer.start()
		laser.emit(mark.global_position, player_direct)
	
	#grenade
	if Input.is_action_just_pressed("secondary") and onGrenade and Globals.gren_amount > 0:
		Globals.gren_amount -= 1
		var pos = $LaserStart.get_children()[0].global_position
		var direction = (get_global_mouse_position() - position).normalized()
		onGrenade = false
		$Timer2.start()
		grenade.emit(pos, direction)


func _on_timer_timeout():
	onLaser = true
	
func _on_timer_2_timeout():
	onGrenade = true


