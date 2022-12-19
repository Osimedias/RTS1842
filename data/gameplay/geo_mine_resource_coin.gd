extends StaticBody3D




@export_range(1,50000) var coin : int = 1000

@export var mesh_library : MeshLibrary






func _ready():
	
	$mesh.mesh = mesh_library.get_item_mesh(randi() % mesh_library.get_item_list().size())
	
	$col.shape.size = $mesh.mesh.aabb.size
	$col.shape.size.y = 1
	$col.transform.origin.y + 1
	
