extends Node2D

func _ready():
	PlayerData.remaining_coins = 1
	PlayerData.current_level = 1

func _on_child_exiting_tree(node):
	if node.name == "Player":
		var player = preload("res://player.tscn")
		var player_temp = player.instantiate()
		player_temp.position = PlayerData.initial_coordinates
		call_deferred("add_child", player_temp)
		get_node("GloomGate/GloomTrigger/AnimatedSprite2D").play("shimmer")
