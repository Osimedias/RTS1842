extends Panel


var players : Array

var list : Array

func _ready():
	dir_contents("res://data/civilization/")
	create_player_panel($players/player_slot_1,0,"Player 1",Color.BLUE,1)
	create_player_panel($players/player_slot_2,1,"Player 2",Color.RED,2)
	create_player_panel($players/player_slot_3,2,"Player 3",Color(randf(),randf(),randf()),3)
	create_player_panel($players/player_slot_4,3,"Player 4",Color(randf(),randf(),randf()),4)

func dir_contents(path : String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found directory: " + file_name)
				list.append(file_name.get_basename())
				print(list)
			file_name = dir.get_next()
	else:
		printerr("An error occurred when trying to access the path.")

func create_player_panel(slot : Control,civ_index : int,player_name : String,color : Color,team : int):
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
	
	for i in list.size():
		civ_list_btn.add_item(list[i],i)
		#civ_list_btn.set_item_icon(list[i],load(list[i].flag))
	
	var civ = Callable(self,"_on_item_selected")
	civ_list_btn.item_selected.connect(civ)
	civ_list_btn.select(civ_index)
	var data = {
		"name" : player_name,
		"color" : color,
		"team" : team,
		"civ" : civ_list_btn.get_item_text(civ_index)
	}
	players.append(data)





#Buscar una forma mejor de hacer esto
func _on_item_selected(id : int):
	
	match id:
		0:
			return "british"
		1:
			return "france"
		2:
			return "mexicans"
		3:
			return "spanish"
		4:
			return "unite states"


