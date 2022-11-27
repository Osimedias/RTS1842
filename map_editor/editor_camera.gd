extends Marker3D


var speed := 50.0
var zoom_speed := 50.0

var zoom : float

@onready var camera = $pivot/camera
# Called when the node enters the scene tree for the first time.
func _ready():
	zoom = transform.origin.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	zoom = clamp(zoom,5.0,25.0)
	var horizontal = Input.get_axis("move_up","move_down")
	var vertical = Input.get_axis("move_left","move_right")
	
	var dir : Vector3
	
	dir.x = vertical * speed
	dir.z = horizontal * speed
	
	var zoom_move = zoom
	transform.origin.y + zoom_move * delta 
	transform.origin = transform.origin + dir * delta


func _physics_process(delta):
	
	var mouse_pos = camera.get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 2000
	var quarry : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	quarry.from = from
	quarry.to = to
	var result = get_world_3d().direct_space_state.intersect_ray(quarry)
	if result: 
		return result.position
	pass


func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed():
			zoom += 1 * zoom_speed
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed():
			zoom -= 1 * zoom_speed
	



