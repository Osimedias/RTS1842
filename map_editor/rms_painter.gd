extends Control


var rms : Array


func _ready():
	dir_contents("res://map/rms/")
	for i in rms.size():
		$OptionButton.add_item(rms[i],i)
	$rms.set_script("res://map/rms/islands.gd")
	pass

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
				rms.append(file_name.get_basename())
				print(rms)
			file_name = dir.get_next()
	else:
		printerr("An error occurred when trying to access the path.")
