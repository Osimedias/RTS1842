extends Label

var display : bool = false

func _ready():
	
	text = ""

func _process(_delta):
	
	if Engine.get_frames_per_second() < 30:
		modulate = Color.DARK_RED
	else:
		modulate = Color.GREEN
	
	if display == true:
		text = str(Engine.get_frames_per_second())
	else:
		text = ""
