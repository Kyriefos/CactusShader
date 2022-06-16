#version 120

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 dist;

void main() {
	vec4 pos = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
	vec3 worldpos = pos.xyz + cameraPosition;
	vec3 dist_ = abs(cameraPosition - worldpos);
	if (dist_.x < 0.75f) {dist_.x = 1.0f;}
	if (dist_.y < 0.75f) {dist_.y = 1.0f;}
	if (dist_.z < 0.75f) {dist_.z = 1.0f;}
	dist = dist_;
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
}
