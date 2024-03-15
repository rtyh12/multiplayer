shader_type canvas_item;

#include "res://shaders/include/ColorSpaceTools.gdshaderinc"

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform vec3 target_hue: source_color;

void fragment() {
	vec4 source_rgba = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec2 target_ab = linear_srgb_to_oklab(target_hue).yz;
	
	//vec4 linear_srgb = pow(source_rgba, vec4(2.2));
	float source_L = linear_srgb_to_oklab(source_rgba.rgb).x;
	vec3 result_oklab = vec3(source_L, target_ab.x, target_ab.y);
	//vec3 result_srgb = oklab_to_linear_srgb(result_oklab);
	//COLOR = vec4(result.x, result.y, result.z, 1.);
	vec4 result_linear_srgb = vec4(source_L, source_L, source_L, 1.);
	COLOR = vec4(oklab_to_linear_srgb(result_oklab), 1.);
}