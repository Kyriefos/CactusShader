#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying float wave;
varying float waveSpec;

uniform int worldTime;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 sunPosition;

#define WaterTexture 1 // [1 0]

void main() {
	vec4 color = glcolor;
	color.b -= 0.3f;
	color.a = 0.9f;
	if (WaterTexture == 1) {
		color = texture2D(texture, texcoord) * glcolor;
	};
	color.a -= 0.1f;
	color.gb += 0.2f;

	color += vec4(vec3(wave*0.35f),wave*0.25f);
	color.g += wave*0.2f;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}
