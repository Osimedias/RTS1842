extends MeshInstance3D

@onready var splatmap = $"../../MapTextures/splatmap"

var material
var recheck := false

var amount_rays = 1

var texture : Texture
var tex_size : Vector2

const ray_length = 1000

func _ready():
	
	await  get_tree().create_timer(1).timeout
	await get_tree().create_timer(1).timeout
	
	UvPosition.set_mesh(self)
	
	material = material_override
	material.set_shader_parameter("splat_map", splatmap.get_viewport().get_texture())
	
	texture  = splatmap.get_texture()
	tex_size = splatmap.get_texture().get_size()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		recheck = event.is_pressed()

func _physics_process(_delta):
	if recheck:
		var space_state = get_world_3d().direct_space_state;
			
		for ray_idx in range(amount_rays):
			var from = get_viewport().get_camera_3d().project_ray_origin(get_viewport().get_mouse_position())
			var to
			
			if ray_idx <= 2:
				to = $"../editor_camera/pivot/camera".global_transform.xform(Vector3(0,ray_idx * splatmap.brush_size() * .2,-1000))
			else:
				to = $"../editor_camera/pivot/camera".global_transform.xform(Vector3(0, (ray_idx - 2) * splatmap.brush_size() * .2 * -1,-1000))
			
			var quarry = PhysicsRayQueryParameters3D.create(from,to,1)
			
			var result = space_state.intersect_ray(quarry)
				
			if result.size() > 0:
				var uv = UvPosition.get_uv_coords(result.position, result.normal, true)
				
				if uv:
					print(uv)
					splatmap.paint(uv,Color.BLACK)
					#get("viewport" + str(ray_idx)).move_brush(uv * tex_size)
