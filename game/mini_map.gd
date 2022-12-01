extends Control




var splatmap
var entities


func _ready():
	splatmap = $"../../MapTextures/splatmap".get_viewport().get_texture()
	#entities = $"../../MapTextures/mini_map".get_viewport().get_texture()
	
	$terrain.texture = splatmap
	#$map_entities.texture = entities



