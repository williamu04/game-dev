extends CanvasLayer

func game_over():
	$AnimationPlayer.play("over")
	await $AnimationPlayer.animation_finished
	get_tree().set_pause(true)
