shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float threshold = 110;
uniform float magic = 8500.0;

void fragment() {
	vec3 c = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
	float aspect_ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 sr = vec2(SCREEN_UV.x * magic, SCREEN_UV.y * magic * aspect_ratio);
	float ds = distance(fract(sr), vec2(0.5, 0.5));
	float lum = (COLOR.x + c.y + c.z) / 3.0;
	COLOR.xyz = vec3(ds < threshold * lum * 0.01 ? 1.0 : 0.0);
}