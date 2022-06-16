#version 120

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;

	color.rgb = vec3(1.7f,0.4f,1.1f);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}
