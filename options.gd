extends Control




func _on_save_pressed():
	var conf = ConfigFile.new()
	conf.set_value("Video","Resolution",DisplayServer.window_get_size())
	conf.set_value("Video","VSync",false)
	conf.set_value("Video","ShowFPS",Fps.display)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")






func _on_resolution_item_selected(index):
	if index == 0:
		DisplayServer.window_set_size(Vector2(800,600))
	if index == 1:
		DisplayServer.window_set_size(Vector2(1920,1080))
	if index == 2:
		DisplayServer.window_set_size(Vector2(3840,1080))


func _on_fps_toggled(button_pressed):
	Fps.display = button_pressed


func _on_vsync_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
