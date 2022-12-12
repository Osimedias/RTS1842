extends CharacterBody3D


const SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var target : Vector3

func _ready():
	set_physics_process(false)

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

func _physics_process(delta):
	
	velocity.y = gravity
	
	
	var path = get_parent().get_parent().get_node("terrain").find_path(transform.origin,target)
	
	velocity.x = move_toward(path[1].x,path[3].x,3.0) * delta * SPEED
	velocity.z = move_toward(path[1].z,path[3].z,3.0) * delta * SPEED
	move_and_slide()




