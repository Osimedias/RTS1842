extends GraphNode




func _on_dragged(from, to):
	from = position
	to = get_global_mouse_position()


func _on_slot_updated(idx):
	print("Slot selected :" + str(idx))

func _on_selected():
	pass # Replace with function body.
