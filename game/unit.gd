extends CharacterBody3D


const SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var target : Vector3

var path : PackedVector3Array

@export var data : EntityData





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
				set_physics_process(true)
				#draw_path(path)

func _physics_process(delta):
	velocity.y = $ray.get_collision_point().y
	
	var direction = Vector3.ZERO
	
	var step_size = delta * SPEED
	
	path = get_parent().get_parent().get_node("terrain").find_path(position,target)
	
	if path.size() > 1:
		var to_walk = delta*SPEED
		var to_watch = Vector3.UP
		while to_walk > 0 and path.size() >= 2:
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			to_watch = (pto - pfrom).normalized()
			var d = pfrom.distance_to(pto)
			if d <= to_walk:
				path.remove_at(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.lerp(pto,to_walk/d)
				to_walk = 0
		var atpos = path[path.size() - 1]
		var atdir = to_watch
		atdir.y = 0
		
		var t = Transform3D()
		t.origin = atpos
		t=t.looking_at(atpos + atdir, Vector3.UP)
		transform = t
		
		if path.size() < 2:
			path = []
			set_physics_process(false)
		else:
			set_physics_process(true)


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


