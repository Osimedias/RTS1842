shader_type spatial;

render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;

uniform vec2 uv_scale = vec2(1.0, 1.0);

uniform sampler2D t_input : hint_default_white;
uniform sampler2D inv_t : hint_default_white;

uniform vec3 color_space_vector1;
uniform vec3 color_space_vector2;
uniform vec3 color_space_vector3;
uniform vec3 color_space_origin;

uniform float vertex_height : hint_range(0.0, 35.0, 0.1) = 10;

uniform sampler2D terrain_texture : hint_default_white;
uniform sampler2D terrain_height_map : hint_default_white;

varying lowp vec3 vertex_color;
varying lowp vec3 uv;
uniform lowp float subdivision: hint_range (1.0,16.0,1.0);


void vertex(){
	vertex_color = COLOR.rgb;
	vec2 tile_offset = trunc(UV2*subdivision);
	lowp float tile = tile_offset.x+subdivision*(tile_offset.y);
	uv = vec3(UV*subdivision,tile);
	
	float height = texture(terrain_height_map, UV).y;
	VERTEX.y += height * vertex_height;
}


void fragment()
{
	ALBEDO = vec3(0.5,255,0.7);
}
