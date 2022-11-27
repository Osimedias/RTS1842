extends Panel




func _on_button_pressed():
	$"../..".write_zip_file($VBoxContainer/HBoxContainer/LineEdit.text)
	visible = false




func _on_button_2_pressed():
	visible = false
