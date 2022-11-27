extends Node2D

var noise = FastNoiseLite.new()
var map_radius : Vector2
var center_radius : Vector2 = Vector2.ZERO




func _ready():
	continent()

func continent():
	center_radius = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2)

func _draw():
	draw_circle(center_radius,5.1,Color.RED)
	for i in 2:
		for j in 2:
			var n = noise.get_noise_2d(i,j)
			draw_circle(Vector2(n, n),5.1,Color.RED)
	pass

