extends GraphNode


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_dragged(from, to):
	from = position
	to = get_global_mouse_position()


func _on_selected():
	pass


func _on_slot_updated(idx):
	print("Slot Selected: " + str(idx))
