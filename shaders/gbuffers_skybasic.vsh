#version 120

varying vec4 starData;
varying vec3 worldpos;
varying vec3 dist;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

void main() {
	gl_Position = ftransform();
	starData = vec4(gl_Color.rgb, float(gl_Color.r == gl_Color.g && gl_Color.g == gl_Color.b && gl_Color.r > 0.0));
	vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
	worldpos = position.xyz + cameraPosition;
	dist = vec3(abs(cameraPosition.x - worldpos.x)/2,(cameraPosition.y - worldpos.y)/2,abs(cameraPosition.z - worldpos.z)/2);
}
