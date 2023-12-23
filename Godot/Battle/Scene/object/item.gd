extends Area2D

var rotation_speed: int = 4
var opsi = ['laser','laser','laser','laser','laser', 'grenade', 'grenade', 'health']
var type = opsi[randi()%len(opsi)]

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(0.2, 0.1, 0.8)
	if type == 'grenade':
		$Sprite2D.modulate = Color(0.8, 0.1, 0.2)
	if type == 'health':
		$Sprite2D.modulate = Color(0.1, 0.8, 0.1)

func _process(delta):
	rotation += rotation_speed*delta


func _on_body_entered(body):
	if type == 'laser':
		Globals.laser_amount += 5
	if type == 'grenade':
		Globals.gren_amount += 1
	if type == 'health':
		Globals.health += 10
	queue_free()
