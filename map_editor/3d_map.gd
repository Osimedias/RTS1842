extends Node3D


var material : ShaderMaterial = ShaderMaterial.new()

func _ready():
	var splatmap = $"../MapTextures/splatmap"
	var heightmap = $"../MapTextures/heightmap"
	material.shader = load("res://game/shaders/terrain.gdshader")
	material.set_shader_parameter("splat_map",splatmap.get_texture())
	material.set_shader_parameter("height_map",heightmap.get_texture())
	$terrain.mesh.material = material
	create_heightmap_shape()
	
	var file = FileAccess.open("user://map_data.txt",FileAccess.WRITE)
	file.store_string(str(heightmap.get_texture().get_image().get_data()))
	



func create_heightmap_shape():
	var tex = $"../MapTextures/heightmap".get_texture().get_image()
	tex.convert(Image.FORMAT_RF)
	tex.resize($terrain.mesh.size.x + 1,$terrain.mesh.size.y + 1)
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




