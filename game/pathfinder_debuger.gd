extends MeshInstance3D


var mat : StandardMaterial3D = StandardMaterial3D.new()

func draw_line(begin_pos : Vector3, end_pos : Vector3, color: Color = Color.RED) -> void:
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	mesh.surface_set_color(color)
	mesh.surface_add_vertex(begin_pos)
	mesh.surface_add_vertex(end_pos)
	mesh.surface_end()



func draw_sphere(center : Vector3 = Vector3.ZERO, radius : float = 1.0, color : Color = Color.RED) -> void:
	var step : int = 15
	var sppi : float = 2 * PI / step
	var axes = [
		[Vector3.UP,Vector3.RIGHT],
		[Vector3.RIGHT,Vector3.FORWARD],
		[Vector3.FORWARD,Vector3.UP],
	]
	mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	mesh.surface_set_color(color)
	for axis in axes:
		for i in range(step + 1):
			mesh.surface_add_vertex(center + (axis[0] * radius).rotated(axis[1], sppi * (i % step)))
	mesh.surface_end()


