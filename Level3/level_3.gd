extends Node2D

func _ready():
	PlayerData.remaining_coins = 16
	PlayerData.current_level = 3
	
func place_coins():
	for n in PlayerData.collected_coins:
		var coins = preload("res://coin.tscn")
		var coins_temp = coins.instantiate()
		coins_temp.position = n
		call_deferred("add_child", coins_temp)

func _on_child_exiting_tree(node):
	if node.name == "Player":
		var player = preload("res://player.tscn")
		var player_temp = player.instantiate()
		player_temp.position = PlayerData.initial_coordinates
		call_deferred("add_child", player_temp)
		get_node("GloomGate/GloomTrigger/AnimatedSprite2D").play("shimmer")
		place_coins()
		PlayerData.collected_coins.clear()
		PlayerData.remaining_coins = 16
