shader_type canvas_item;

uniform float cval = 0.0;
uniform vec4 shade = vec4(0, 0, 0, 255);
uniform float shader_radius = 0.5;

void fragment() {
	vec2 center = vec2(cval, 0.5);
	COLOR.a = 0.0;
	
	float dist = distance(UV, vec2(0.5, 0.5));
	if(dist < shader_radius)
	{
		COLOR = vec4(255, 255, 255, 255);
	}
	
	dist = distance(UV, center);
	if(dist < shader_radius){
		COLOR = shade * COLOR.a;
	}
}


