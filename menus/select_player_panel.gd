extends Panel





func _ready():
	create_player_panel(%player_slot_1,"Player 1",Color.from_string("Player 1",Color.BLUE),1)
	create_player_panel(%player_slot_2,"Player 2",Color.from_string("Player 2",Color.RED),2)
	var player_1 = {
		"index" : 1,
		"name" : "player_1",
		"color" : Color.BLUE,
		"team" : 1,
	}
	var player_2 = {
		"index" : 2,
		"name" : "player_2",
		"color" : Color.RED,
		"team" : 2,
	}
	PlayerMapData.add_player_to_list(player_1)
	PlayerMapData.add_player_to_list(player_2)



func create_player_panel(slot : Node,player_name : String,color : Color,team : int):
	var name_label = Label.new()
	var civ_list_btn = OptionButton.new()
	var color_btn = ColorPickerButton.new()
	var team_spin_box = SpinBox.new()
	
	name_label.text = player_name
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.name = "name_label"
	civ_list_btn.name = "civ_list_btn"
	civ_list_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	color_btn.name = "color_btn"
	team_spin_box.name = "team_spin_box"
	name_label.layout_direction = Control.LAYOUT_DIRECTION_INHERITED
	name_label.anchors_preset = Control.ANCHOR_BEGIN
	
	color_btn.color = color
	color_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	team_spin_box.value = team
	team_spin_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	team_spin_box.min_value = 1
	team_spin_box.max_value = 8
	
	slot.add_child(name_label)
	slot.add_child(civ_list_btn)
	slot.add_child(color_btn)
	slot.add_child(team_spin_box)

func free_player_panel(panel : Node):
	for i in range(0,panel.get_child_count()):
		panel.get_child(i).queue_free()
	var index = str(panel.name)
	#PlayerMapData.players.erase()



func _on_counter_value_changed(value):
	var player_counter := 2
	player_counter = value
	var hash = str(get_node("players/player_slot_"+str(player_counter)).name.hash())
	
	if player_counter >= 3:
		create_player_panel(get_node("players/player_slot_"+str(player_counter)),"player "+str(value),Color.from_string(hash,Color.YELLOW_GREEN),value)
	var player_data = {
		"index" : value,
		"name" : "player "+str(value),
		"color" : Color.from_string(hash,Color.YELLOW_GREEN),
		"team" : value,
	}
	PlayerMapData.add_player_to_list(player_data)
	if player_counter >= 2:
		free_player_panel(get_node("players/player_slot_" + str(player_counter+1)))


