extends Marker3D


var speed := 50.0
var zoom_speed := 50.0

var zoom : float


@export var color : Color
@onready var camera = $pivot/camera

var recheck : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	zoom = 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var horizontal = Input.get_axis("move_up","move_down")
	var vertical = Input.get_axis("move_left","move_right")
	
	zoom = clamp(zoom,1,20)
	
	var dir : Vector3 = Vector3.ZERO
	
	dir.x = vertical * speed
	dir.z = horizontal * speed
	

	$pivot.transform.origin.y = zoom
	transform.origin = transform.origin + dir * delta

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			recheck = event.is_pressed()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed():
			zoom += 1
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed():
			zoom -= 1


