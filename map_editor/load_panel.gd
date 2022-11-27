extends Panel




func _on_load_pressed():
	$"../..".load_zip_file($VBoxContainer/HBoxContainer/LineEdit.text)
	visible = false


func _on_cancel_pressed():
	visible = false
	pass # Replace with function body.
