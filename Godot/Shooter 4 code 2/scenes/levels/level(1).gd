extends Node2D

var test_array: Array[String] = ["Test", "Hello", "stuff"]

func _ready():
	$Logo.rotation_degrees = 90
	
	print(test_array[0])

func _process(delta):
	$Logo.rotation_degrees += 10
	
	if $Logo.position.x > 1000:
		$Logo.pos.x = 0
