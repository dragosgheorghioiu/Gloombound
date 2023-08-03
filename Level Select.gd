extends Node2D

func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Level3/level_3.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Level1/level_1.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://level2/level_2.tscn")
