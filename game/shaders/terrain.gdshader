shader_type spatial;
uniform sampler2D splat_map : hint_default_white;
uniform sampler2D height_map : hint_default_black;
//texture repeating value.
uniform float repeat_value;
//normalmap depth adjustment.
uniform float normalmap_depth;
//texture slot 1.
uniform sampler2DArray albedo;
uniform sampler2DArray roughness;
uniform sampler2DArray normalmap;

void vertex()
{
	float height = texture(height_map,UV).r;
	VERTEX.y += height * 32.0;
}


vec3 texture_array(sampler2D tex,vec2 uv,int index)
{
	return vec3(uv.x,uv.y,float(index));
}


void fragment()
{
	//mask.
	vec3 splat = texture(splat_map, UV).rgb;
	//albedo textures.
	vec3 color1 = texture(albedo, vec3(UV.x,UV.y,float(1)) * repeat_value).rgb * splat.r;
	vec3 color2 = texture(albedo, vec3(UV.x,UV.y,float(2)) * repeat_value).rgb * splat.g;
	vec3 color3 = texture(albedo, vec3(UV.x,UV.y,float(3)) * repeat_value).rgb * splat.b;
	//roughness textures.
	float color1_r = texture(roughness, vec3(UV.x,UV.y,float(1)) * repeat_value).r * splat.r;
	float color2_r = texture(roughness, vec3(UV.x,UV.y,float(2)) * repeat_value).r * splat.g;
	float color3_r = texture(roughness, vec3(UV.x,UV.y,float(3)) * repeat_value).r * splat.b;
	//normalmap textures.
	vec3 color1_n = texture(normalmap, vec3(UV.x,UV.y,float(1)) * repeat_value).rgb * splat.r;
	vec3 color2_n = texture(normalmap, vec3(UV.x,UV.y,float(2)) * repeat_value).rgb * splat.g;
	vec3 color3_n = texture(normalmap, vec3(UV.x,UV.y,float(3)) * repeat_value).rgb * splat.b;
	//final render.	
	ALBEDO = color1 + color2 + color3;
	ROUGHNESS = color1_r + color2_r + color3_r;
	NORMAL_MAP = color1_n + color2_n + color3_n - 1.0;
}