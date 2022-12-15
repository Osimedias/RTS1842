extends CharacterBody3D


const SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var target : Vector3

var path : PackedVector3Array



func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
		#$height_detector.force_raycast_update()
			var from = get_viewport().get_camera_3d().project_ray_origin(event.position)
			var to = from + get_viewport().get_camera_3d().project_ray_normal(event.position) * 10000
			
			var querry = PhysicsRayQueryParameters3D.create(from,to,1)
			
			querry.from = from
			querry.to = to
			
			var collision = get_world_3d().direct_space_state.intersect_ray(querry)
			
			if collision.size() > 0:
				target = collision.position
				#path = get_parent().get_parent().get_node("terrain").find_path(position,collision.normal)
				#draw_path(path)

func _physics_process(delta):
	velocity.y = $ray.get_collision_point().y
	
	var direction = Vector3.ZERO
	
	var step_size = delta * SPEED
	
	path = get_parent().get_parent().get_node("terrain").find_path(position,target)
	
	if path.is_empty():
		var destination := path[0]
		
		direction = destination - position
		
		if step_size > direction.length():
			step_size = direction.length()
			path.remove_at(0)
		
		velocity = direction.normalized() * step_size
		move_and_slide()
		
		direction.y = 0
		if direction:
			look_at(target,Vector3.UP)
	
	


func draw_path(path_array : PackedVector3Array) -> void:
	var im : ImmediateMesh = get_parent().get_parent().get_node("pathfinder_debuger").mesh
	im.clear_surfaces()
	im.surface_begin(Mesh.PRIMITIVE_POINTS)
	im.surface_add_vertex(path_array[0])
	im.surface_add_vertex(path_array[path_array.size() - 1])
	im.surface_end()
	im.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	for current_vector in path:
		im.surface_add_vertex(Vector3(current_vector.x,get_parent().get_parent().terrain_height[path.size() - 1],current_vector.z))
	im.surface_end()


