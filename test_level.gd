extends Node2D

func _ready():
	PlayerData.remaining_coins = get_node("Collectables").get_child_count()
	PlayerData.current_level = 2
	
func place_coins():
	for n in PlayerData.collected_coins:
		var coins = preload("res://coin.tscn")
		var coins_temp = coins.instantiate()
		coins_temp.position = n
		get_node("Collectables").call_deferred("add_child", coins_temp)

func _on_child_exiting_tree(node):
	if node.name == "Player":
		var player = preload("res://player.tscn")
		var player_temp = player.instantiate()
		player_temp.position = PlayerData.initial_coordinates
		call_deferred("add_child", player_temp)
		place_coins()
		PlayerData.collected_coins.clear()
		PlayerData.remaining_coins = 7
