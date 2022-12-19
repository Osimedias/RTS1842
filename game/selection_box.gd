extends Node

var is_visible : bool = false
var m_pos : Vector2
var start_sel_pos : Vector2
const sel_box_color : Color = Color.GREEN
const sel_box_line_width = 3

@onready var selection_box = $selectionbox

var box_selected_units : Array

func _process(delta):
	$selectionbox.queue_redraw()
	m_pos = get_viewport().get_mouse_position()

func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			start_sel_pos = m_pos
			
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			m_pos = event.position
			is_visible = true
	else:
		is_visible = false


func get_unit_under_mouse():
	var from = get_viewport().get_camera_3d().project_ray_origin(m_pos)
	var to = get_viewport().get_camera_3d().project_ray_normal(m_pos) * 1000
	var space = get_parent().get_world_3d().get_direct_space_state()
	
	var querry = PhysicsRayQueryParameters3D.create(from, to,2,[])
	
	var result = space.intersect_ray(querry)
	
	if result != 0:
		print(result.collider)

func select_units():
	var new_selected = []
	if m_pos.distance_squared_to(start_sel_pos) < 4:
		var u = get_unit_under_mouse()
		if u != null:
			new_selected.append(u)
	else:
		new_selected = get_units_in_box(start_sel_pos,m_pos)
	
	if new_selected.size() != 0:
		for units in box_selected_units:
			units.is_selected = false
		for units in box_selected_units:
			units.is_selected = true

func get_units_in_box(top_left, bot_right):
	if top_left.x > bot_right.x:
		var tmp = top_left.x
		top_left.x = bot_right.x
		bot_right.x = tmp
	if top_left.y > bot_right.y:
		var tmp = top_left.y
		top_left.y = bot_right.y
		bot_right.y = tmp
	var box = Rect2(top_left,bot_right - top_left)
	box_selected_units = []
	for unit in get_parent().get_node("entities").get_child_count():
		
		if unit.is_selected and box.has_point(get_viewport().get_camera_3d().unproject_position(unit.global_transform.origin)):
			box_selected_units.append(unit)
	return box_selected_units



func _on_selectionbox_draw():
	if is_visible and start_sel_pos != m_pos:
		$selectionbox.draw_line(start_sel_pos,Vector2(m_pos.x,start_sel_pos.y),sel_box_color,sel_box_line_width)
		$selectionbox.draw_line(start_sel_pos,Vector2(start_sel_pos.x,m_pos.y),sel_box_color,sel_box_line_width)
		$selectionbox.draw_line(m_pos,Vector2(m_pos.x,start_sel_pos.y),sel_box_color,sel_box_line_width)
		$selectionbox.draw_line(m_pos,Vector2(start_sel_pos.x,m_pos.y),sel_box_color,sel_box_line_width)
		
