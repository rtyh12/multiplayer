shader_type spatial;

#include "include/FastNoiseLite.gdshaderinc"
#include "include/ColorSpaceTools.gdshaderinc"

varying vec3 pos;

uniform sampler2D colormap;

const vec2 size = vec2(2.0,0.0);
const ivec3 off = ivec3(-1,0,1);

uniform int random_seed = 1;
uniform float scale = 35;

void vertex() {
	pos = VERTEX;
}

void fragment() {
	fnl_state noise = fnlCreateState(random_seed);
	noise.noise_type = FNL_NOISE_OPENSIMPLEX2S;
	noise.fractal_type = FNL_FRACTAL_FBM;
	noise.octaves = 10;
	noise.lacunarity = 2.4;
	noise.gain = 0.4;
	noise.weighted_strength = 5.3;
	noise.domain_warp_amp = 100.;
	noise.domain_warp_type = FNL_DOMAIN_WARP_OPENSIMPLEX2;
	noise.frequency = 0.006;

	float height = fnlGetNoise3D(
		noise,
		10. * scale * pos.x,
		10. * scale * pos.y,
		10. * scale * pos.z);

	vec3 color = texture(colormap, vec2(height, 0.5)).rgb;
	ALBEDO = color;
}
