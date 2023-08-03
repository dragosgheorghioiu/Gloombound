extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
#		.set_deferred("monitoring", false)    
		get_node("Area2D/CollisionShape2D").disabled = true
		PlayerData.remaining_coins -= 1 
		get_node("Area2D/Collect").play()
		PlayerData.collected_coins.append(self.global_position)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 0, 0.01)
		await get_node("Area2D/Collect").finished
		tween.tween_callback(queue_free)
		
