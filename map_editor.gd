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


var mode : String

var points : PackedVector2Array

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_Q:
			get_tree().quit()
		if event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://main_menu.tscn")
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if mode == "Paint":
				points.append(event.position)
				print(points)

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


func _on_paint_pressed():
	%Splatmap_layer.visible = true
	%Heightmap_layer.visible = false
	$GUI/ObjectPanel.visible = false
	$GUI/ColorPicker.visible = true
	mode = "Paint"
	pass # Replace with function body.



func _on_height_pressed():
	%Splatmap_layer.visible = false
	%Heightmap_layer.visible = true
	$GUI/ObjectPanel.visible = false
	$GUI/ColorPicker.visible = false
	mode = "Paint"
	pass # Replace with function body.


func _on_flat_pressed():
	%Splatmap_layer.visible = false
	%Heightmap_layer.visible = true
	$GUI/ObjectPanel.visible = false
	$GUI/ColorPicker.visible = false
	mode = "Paint"
	pass # Replace with function body.


func _on_smooth_pressed():
	%Splatmap_layer.visible = false
	%Heightmap_layer.visible = true
	$GUI/ObjectPanel.visible = false
	$GUI/ColorPicker.visible = false
	mode = "Paint"
	pass # Replace with function body.


func _on_object_pressed():
	%Splatmap_layer.visible = false
	%Heightmap_layer.visible = true
	$GUI/ObjectPanel.visible = true
	$GUI/ColorPicker.visible = false
	mode = "Object"
	pass # Replace with function body.


func _on_player_pressed():
	pass # Replace with function body.


func _on_map_pressed():
	
	pass # Replace with function body.




func _on_save_pressed():
	%Splatmap_layer/splatmap.get_viewport().get_texture().get_image().save_png("res://map/scenario/debug.png")
	%Heightmap_layer/heightmap.get_viewport().get_texture().get_image().save_exr("res://map/scenario/debug.exr")
	pass # Replace with function body.
