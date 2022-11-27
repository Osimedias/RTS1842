shader_type spatial;
render_mode unshaded,blend_add;

uniform vec4 color : source_color;

void vertex(){
	COLOR *= color;
}

void fragment(){
	ALBEDO = color.xyz;
}