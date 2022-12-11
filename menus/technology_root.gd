extends GraphNode



func _on_dragged(from, to):
	from = position
	to = get_global_mouse_position()
