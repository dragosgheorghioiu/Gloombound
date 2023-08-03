extends Node2D

func _ready():
	get_node("AudioStreamPlayer2D").play()


func _on_button_6_pressed():
	get_tree().quit()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Level1/level_1.tscn")



func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://level_select.tscn")
