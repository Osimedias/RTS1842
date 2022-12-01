extends Area3D

@export var structure : PackedScene
@export var build_time : float = 5


var time : float

func _process(delta):
	
	time += 1.0 * delta
	
	if time >= build_time:
		var building = structure.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		building.transform.origin = transform.origin
		get_parent().add_child(building)
		queue_free()
