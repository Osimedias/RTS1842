extends Node




func _ready() -> void:
	print("Game version: 0.0.0")
	print("Made by Trinketos")



func _input(event) -> void:
	if event is InputEventKey:
		if event.scancode == KEY_S and event.is_pressed():
			get_tree().change_scene_to_file("res://Singleplayer.tscn")
		if event.scancode == KEY_M and event.is_pressed():
			get_tree().change_scene_to_file("res://Multiplayer.tscn")
		if event.scancode == KEY_T and event.is_pressed():
			get_tree().change_scene_to_file("res://Tools.tscn")
		if event.scancode == KEY_O and event.is_pressed():
			get_tree().change_scene_to_file("res://Options.tscn")
		if event.scancode == KEY_Q and event.is_pressed():
			get_tree().quit()





