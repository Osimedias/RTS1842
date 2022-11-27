extends Node2D


var noise : FastNoiseLite = FastNoiseLite.new()
var splat_map_noise : FastNoiseLite = FastNoiseLite.new()

var map_size := Vector2(512,512)


var map_seed : int

var splatmap : ImageTexture
var heightmap : ImageTexture

var splat_viewport : SubViewport
var height_viewport : SubViewport


func _ready():
	map_seed = randi()
	noise.seed = map_seed
	splat_map_noise.seed = randi()
	
	splatmap.create_from_image(splat_map_noise.get_image(map_size.x,map_size.y))
	heightmap.create_from_image(splat_map_noise.get_image(map_size.x,map_size.y))
	

func _draw():
	var rect = Rect2(Vector2(0,0),map_size)
	splat_viewport.get_node("painter").draw_texture_rect(splatmap,rect,false)
	height_viewport.get_node("painter").draw_texture_rect(heightmap,rect,false)
	
	pass 

