extends Control




func _ready() -> void:
	print("Game version: 0.0.0")
	print("Made by Trinketos")
	
	$MenuPanel/VBoxContainer/Button_3.disabled = OS.has_feature("Demo")



func _input(event) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_S and event.is_pressed():
			get_tree().change_scene_to_file("res://Singleplayer.tscn")
		if event.keycode == KEY_M and event.is_pressed():
			get_tree().change_scene_to_file("res://Multiplayer.tscn")
		if event.keycode == KEY_T and event.is_pressed():
			get_tree().change_scene_to_file("res://Tools.tscn")
		if event.keycode == KEY_O and event.is_pressed():
			get_tree().change_scene_to_file("res://Options.tscn")
		if event.keycode == KEY_Q and event.is_pressed():
			get_tree().quit()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://singleplayer.tscn")
	pass # Replace with function body.



func _on_configuration_pressed():
	get_tree().change_scene_to_file("res://options.tscn")
	pass # Replace with function body.


func _on_map_editor_pressed():
	get_tree().change_scene_to_file("res://map_editor.tscn")
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
