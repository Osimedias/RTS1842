extends Node


var save_seed : int


var players : Array

var entities : Array
var entities_position : PackedVector3Array

var actions : Array

func on_save_game_pressed():
	save_seed = get_parent().noise_seed
	
	for i in get_parent().get_node("Players").get_child_count():
		players.append(i.data)
	
	for i in get_parent().get_node("entities").get_child_count():
		entities.append(i.data)
	
	for i in entities.size():
		entities_position.append(i.transform.position)


func record_game():
	save_seed = get_parent().noise_seed
	for i in get_parent().get_node("Players").get_child_count():
		actions.append(i.actions)

