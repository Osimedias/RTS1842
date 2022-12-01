extends Node3D


var material : ShaderMaterial = ShaderMaterial.new()

var terrain : MeshInstance3D

var map_size : Vector2 = Vector2(200,200)

func _ready():
	terrain = $terrain
	var heightmap = $"../MapTextures/heightmap"
	var splatmap =  $"../MapTextures/splatmap"
	material.shader = load("res://game/shaders/terrain.gdshader")
	material.set_shader_parameter("height_map",heightmap.get_viewport().get_texture())
	material.set_shader_parameter("splat_map", splatmap.get_viewport().get_texture())
	terrain.material_override = material
	create_heightmap_shape()



func create_heightmap_shape():
	var tex = $"../MapTextures/heightmap".get_texture().get_image()
	tex.convert(Image.FORMAT_RF)
	tex.resize(map_size.x + 1,map_size.y + 1)
	var collision_shape : StaticBody3D = StaticBody3D.new()
	var height_map_shape : HeightMapShape3D = HeightMapShape3D.new()
	var coll : CollisionShape3D = CollisionShape3D.new()
	height_map_shape.map_depth = tex.get_height()
	height_map_shape.map_width = tex.get_width()
	height_map_shape.map_data = tex.get_data().to_float32_array()
	coll.shape = height_map_shape
	$terrain.add_child(collision_shape)
	collision_shape.add_child(coll)
	
	pass




