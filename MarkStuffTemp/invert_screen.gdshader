shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 color = COLOR;
	ivec2 uv = ivec2(FRAGCOORD.xy);
	vec4 screen_color = texelFetch(SCREEN_TEXTURE, uv, 0).rgba;
	
	//invert the colors
	color = vec4(1.0 - screen_color.r, 1.0 - screen_color.g, 1.0 - screen_color.b, color.a);
	
	COLOR = color;
}
