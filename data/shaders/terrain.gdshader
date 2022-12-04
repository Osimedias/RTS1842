shader_type spatial;

render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;

uniform sampler2DArray grass : hint_default_white;
uniform sampler2DArray grass_orm : hint_default_white;
uniform sampler2DArray grass_norm : hint_normal;
uniform sampler2DArray sand : hint_default_white;
uniform sampler2DArray sand_orm : hint_default_white;
uniform sampler2DArray sand_norm : hint_normal;
uniform sampler2DArray cliff : hint_default_white;
uniform sampler2DArray cliff_orm : hint_default_white;
uniform sampler2DArray cliff_norm : hint_normal;


uniform sampler2D terrain_texture : hint_default_white;
uniform sampler2D terrain_height_map : hint_default_white;

varying lowp vec3 vertex_color;
varying lowp vec3 uv;
uniform lowp float subdivision: hint_range (1.0,16.0,1.0);
varying vec2 tex_position;


void vertex(){
	vertex_color = COLOR.rgb;
	vec2 tile_offset = trunc(UV2*subdivision);
	lowp float tile = tile_offset.x+subdivision*(tile_offset.y);
	uv = vec3(UV*subdivision,tile);
	
	float height = texture(terrain_height_map, UV).y;
	VERTEX.y += height * 32.0;
}

vec3 blend_red(sampler2DArray tile,vec2 uv_map){
	if( texture(terrain_texture,uv_map).r == 0.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(1))).rgb * vertex_color;
	}
	else if(texture(terrain_texture,uv_map).r == 255.0/2.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(2))).rgb * vertex_color;
	}
	else if(texture(terrain_texture,uv_map).r == 255.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(3))).rgb * vertex_color;
	}
	else
	{
		return texture(tile,vec3(uv.x,uv.y,float(4))).rgb * vertex_color;
	}
}

vec3 blend_green(sampler2DArray tile,vec2 uv_map){
	if( texture(terrain_texture,uv_map).g == 0.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(1))).rgb * vertex_color;
	}
	else if(texture(terrain_texture,uv_map).g == 255.0/2.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(2))).rgb  * vertex_color;
	}
	else if(texture(terrain_texture,uv_map).g == 255.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(3))).rgb  * vertex_color;
	}
	else
	{
		return texture(tile,vec3(uv.x,uv.y,float(4))).rgb  * vertex_color;
	}
}

vec3 blend_blue(sampler2DArray tile,vec2 uv_map){
	if( texture(terrain_texture,uv_map).b == 0.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(1))).rgb * vertex_color;
	}
	else if(texture(terrain_texture,uv_map).b == 255.0/2.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(2))).rgb  * vertex_color;
	}
	else if(texture(terrain_texture,uv_map).b == 255.0)
	{
		return texture(tile,vec3(uv.x,uv.y,float(3))).rgb  * vertex_color;
	}
	else
	{
		return texture(tile,vec3(uv.x,uv.y,float(4))).rgb * vertex_color;
	}
}

void fragment()
{
	
	vec3 color1 = blend_red(grass,UV);
	vec3 color2 = blend_green(sand,UV);
	vec3 color3 = blend_blue(cliff,UV);
	vec3 albedo = color1 + color2 + color3;
	vec3 normal1 = blend_red(grass_norm,UV);
	vec3 normal2 = blend_green(sand_norm,UV);
	vec3 normal3 = blend_blue(cliff_norm,UV);
	vec3 normal = normal1 + normal2 + normal3;
	
	vec3 ORM = texture(grass_orm,uv).rgb * vertex_color;
	
	
	ALBEDO.rgb = albedo;
	NORMAL_MAP = normal;
	METALLIC = ORM.b;
	ROUGHNESS = ORM.g;
}


void light()
{
	//DIFFUSE_LIGHT += clamp(dot(NORMAL,LIGHT),0.0,1.0) * ATTENUATION * ALBEDO;
}