extends Node2D

func _on_gloom_trigger_body_entered(body):

	if body.name == "Player":
		get_node("GloomTrigger/AnimatedSprite2D").play("dissapear")
		var gloom = preload("res://gloom.tscn")
		var gloom_temp = gloom.instantiate()
		gloom_temp.position = PlayerData.initial_coordinates
		get_node("../Mobs").call_deferred("add_child", gloom_temp)
		await get_node("GloomTrigger/AnimatedSprite2D").animation_finished
		

