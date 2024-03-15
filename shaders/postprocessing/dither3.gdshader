shader_type canvas_item;

uniform float alpha;
uniform int scale;
uniform sampler2D ditherTexture : hint_default_black;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 rgba = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 pixel = FRAGCOORD;
	ivec2 texSize = textureSize(ditherTexture, 0);
	vec4 dither = texture(
		ditherTexture,
		vec2(
			float(int(pixel.x) % texSize.x) + 0.5,
			float(int(pixel.y) % texSize.y) + 0.5
		) / float(texSize.x)
	);
	//COLOR = int(pixel.x) % 8 == 0 ? vec4(1.) : vec4(0.);
	COLOR = rgba + (0.5 - dither) * alpha;
}