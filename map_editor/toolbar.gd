extends Panel

var map_name : String

func _ready():
	
	var file_call = Callable(self,"on_id_pressed")
	$HBoxContainer/MenuButton.get_popup().id_pressed.connect(file_call)





func on_id_pressed(id):
	match $HBoxContainer/MenuButton.get_popup().get_item_text(id):
		"Save Scenario As...":
			$"../save_panel".visible = true
		"Load Scenario":
			$"../load_panel".visible = true
		"Close":
			get_tree().quit()
	
	
	pass
