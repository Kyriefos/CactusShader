#version 120

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying float wave;

uniform int worldTime;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

uniform sampler2D texture;
attribute vec4 mc_Entity;
uniform float frameTimeCounter;

void main() {
	vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
	vec3 worldpos = position.xyz + cameraPosition;
	vec2 noise = worldpos.xz;
	wave = 0.05f*sin((frameTimeCounter*0.8f + noise.x*0.6f + noise.y*0.4f)*3.2f);
	wave += 0.05f*sin((frameTimeCounter*0.6f + noise.x*0.3f + noise.y*0.7f)*3.2f);
	wave -= 0.025f*cos((frameTimeCounter*0.5f + noise.x*1.2f + noise.y*1.7f)*3.7f);
	wave += 0.025f*cos((frameTimeCounter*0.7f + noise.x*0.4f + noise.y*0.3f)*2.7f);
	vec4 pos = gl_ProjectionMatrix * gbufferModelView * position;
	if (mc_Entity.x != 10079.0f) {
		pos.y -= 0.05f;
		pos.y += wave;
	}
	gl_Position = pos;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}
