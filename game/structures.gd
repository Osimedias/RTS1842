extends StaticBody3D


@export var data : EntityData

@export var selected_sound : AudioStream

var is_selected : bool

var p_owner : int = 0

func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		$sound.stream = selected_sound
		$sound.play()
		$selected.visible != $selected.visible
		if is_selected:
			print("Is not selected")
			is_selected = false
		else:
			print("Is selected")
			is_selected = true


func _on_mouse_entered():
	if is_selected == false:
		$selected.visible = true


func _on_mouse_exited():
	if is_selected == false:
		$selected.visible = false



