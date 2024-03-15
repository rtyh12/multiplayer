// OKLAB =====================

const mat3 OKLAB_2_CBRTLMS = mat3(
	vec3( 1.0,           1.0,           1.0         ),
	vec3(-0.3963377774, -0.1055613458, -0.0894841775),
	vec3( 0.2158037573, -0.0638541728, -1.2914855480));
	
const mat3 LMS_2_RGB = mat3(
	vec3( 4.0767416621, -1.2684380046, -0.0041960863),
	vec3(-3.3077115913,  2.6097574011, -0.7034186147),
	vec3( 0.2309699292, -0.3413193965,  1.7076147010));
		
const mat3 RGB_2_LMS = mat3(                
    vec3(0.4122214708,  0.2119034982,  0.0883024619),
    vec3(0.5363325363,  0.6806995451,  0.2817188376),
    vec3(0.0514459929,  0.1073969566,  0.6299787005));
		
const mat3 CBRTLMS_2_OKLAB = mat3(                
    vec3( 0.2104542553f,  1.9779984951f,  0.0259040371f),
    vec3( 0.7936177850f, -2.4285922050f,  0.7827717662f),
    vec3(-0.0040720468f,  0.4505937099f, -0.8086757660f));

vec3 linear_srgb_to_oklab(vec3 c) {
	vec3 cone = RGB_2_LMS * c;
	vec3 nonlinearized = pow(cone, vec3(1. / 3.));
    return CBRTLMS_2_OKLAB * nonlinearized;
}

vec3 oklab_to_linear_srgb(vec3 c) {
	vec3 cbrts_lms = OKLAB_2_CBRTLMS * c;
	vec3 nonlinearized = cbrts_lms * cbrts_lms * cbrts_lms;
	return LMS_2_RGB * nonlinearized;
}

float oklab_distance_sq(vec3 srgb1, vec3 srgb2) {
	vec3 delta = linear_srgb_to_oklab(srgb1) - linear_srgb_to_oklab(srgb2);
	return
		pow(delta.x, 2) +
		pow(delta.y, 2) +
		pow(delta.z, 2);
}

// HSV =====================

vec4 rgb2hsv(vec4 rgb) { //Converts RGB values to HSV
	float r = rgb.r;
	float g = rgb.g;
	float b = rgb.b;

	float cmax = max(r,max(g,b));
	float cmin = min(r,min(g,b));
	float delta = cmax - cmin;

	float h = 0.0f; //hue

	if (delta > 0.0f){
		if (cmax == r){
			h = (g - b) / delta;
			h = mod(h, 6.0f);
		} else if (cmax == g){
			h = ((b - r) / delta) + 2.0f;
		} else {
			h = ((r - g) / delta) + 4.0f;
		}
		h = h * 60.0f;
	}

	float s = 0.0f; //saturation
	if (cmax > 0.0f){
		s = delta / cmax;
	}

	return vec4(h, s, cmax, rgb.a);
}

vec4 hsv2rgb(vec4 hsv) { //Converts HSV values to RGB
	float h = hsv.r;
	float s = hsv.g;
	float v = hsv.b;
	float c = v * s;
	//X = C × (1 - |(H / 60°) mod 2 - 1|)
	float x = h / 60.0f;
	x = mod(x ,2.0f);
	x = abs(x - 1.0f);
	x = c * (1.0f - x);

	float m = v - c;

	vec4 rgb = vec4(0.0f, 0.0f, 0.0f,hsv.a);

	if (h < 60.0f) {
		rgb = vec4(c, x, 0.0f, hsv.a);
	} else if (h < 120.0f) {
		rgb = vec4(x,c,0.0f,hsv.a);
	} else if (h < 180.0f){
		rgb = vec4(0.0f,c,x,hsv.a);
	} else if (h < 240.0f){
		rgb = vec4(0.0f,x,c,hsv.a);
	} else if (h < 300.0f){
		rgb = vec4(x,0.0f,c,hsv.a);
	} else if (h < 360.0f){
		rgb = vec4(c,0.0f,x,hsv.a);
	}
	rgb[0] = rgb[0] + m;
	rgb[1] = rgb[1] + m;
	rgb[2] = rgb[2] + m;


	return rgb;
}

float hsv_distance(vec4 hsva1, vec4 hsva2) {
	return
	pow(sin(hsva1.x) * hsva1.y * hsva1.z - sin(hsva2.x) * hsva2.y * hsva2.z, 2) +
	pow(cos(hsva1.x) * hsva2.y * hsva1.z - cos(hsva2.x) * hsva2.y * hsva2.z, 2) +
	pow(hsva1.z - hsva2.z, 2);
}