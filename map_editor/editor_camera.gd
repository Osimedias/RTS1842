extends Marker3D


var speed := 50.0
var zoom_speed := 50.0

var zoom : float

@export var color : Color
@onready var camera = $pivot/camera

var recheck : bool

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

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			recheck = event.is_pressed()

func _physics_process(delta):
	if recheck:
		var mouse_pos = camera.get_viewport().get_mouse_position()
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * 6000
		var quarry : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
		quarry.from = from
		quarry.to = to
		var result = get_world_3d().direct_space_state.intersect_ray(quarry)
		if result.size() > 0:
			var uv = UvPosition.get_uv_coords(result.position, result.normal, true)
			if uv:
				print("paint")
				$"../../MapTextures/splatmap".paint(uv,color)



