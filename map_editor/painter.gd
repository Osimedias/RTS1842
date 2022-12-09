extends Node2D

@onready var _lines := $lines

var _pressed : bool = false

var _current_line : Line2D

var brush : String

var brush_size : float = 5.0

var _click_positions : PackedVector2Array

var current_color : Color

func _ready():
	%brush_size.value = brush_size


func _input(event):
	
	if get_parent().get_parent().visible == true:
	
		if event is InputEventKey and event.is_pressed():
			
			if event.keycode == KEY_L:
				brush = "Line"
			if event.keycode == KEY_B:
				brush = "Brush"
		
		
		if brush == "Line":
			if event is InputEventMouseButton:
				_pressed = event.pressed
				
				if _pressed:
					_current_line = Line2D.new()
					_lines.add_child(_current_line)
			
			if event is InputEventMouseMotion && _pressed:
				_current_line.add_point($"..".get_viewport().get_mouse_position())
				_current_line.width = brush_size
				_current_line.default_color = current_color
		
		if brush == "Brush":
			
			if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				return
			_click_positions.append($"..".get_viewport().get_mouse_position())
			queue_redraw()





func _draw():
	if get_parent().get_parent().visible == true:
		for point in _click_positions:
			draw_circle(point,brush_size,current_color)




func _on_brush_size_value_changed(value):
	brush_size = value


func _on_color_picker_color_changed(color):
	current_color = color


