extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		PlayerData.remaining_coins -= 1 
		get_node("Area2D/Collect").play()		
		PlayerData.collected_coins.append(self.global_position)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 0, 0.01)
		tween.tween_callback(queue_free)
		
