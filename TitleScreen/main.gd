extends Node2D

var play_cursor_sound: bool = false

func _ready():
	PlayerData.from_level_select = false
	get_node("Audio/MainMenuTheme").play()
	get_node("VBoxContainer/VBoxContainer/START").grab_focus()
	play_cursor_sound = true
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		PlayerData.from_level_select = true
		get_tree().change_scene_to_file("res://test_level.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Level1/level_1.tscn")

func _on_quit_pressed():
	Sound.play_back_sound()
	get_tree().quit()

func _on_level_select_pressed():
	Sound.play_confirm_sound()
	play_cursor_sound = false
	get_node("VBoxContainer/VBoxContainer/START").release_focus()
	get_node("VBoxContainer/VBoxContainer2/HBoxContainer/LEVEL1").grab_focus()
	play_cursor_sound = true
	get_node("VBoxContainer/Level_Select_Label").visible = true
	get_node("VBoxContainer/Title").visible = false
	get_node("VBoxContainer/VBoxContainer").visible = false
	get_node("VBoxContainer/VBoxContainer2").visible = true

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Level1/level_1.tscn")
	PlayerData.from_level_select = true

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://level2/level_2.tscn")
	PlayerData.from_level_select = true
	
func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Level3/level_3.tscn")
	PlayerData.from_level_select = true

func _on_back_pressed():
	Sound.play_back_sound()
	play_cursor_sound = false
	get_node("VBoxContainer/VBoxContainer/START").grab_focus()
	get_node("VBoxContainer/VBoxContainer2/HBoxContainer/LEVEL1").release_focus()
	play_cursor_sound = true
	get_node("VBoxContainer/Level_Select_Label").visible = false
	get_node("VBoxContainer/Title").visible = true
	get_node("VBoxContainer/VBoxContainer").visible = true
	get_node("VBoxContainer/VBoxContainer2").visible = false


func _on_start_focus_entered():
	if play_cursor_sound:
		get_node("Audio/Cursor").play()


func _on_level_select_focus_entered():
	if play_cursor_sound:
		get_node("Audio/Cursor").play()


func _on_quit_focus_entered():
	if play_cursor_sound:
		get_node("Audio/Cursor").play()


func _on_level_1_focus_entered():
	if play_cursor_sound:
		get_node("Audio/Cursor").play()


func _on_level_2_focus_entered():
	if play_cursor_sound:
		get_node("Audio/Cursor").play()


func _on_level_3_focus_entered():
	if play_cursor_sound:
		get_node("Audio/Cursor").play()


func _on_back_focus_entered():
	if play_cursor_sound:
		get_node("Audio/Cursor").play()


func _on_audio_stream_player_2d_finished():
	get_node("Audio/MainMenuTheme").play()
