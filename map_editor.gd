extends Node

var scenario_data : Dictionary

var splatmap_texture : SubViewport
var heightmap_texture : SubViewport

var terrain : MeshInstance3D
var water : MeshInstance3D

var material : StandardMaterial3D = StandardMaterial3D.new()

var clicks_pos : PackedVector2Array

var is_paint : bool = false

func _ready():
	splatmap_texture = SubViewport.new()
	splatmap_texture.name = "splatmap"
	heightmap_texture = SubViewport.new()
	heightmap_texture.name = "heightmap"
	add_child(splatmap_texture)
	add_child(heightmap_texture)
	splatmap_texture
	var background_1 = ColorRect.new()
	background_1.color = Color.CRIMSON
	var background_2 = ColorRect.new()
	background_1.layout_direction = Control.LAYOUT_DIRECTION_INHERITED
	background_1.anchors_preset = Control.PRESET_FULL_RECT
	background_2.layout_direction = Control.LAYOUT_DIRECTION_INHERITED
	background_2.anchors_preset = Control.PRESET_FULL_RECT
	splatmap_texture.add_child(background_1)
	heightmap_texture.add_child(background_2)
	splatmap_texture.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
	splatmap_texture.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	terrain = $"GUI/2/3DEditor/VBoxContainer/SubViewportContainer/MapViewport/Map/terrain"
	water = $"GUI/2/3DEditor/VBoxContainer/SubViewportContainer/MapViewport/Map/water"



func _physics_process(delta):
	var m_pos = $"GUI/2/3DEditor/VBoxContainer/SubViewportContainer/MapViewport".get_mouse_position()
	var cam = $"GUI/2/3DEditor/VBoxContainer/SubViewportContainer/MapViewport".get_camera_3d() as Camera3D
	
	var from = cam.project_ray_origin(m_pos)
	var to = cam.project_ray_normal(m_pos) * 1000
	
	var querry = PhysicsRayQueryParameters3D.create(from,to,1,[])
	
	var space = $"GUI/2/3DEditor/VBoxContainer/SubViewportContainer/MapViewport".find_world_3d().get_direct_space_state()
	var result = space.intersect_ray(querry)
	
	
	
	if result.size() != 0 and result.collider.name == "terrain_body":
		var r = cam.unproject_position(result.position)
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			is_paint = true
			clicks_pos.append(r)
			print(clicks_pos)
			var new_line = Line2D.new()
			new_line.points = clicks_pos
			splatmap_texture.add_child(new_line)
		else:
			is_paint = false
			clicks_pos.clear()
	
	
	pass


func _on_create_pressed():
	scenario_data = {
		"name":$"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/map_name".text,
		"description":$"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/map_description".text,
		"preview":$"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/map_preview_path".text,
		"size":$"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/map_size".value,
		"players":$"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/players".value,
	}
	
	splatmap_texture.size = Vector2($"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/map_size".value,$"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/map_size".value)
	heightmap_texture.size = Vector2($"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/map_size".value,$"GUI/2/MapPanel/TabContainer/Mapa/VBoxContainer/map_size".value)
	terrain.mesh.size = Vector2(heightmap_texture.get_texture().get_image().get_width(),heightmap_texture.get_texture().get_image().get_height())
	water.mesh.size = Vector2(heightmap_texture.get_texture().get_image().get_width(),heightmap_texture.get_texture().get_image().get_height())
	terrain.material_override = material
	material.albedo_texture = splatmap_texture.get_texture()
	water.transform.origin.y = water.transform.origin.y - 7
	create_heightmap()


func create_heightmap():
	var vertex_height = 30
	var img = heightmap_texture.get_texture().get_image()
	img.resize(img.get_width(),img.get_height())
	img.convert(Image.FORMAT_RF)
	img.resize(img.get_width(),img.get_height())
	var data = img.get_data().to_float32_array()
	
	for i in data.size():
		data[i] *= vertex_height
	
	var terrain_shape = HeightMapShape3D.new()
	terrain_shape.map_width = img.get_width()
	terrain_shape.map_depth = img.get_height()
	terrain_shape.map_data = data
	var terrain_body = StaticBody3D.new()
	terrain_body.input_ray_pickable = true
	terrain.add_child(terrain_body)
	var shape = CollisionShape3D.new()
	shape.shape = terrain_shape
	terrain_body.add_child(shape)
	terrain_body.collision_layer = 1
	terrain_body.name = "terrain_body"
	shape.name = "terrain_collision_shape"
	terrain_shape.resource_name = "heightmap_shape"



