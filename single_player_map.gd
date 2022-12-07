extends Node3D


var players : Array

var material : ShaderMaterial

var terrain_shape : HeightMapShape3D
var terrain_body : StaticBody3D
var shape : CollisionShape3D

var noise : NoiseTexture2D

var vertex_height = 10

var noise_seed : int


var is_scenario : bool = false

var player_node : PackedScene = load("res://game/player.tscn")



func _ready():
	create_terrain(Vector2(1024,1024))

func create_terrain(map_size : Vector2 = Vector2(200,200)):
	noise = NoiseTexture2D.new()
	noise.noise = $textures/heightmap/TextureRect.texture.noise
	noise_seed = noise.noise.seed
	await  noise.changed
	
	material = load("res://data/material/terrain.material")
	material.set_shader_parameter("terrain_height_map",noise)
	%terrain.mesh.material = material
	%terrain.mesh.size = map_size
	
	
	var img = noise.get_image()
	@warning_ignore(narrowing_conversion)
	img.resize(%terrain.mesh.size.x + 1,%terrain.mesh.size.y + 1)
	terrain_shape = HeightMapShape3D.new()
	
	terrain_shape.map_depth = img.get_height()
	terrain_shape.map_width = img.get_width()
	
	@warning_ignore(unassigned_variable)
	var data : PackedFloat32Array
	
	for y in img.get_height():
		for x in img.get_width():
			data.push_back(img.get_pixel(x,y).r*vertex_height+0.5)
	shape = CollisionShape3D.new()
	
	terrain_shape.map_data = data
	shape.shape = terrain_shape
	terrain_body = StaticBody3D.new()
	
	%terrain.add_child(terrain_body)
	terrain_body.add_child(shape)
	
	
	#print($terrain.find_path($camera_controller.transform.origin,Vector3(32,0,32)))
	
	


func create_players(radius : float):
	var angle = 0
	var center = %terrain.transform.origin
	var angle_steps = 2.0 * PI / players.size()
	
	for i in range(0,players.size()):
		var direction = Vector3(cos(angle),0,sin(angle))
		var pos = center + direction * radius
		
		var spawner : PackedScene = load("res://data/simulation/structures/zapotecs/defense_tower.tscn")
		var new = spawner.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		$entities.add_child(new)
		new.transform.origin = pos
		angle += angle_steps
	pass

#No probado
func set_map_data(rms : Node2D):
	var viewport_group = Node.new()
	var new_splatmap = SubViewport.new()
	var new_height_map = SubViewport.new()
	material = load("res://data/material/terrain.material")
	material.set_shader_parameter("terrain_height_map",new_height_map.get_viewport().get_texture().get_image().get_data())
	material.set_shader_parameter("terrain_texture",new_splatmap.get_viewport().get_texture().get_image().get_data())
	add_child(viewport_group)
	viewport_group.add_child(new_splatmap)
	viewport_group.add_child(new_height_map)
	new_splatmap.add_child(rms)
	new_splatmap.get_child(0).generate_splatmap()
	new_height_map.get_child(0).generate_height_map()



func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_Q:
			get_tree().quit()


