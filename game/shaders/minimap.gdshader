shader_type canvas_item;

render_mode unshaded;

uniform sampler2D splat_map : hint_albedo;
uniform sampler2D height_map : hint_black;

uniform vec4 sand : hint_color;
uniform vec4 grass : hint_color;
uniform vec4 cliff : hint_color;
uniform vec4 water : hint_color;





void fragment(){
	vec4 splat = texture(splat_map,UV).rgba;
	vec4 color1 = sand.rgba * splat.r;
	vec4 color2 = grass.rgba * splat.g;
	vec4 color3 = cliff.rgba * splat.b;
	vec4 color4 = water.rgba * splat.a;
	COLOR.rgba = color4 + color1 + color2 + color3;
}






