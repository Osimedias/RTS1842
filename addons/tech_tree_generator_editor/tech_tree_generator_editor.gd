@tool
extends EditorPlugin


const main_panel = preload("res://addons/tech_tree_generator_editor/main_panel.tscn")

var main_panel_instance

func _enter_tree():
	
	main_panel_instance = main_panel.instantiate()
	
	get_editor_interface().get_editor_main_screen().add_child(main_panel_instance)
	
	_make_visible(false)
	pass


func _exit_tree():
	if main_panel_instance:
		main_panel_instance.queue_free()


func _has_main_screen():
	return true


func _make_visible(visible):
	if main_panel_instance:
		main_panel_instance.visible = visible

func _get_plugin_name():
	return "Tech Tree Generator"


func _get_plugin_icon():
	return get_editor_interface().get_base_control().get_theme_icon("Node","EditorIcons")


