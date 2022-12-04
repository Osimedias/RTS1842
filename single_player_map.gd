extends Node3D


var players : PackedInt32Array


var map : RMSTexture


var terrain_mesh : PlaneMesh

var material : ShaderMaterial


func _ready():
	map = RMSTexture.new()
	terrain_mesh = PlaneMesh.new()
	terrain_mesh.size = map.map_size
	$terrain.mesh = terrain_mesh






func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_Q:
			get_tree().quit()
