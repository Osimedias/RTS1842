extends Control




func _on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_techtree_pressed():
	$background/techtree.visible = true


func _on_start_pressed():
	get_tree().change_scene_to_file("res://single_player_map.tscn")
