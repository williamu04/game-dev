class_name Player
extends CharacterBody2D


# Keep this in sync with the AnimationTree's state names and numbers.
enum States {
	IDLE = 0,
	WALK = 1,
	RUN = 2,
	FLY = 3,
	FALL = 4
}

var speed = Vector2(120.0, 360.0)
var vel = Vector2.ZERO
var falling_slow = false
var falling_fast = false
var no_move_horizontal_time = 0.0

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $Sprite2D
@onready var sprite_scale = sprite.scale.x


func _ready():
	$AnimationTree.active = true


func _physics_process(delta):
	vel.y += gravity * delta
	if no_move_horizontal_time > 0.0:
		# After doing a hard fall, don't move for a short time.
		vel.x = 0.0
		no_move_horizontal_time -= delta
	else:
		vel.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * speed.x
		if Input.is_action_pressed("walk"):
			vel.x *= 0.2
	#warning-ignore:return_value_discarded
	set_velocity(vel)
	set_up_direction(Vector2.UP)
	move_and_slide()
	vel = vel
	# Calculate flipping and falling speed for animation purposes.
	if vel.x > 0:
		sprite.transform.x = Vector2(sprite_scale, 0)
	elif vel.x < 0:
		sprite.transform.x = Vector2(-sprite_scale, 0)
	if vel.y > 500:
		falling_fast = true
		falling_slow = false
	elif vel.y > 300:
		falling_slow = true
	# Check if on floor and do mostly animation stuff based on it.
	if is_on_floor():
		if falling_fast:
			$AnimationTree["parameters/land_hard/active"] = true
			no_move_horizontal_time = 0.4
			falling_fast = false
		elif falling_slow:
			$AnimationTree["parameters/land/active"] = true
			falling_slow = false
		if Input.is_action_just_pressed("jump"):
			$AnimationTree["parameters/jump/active"] = true
			vel.y = -speed.y
		if abs(vel.x) > 50:
			$AnimationTree["parameters/state/current"] = States.RUN
			$AnimationTree["parameters/run_timescale/scale"] = abs(vel.x) / 60
		elif vel.x:
			$AnimationTree["parameters/state/current"] = States.WALK
			$AnimationTree["parameters/walk_timescale/scale"] = abs(vel.x) / 12
		else:
			$AnimationTree["parameters/state/current"] = States.IDLE
	#else:
		#if vel.y > 0:
			##$AnimationTree["parameters/state/current"] = States.WALK
		##else:
			#$AnimationTree["parameters/state/current"] = States.FLY