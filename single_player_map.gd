extends Node3D


var players : PackedInt32Array


var map : Script


var terrain_mesh : PlaneMesh

var material : ShaderMaterial

var terrain_shape : HeightMapShape3D
var terrain_body : StaticBody3D
var shape : CollisionShape3D

var noise : NoiseTexture2D

var vertex_height = 10


func _ready():
	noise = NoiseTexture2D.new()
	noise.noise = FastNoiseLite.new()
	await  noise.changed
	terrain_mesh = PlaneMesh.new()
	
	material = load("res://data/material/terrain.material")
	material.set_shader_parameter("terrain_height_map",noise)
	terrain_mesh.material = material
	terrain_mesh.size = Vector2(512,512)
	terrain_mesh.subdivide_depth = 200
	terrain_mesh.subdivide_width = 200
	
	$terrain.mesh = terrain_mesh
	
	var img = noise.get_image()
	img.resize(terrain_mesh.size.x + 1,terrain_mesh.size.y + 1)
	terrain_shape = HeightMapShape3D.new()
	
	terrain_shape.map_depth = img.get_height()
	terrain_shape.map_width = img.get_width()
	
	var data : PackedFloat32Array
	
	for y in img.get_height():
		for x in img.get_width():
			data.push_back(img.get_pixel(x,y).r*vertex_height+1)
	
	shape = CollisionShape3D.new()
	
	terrain_shape.map_data = data
	shape.shape = terrain_shape
	terrain_body = StaticBody3D.new()
	
	$terrain.add_child(terrain_body)
	terrain_body.add_child(shape)
	$gi.extents = Vector3(terrain_mesh.size.x,200,terrain_mesh.size.y)
	$gi.call_deferred("bake")


func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_Q:
			get_tree().quit()


