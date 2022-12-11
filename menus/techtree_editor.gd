extends GraphEdit



@onready var popup = PopupMenu.new()

var cursor_pos = Vector2.ZERO
var nodes = []
var request_node = null
var request_slot = null
var loading_file : bool = false



var tree : Array

func _ready():
	add_child(popup)
	popup.add_item("Root Node", 0 )
	popup.add_item("Entity Node", 1 )
	popup.add_item("Technology Node", 2 )
	var menu_popup_call = Callable(self,"_on_item_id")
	var menu_popup = $"../Panel/HBoxContainer/MenuButton".get_popup() as PopupMenu
	menu_popup.id_pressed.connect(menu_popup_call)
	popup.id_pressed.connect(menu_popup_call)

func show_menu(pos):
	cursor_pos = (pos - get_global_rect().position + scroll_offset) / zoom
	popup.position = cursor_pos
	popup.visible = true

func _input(event):
	
	if event is InputEventKey and event.is_pressed():
		
		if event.keycode == KEY_T:
			var tech_node = load("res://menus/technology_node.tscn") as PackedScene
			var new_node = tech_node.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			add_child(new_node)
			new_node.position = get_global_mouse_position()
		if event.keycode == KEY_E:
			var tech_node = load("res://menus/entity_node.tscn") as PackedScene
			var new_node = tech_node.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			add_child(new_node)
			new_node.position = get_global_mouse_position()
		if event.keycode == KEY_R:
			var tech_node = load("res://menus/technology_root.tscn") as PackedScene
			var new_node = tech_node.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			add_child(new_node)
			new_node.position = get_global_mouse_position()
	
	pass

func _on_compile_pressed():
	tree = get_connection_list()
	pass

func _on_save_pressed():
	var file = FileAccess.open("res://data/tech_tree/tech_tree.json",FileAccess.WRITE)
	if file == OK:
		file.store_var(tree,true)
	pass

func _on_load_pressed():
	pass

func _on_item_id(id):
	print(id)
	match id:
		0:
			var tech_node = load("res://menus/technology_root.tscn") as PackedScene
			var new_node = tech_node.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			add_child(new_node)
			new_node.position = get_global_mouse_position()
		1:
			var tech_node = load("res://menus/entity_node.tscn") as PackedScene
			var new_node = tech_node.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			add_child(new_node)
			new_node.position = get_global_mouse_position()
		2:
			var tech_node = load("res://menus/technology_node.tscn") as PackedScene
			var new_node = tech_node.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			add_child(new_node)
			new_node.position = get_global_mouse_position()
	
	pass

func _on_connection_drag_started(from_node, from_port, is_output):
	print("Node connection: " + str(from_node) + " to connection " + str(from_port) + " Output of this connection: " +str(is_output))


func _on_connection_from_empty(to_node, to_port, release_position):
	print("To node: " + str(to_node) + " To port: " + str(to_port) + " Release position: " + str(release_position))


func _on_connection_drag_ended():
	# Redundante :v
	show_menu(get_global_mouse_position() + get_global_rect().position)


func _on_connection_request(from_node, from_port, to_node, to_port):
	connect_node(from_node,from_port,to_node,to_port)


func _on_connection_to_empty(from_node, from_port, release_position):
	request_node = from_node
	request_node = from_port
	show_menu(release_position + get_global_rect().position)


func _on_delete_nodes_request(nodes):
	for node in nodes:
		if node is GraphNode and node.is_selected():
			node.queue_free()




func _on_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node,from_port,to_node,to_port)
	pass # Replace with function body.


func _on_copy_nodes_request():
	pass # Replace with function body.


func _on_duplicate_nodes_request():
	pass # Replace with function body.


func _on_paste_nodes_request():
	pass # Replace with function body.


func _on_begin_node_move():
	pass # Replace with function body.


func _on_end_node_move():
	pass # Replace with function body.
