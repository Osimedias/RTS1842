extends Panel


@onready var tree = $tree

var civ : Civilization

var list = []

func _ready():
	dir_contents("res://data/civilization/")
	for i in list.size():
		$civilizations.add_item(list[i],i)


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




func _on_back_pressed():
	visible = false
	pass # Replace with function body.
