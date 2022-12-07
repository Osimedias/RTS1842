extends NavigationRegion3D

@onready var noise_img
@onready var w;@onready var h

var height_data := {}

var terrain_amplitude := 36


var vertices = PackedVector3Array()
var uvs = PackedVector2Array()
var normals = PackedVector3Array()

var st = ImmediateMesh.new()

@onready var themesh = Mesh.new()
@onready var meshres := 1
@onready var meshcontainer = self


func _ready():
	pass
	#create_mesh()

func create_mesh():
	noise_img = %heightmap.get_viewport().get_texture().get_image()
	st.clear_surfaces()
	w = noise_img.get_width()
	h = noise_img.get_height()
	
	var height_map = noise_img
	
	
	for x in range(w+meshres):
		if x % meshres == 0:
			for y in range(h+meshres):
				if y % meshres == 0:
					height_data[Vector2(x, y)] = height_map.get_pixel(x, y).r * terrain_amplitude
	
	
	for x in range(w+meshres):
		if x % meshres == 0:
			for y in range(h+meshres):
				if y % meshres == 0:
					pass
					#create_quad(x, y)
	
	st.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	
	
	for v in vertices.size():
		st.surface_set_uv(uvs[v])
		st.surface_set_normal(normals[v])
		st.surface_add_vertex(vertices[v])
	
	st.surface_end()
	print(vertices.size())
	themesh = st
	#meshcontainer.set_mesh(themesh)
	navmesh.create_from_mesh(themesh)



func create_quad(x : int, y : int):
	var vert1
	var vert2
	var vert3
	var side1
	var side2
	var normal
	
	
	vert1 = Vector3(x,height_data[Vector2(x, y)], -y)
	vert2 = Vector3(x,height_data[Vector2(x, y+meshres)], -y-meshres)
	vert3 = Vector3(x+meshres,height_data[Vector2(x+meshres, y+meshres)], -y-meshres)
	
	vertices.push_back(vert1)
	vertices.push_back(vert2)
	vertices.push_back(vert3)
	
	uvs.push_back(Vector2(vert1.x, -vert1.z))
	uvs.push_back(Vector2(vert2.x, -vert2.z))
	uvs.push_back(Vector2(vert3.x, -vert3.z))
	
	
	side1 = vert2-vert1
	side2 = vert2-vert3
	
	normal = side1.cross(side2)
	
	for i in range(0, 3):
		normals.push_back(normal)
	
	vert1 = Vector3(x,height_data[Vector2(x, y)], -y)
	vert2 = Vector3(x+meshres,height_data[Vector2(x+meshres, y+meshres)], -y-meshres)
	vert3 = Vector3(x+meshres,height_data[Vector2(x+meshres, y)], -y)
	
	side1 = vert2-vert1
	side2 = vert2-vert3
	
	normal = side1.cross(side2)
	
	for i in range(0, 3):
		normals.push_back(normal)
	
	











