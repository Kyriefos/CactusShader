#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

uniform int worldTime;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

attribute vec4 mc_Entity;
uniform float frameTimeCounter;

uniform sampler2D depthtex0;

#define WaveLeaves 1 // [1 0]
#define WavePlants 1 // [1 0]

void main() {
    vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
    vec4 pos = gl_ProjectionMatrix * gbufferModelView * position;
    if (WaveLeaves == 1) {
      if (mc_Entity.x == 10018.0f) {
      	vec3 worldpos = position.xyz + cameraPosition;
        vec3 dist = abs(cameraPosition - worldpos)/2;
        if (dist.x < 0.75f) {dist.x = 1.0f;}
        if (dist.y < 0.75f) {dist.y = 1.0f;}
        if (dist.z < 0.75f) {dist.z = 1.0f;}
        vec3 wave = vec3(0.0f);
      	wave.x = 0.025f*sin((frameTimeCounter*0.3f + worldpos.x*0.2f + worldpos.y*0.3f + worldpos.z*0.1f)*2.3f)/dist.x;
      	wave.y = 0.025f*sin((frameTimeCounter*0.4f + worldpos.x*0.4f + worldpos.y*0.2f + worldpos.z*0.3f)*2.2f)/dist.y;
      	wave.z = 0.015f*cos((frameTimeCounter*0.2f + worldpos.x*0.1f + worldpos.y*0.2f + worldpos.z*0.1f)*2.4f)/dist.z;
      	pos.xyz += wave;
      }
    }
    if (WavePlants == 1) {
      if (mc_Entity.x == 10059.0f || mc_Entity.x == 10031.0f || mc_Entity.x == 10175.0f || mc_Entity.x == 10176.0f) {
        vec3 worldpos = position.xyz + cameraPosition;
        vec3 dist = abs(cameraPosition - worldpos)/2;
        if (dist.x < 0.75f) {dist.x = 1.0f;}
        if (dist.y < 0.75f) {dist.y = 1.0f;}
        if (dist.z < 0.75f) {dist.z = 1.0f;}
        vec3 wave = vec3(0.0f);
      	wave.x = 0.02f*sin((frameTimeCounter*0.5f + worldpos.x*0.1f + worldpos.y*0.4f + worldpos.z*0.3f)*2.1f)/dist.x;
      	wave.y = 0.01f*sin((frameTimeCounter*0.3f + worldpos.x*0.2f + worldpos.y*0.5f + worldpos.z*0.2f)*2.2f)/dist.y;
      	pos.xy += wave.xy;
      }
    }
    gl_Position = pos;
    TexCoords = gl_MultiTexCoord0.st;
    LightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
    LightmapCoords = (LightmapCoords * 33.05f / 32.0f) - (1.05f / 32.0f);
    Normal = gl_NormalMatrix * gl_Normal;
    Color = gl_Color;
}
