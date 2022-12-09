extends Control


var selected_map = ""
var game_mode = ""
var starting_resources = ""
var game_speed = ""
var map_size = ""

func _on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_techtree_pressed():
	$background/techtree.visible = true


func _on_start_pressed():
	var file = FileAccess.open("user://singleplayer.txt",FileAccess.WRITE)
	var map_data = {
		"selected_map" : selected_map,
		"game_mode" : game_mode,
		"starting_resources" : starting_resources,
		"game_speed" : game_speed,
		"map_size" : map_size
	}
	
	file.store_line(var_to_str(map_data))
	
	for i in range(0,$background/Panel.players.size()):
		file.store_line(var_to_str($background/Panel.players[i]))
	
	
	get_tree().change_scene_to_file("res://single_player_map.tscn")
