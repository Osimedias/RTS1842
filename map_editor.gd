extends Node


var data = {
	
}

var map_name_ : String
var map_description : String
var map_preview = "res://sub_marcos.png"
var map_entites = {
	
}

var map_data = {
	
}

func _ready():
	map_description = "Write a nice description here"
	var d = {
		"name" : map_name_,
		"description" : map_description,
		"preview" : map_preview,
		"map_entites" : map_entites,
		"map_data" : map_data
	}
	
	data = d


func write_zip_file(map_name : String):
	var writer := ZIPPacker.new()
	var err := writer.open("user://"+map_name+".rtsmap")
	if err != OK:
		return err
	print("save map data..")
	writer.start_file("map.json")
	writer.write_file(var_to_str(data).to_utf8_buffer())
	writer.close_file()
	print("saving map textures")
	await get_tree().create_timer(1).timeout
	writer.start_file("splatmap.png")
	writer.write_file($MapTextures/splatmap.get_viewport().get_texture().get_image().save_png_to_buffer())
	writer.close_file()
	await get_tree().create_timer(1).timeout
	writer.start_file("heightmap.exr")
	writer.write_file($MapTextures/heightmap.get_viewport().get_texture().get_image().save_exr_to_buffer())
	writer.close_file()
	writer.close()
	return OK

func load_zip_file(map_name : String):
	var loader := ZIPReader.new()
	var err := loader.open("user://"+map_name+".rtsmap")
	if err != OK:
		return PackedByteArray()
	print(loader.get_files())
