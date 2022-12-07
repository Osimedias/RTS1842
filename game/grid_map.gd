extends MeshInstance3D



func _ready():
	var grid = AStarGrid2D.new()
	grid.size = mesh.size
	print(grid.size)
