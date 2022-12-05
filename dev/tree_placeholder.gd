extends StaticBody3D



func _ready():
	transform.origin.y = $ray.get_collision_normal().y



func _process(delta):
	if !$ray.is_colliding():
		transform.origin.y += 1.5 * delta
	else:
		set_process(false)
