extends CharacterBody3D

@export var building_fundation : PackedScene

@export var grid_size : float



func _physics_process(_delta):
#	transform.origin.x = floor(transform.origin.x / grid_size) * grid_size
#	#transform.origin.y = floor(transform.origin.y / grid_size) * grid_size
#	transform.origin.z = floor(transform.origin.z / grid_size) * grid_size
	
	transform.origin.y = $height_detector.get_collision_normal().y



func _unhandled_input(event):
	
	if event is InputEventMouseMotion:
		var from = get_viewport().get_camera_3d().project_ray_origin(event.position)
		var to = from + get_viewport().get_camera_3d().project_ray_normal(event.position) * 50000
		
		var querry = PhysicsRayQueryParameters3D.create(from,to,1)
		
		querry.from = from
		querry.to = to
		
		var collision = get_world_3d().direct_space_state.intersect_ray(querry)
		
		if collision.size() > 0:
			transform.origin = collision.position
			#transform.origin.y = 0
		
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			
			var fundation = building_fundation.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			fundation.name = "fundation"
			fundation.transform.origin = transform.origin
			$"../entities".add_child(fundation)
			queue_free()





