extends Node3D


var players : Array

var material : ShaderMaterial

var terrain_shape : HeightMapShape3D
var terrain_body : StaticBody3D
var shape : CollisionShape3D

var noise : NoiseTexture2D

var vertex_height = 32

var noise_seed : int


var is_scenario : bool = false

var player_node : PackedScene = load("res://game/player.tscn")

var water_height : float = 3.5

func _ready():
	var heightmap = load("res://data/maps/terrains/terrain_01.exr")
	material = load("res://data/material/terrain.material")
	%terrain.material_override = material
	create_terrain()
	material.set_shader_parameter("terrain_height_map",heightmap)
	material.set_shader_parameter("vertex_height",vertex_height)

func create_terrain():
	create_heightmap("res://data/maps/terrains/terrain_01.exr")
	call_deferred("spawn_object",load("res://data/simulation/flora/pine.tscn"))


func create_heightmap(heightmap : String = ""):
	var img = Image.new()
	img.load(heightmap)
	img.convert(Image.FORMAT_RF)
	img.resize(img.get_width(),img.get_height())
	material.set_shader_parameter("terrain_height_map",heightmap)
	material.set_shader_parameter("vertex_height",vertex_height)
	var data = img.get_data().to_float32_array()
	
	for i in data.size():
		data[i] *= vertex_height
	
	terrain_shape = HeightMapShape3D.new()
	terrain_shape.map_width = img.get_width()
	terrain_shape.map_depth = img.get_height()
	terrain_shape.map_data = data
	%terrain.mesh.size = Vector2(img.get_width(),img.get_height())
	terrain_body = StaticBody3D.new()
	add_child(terrain_body)
	shape = CollisionShape3D.new()
	shape.shape = terrain_shape
	terrain_body.add_child(shape)
	terrain_body.collision_layer = 1
	terrain_body.name = "terrain_body"
	shape.name = "terrain_collision_shape"
	terrain_shape.resource_name = "heightmap_shape"
	$water.mesh.size = Vector2(img.get_width(),img.get_height())
	$water.transform.origin.y = water_height


func spawn_object(object : PackedScene):
	
	var new_object = object.instantiate()
	
	var query = PhysicsShapeQueryParameters3D.new()
	
	var space_state = get_world_3d().direct_space_state
	query.shape = new_object.get_node("col").shape
	var hits = space_state.intersect_shape(query)
	
	if hits.size() != 0:
		pass
	
	$entities.add_child(new_object)



func create_players(radius : float,scene : PackedScene):
	var angle = 0
	var center = %terrain.transform.origin
	var angle_steps = 2.0 * PI / players.size()
	
	for i in range(0,players.size()):
		var direction = Vector3(cos(angle),0,sin(angle))
		var pos = center + direction * radius
		
		var spawner : PackedScene = scene
		var new = spawner.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		$entities.add_child(new)
		new.transform.origin = pos
		angle += angle_steps


func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_Q:
			get_tree().quit()


