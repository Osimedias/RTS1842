extends Control



@onready var toolbox : Panel = $toolbox
@onready var mini_map_panel : Panel = $minimap
@onready var info_panel : Panel = $info_panel
@onready var command_panel : Panel = $command_panel

@onready var grid_command : GridContainer = $command_panel/GridContainer
var grid_command_slot_index : int

@onready var portrait : TextureRect = $info_panel/Panel_2/portrait
@onready var object_name : Label = $info_panel/name
@onready var progress_bar : ProgressBar = $info_panel/ProgressBar

signal on_command_panel_change(slot_index : int,element : Button)
signal on_information_panel_change(portrait : Texture2D,obj_name : String,prg_val : int,max_val : int)
signal on_fog_of_war_texture_change(texture : Texture2D)


func _ready():
	portrait.visible = false
	object_name.visible = false
	progress_bar.visible = false
	
	var menu_call = Callable(self,"on_id_pressed")
	$toolbox/menu.get_popup().id_pressed.connect(menu_call)


func on_id_pressed(id):
	match $toolbox/menu.get_popup().get_item_id(id):
		4:
			get_tree().change_scene_to_file("res://main_menu.tscn")
	pass



