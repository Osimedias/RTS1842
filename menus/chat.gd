extends Panel





func _input(event):
	
	if event is InputEventKey and event.is_pressed():
		
		if event.keycode == KEY_ENTER:
			if visible == true:
				visible = false
				focus_mode = Control.FOCUS_NONE
			else:
				visible = true
				focus_mode = Control.FOCUS_ALL




func _on_send_pressed():
	$VBoxContainer/chat_box.text += ">" + $VBoxContainer/HBoxContainer/line_edit.text + "\n"
	$VBoxContainer/HBoxContainer/line_edit.text = ""
