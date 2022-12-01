extends SubViewport

@onready var brush: Node2D = $brush

func paint(position : Vector2, colour: Color = Color(1, 1, 1)):
	brush.queue_brush(position * 512, colour)
