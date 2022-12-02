extends Node





func _on_send_pressed():
	
	if $Panel/VBoxContainer/HBoxContainer/LineEdit.text == ":(1":
		$Panel/VBoxContainer/RichTextLabel.text = $Panel/VBoxContainer/RichTextLabel.text + "Yes" + "\n"
	elif $Panel/VBoxContainer/HBoxContainer/LineEdit.text == ":(2":
		$Panel/VBoxContainer/RichTextLabel.text = $Panel/VBoxContainer/RichTextLabel.text + "No" + "\n"
	elif $Panel/VBoxContainer/HBoxContainer/LineEdit.text == ":(3":
		$Panel/VBoxContainer/RichTextLabel.text = $Panel/VBoxContainer/RichTextLabel.text + "I need food" + "\n"
	elif $Panel/VBoxContainer/HBoxContainer/LineEdit.text == ":(4":
		$Panel/VBoxContainer/RichTextLabel.text = $Panel/VBoxContainer/RichTextLabel.text + "I need wood" + "\n"
	elif $Panel/VBoxContainer/HBoxContainer/LineEdit.text == ":(5":
		$Panel/VBoxContainer/RichTextLabel.text = $Panel/VBoxContainer/RichTextLabel.text + "I need coin" + "\n"
	elif $Panel/VBoxContainer/HBoxContainer/LineEdit.text == ":(6":
		$Panel/VBoxContainer/RichTextLabel.text = $Panel/VBoxContainer/RichTextLabel.text + "Do you have extra reasources?" + "\n"
	else:
		$Panel/VBoxContainer/RichTextLabel.text = $Panel/VBoxContainer/RichTextLabel.text + $Panel/VBoxContainer/HBoxContainer/LineEdit.text + "\n"
	
	$Panel/VBoxContainer/HBoxContainer/LineEdit.text = ""
	
