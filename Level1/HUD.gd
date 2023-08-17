extends CanvasLayer

var remaining_coins :String = "x "

func _process(_delta):
	get_node("HBoxContainer/Remaining_Coins").text = remaining_coins + str(PlayerData.remaining_coins) 
