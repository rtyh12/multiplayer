shader_type canvas_item;

#include "res://shaders/include/ColorSpaceTools.gdshaderinc"

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform sampler2D palette : hint_default_black; // Insert a palette from lospec for instance
uniform int colors = 16;

void fragment() {
	vec4 rgba = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 new_color = vec4(10000);

	int palette_size = 0;
	if (colors == 0) {
		palette_size = textureSize(palette, 0).x;
	} else {
		palette_size = colors;
	}

	for (int i = 0; i < palette_size; i++) {
		vec4 palette_color = texture(palette, vec2((1.0 / float(palette_size)) * (float(i) + 0.5), 0.5));
		if (hsv_distance(palette_color, rgba) < hsv_distance(new_color, rgba)) {
			new_color = palette_color;
		}
	}

	int count = 4;
	int i = 1;
//	COLOR = texture(palette, vec2((1.0 / float(count)) * (float(i) + 0.5), 0.5));
	COLOR = new_color;
}