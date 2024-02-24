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