extends Control

#Usar 4 texturas
var path = "res://dev/textures/"
var textures = [
]

const texture_n : String = "snow"

func _ready():
	DisplayServer.window_set_size(Vector2(1024,1024))
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	add_texture()
	create_texture()


func add_texture():
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file = dir.get_next()
		while  file != "":
			if file.ends_with(".jpg"):
				textures.append(file.get_file())
			file = dir.get_next()
	
	for i in textures.size():
		var tex : TextureRect = TextureRect.new()
		tex.texture = load(path + textures[i])
		$grid.add_child(tex)
	
	pass



func create_texture():
	await get_tree().create_timer(1).timeout
	get_viewport().get_texture().get_image().save_png("res://art/textures/terrain/"+texture_n+".png")
