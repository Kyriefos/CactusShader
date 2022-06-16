#version 120

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 dist;

void main() {

	discard;

	//vec2 texcoord_ = DistortPosition(texcoord);
	vec4 color = texture2D(texture, texcoord) * glcolor;

	color.a = color.a/((dist.x+dist.z)*0.04f);
	color.a *= 4.5f;
	if (color.a > 0.5f) {
		color.a = 0.5f;
	}

	color.rgb = vec3(0.88f,0.92f,0.81f);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}
