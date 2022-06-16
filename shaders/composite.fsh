#version 120

#include "distort.glsl"

varying vec2 TexCoords;

uniform vec3 sunPosition;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;
uniform sampler2D shadowcolor0;
uniform sampler2D noisetex;

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

uniform int worldTime;

/*
const int colortex0Format = RGBA16F;
const int colortex1Format = RGB16;
const int colortex2Format = RGB16;
*/

#define ShadowResolution 512 // [128 256 512 1024 2048]

const float sunPathRotation = -30.0f;
const int noiseTextureResolution = 128;
int shadowMapResolution = ShadowResolution;

const float Ambient = 0.35f;
const float ambientOcclusionLevel = 1.25f;

float AdjustLightmapTorch(in float torch) {
    const float K = 1.5f;
    const float P = 8.06f;
    return K * pow(torch, P);
}

float AdjustLightmapSky(in float sky){
    float sky_2 = sky * sky;
    return sky_2 * sky_2;
}

vec2 AdjustLightmap(in vec2 Lightmap){
    vec2 NewLightMap;
    NewLightMap.x = AdjustLightmapTorch(Lightmap.x);
    NewLightMap.y = AdjustLightmapSky(Lightmap.y);
    return NewLightMap;
}

vec3 GetLightmapColor(in vec2 Lightmap){
    Lightmap = AdjustLightmap(Lightmap);
    const vec3 TorchColor = vec3(1.0f, 0.25f, 0.08f);
    const vec3 SkyColor = vec3(0.05f, 0.15f, 0.5f);
    vec3 TorchLighting = Lightmap.x * TorchColor;
    vec3 SkyLighting = Lightmap.y * SkyColor;
    vec3 LightmapLighting = TorchLighting + SkyLighting;
    return LightmapLighting;
}

float Visibility(in sampler2D ShadowMap, in vec3 SampleCoords) {
    return step(SampleCoords.z - 0.001f, texture2D(ShadowMap, SampleCoords.xy).r);
}

vec3 TransparentShadow(in vec3 SampleCoords){
    float ShadowVisibility0 = Visibility(shadowtex0, SampleCoords);
    float ShadowVisibility1 = Visibility(shadowtex1, SampleCoords);
    vec4 ShadowColor0 = texture2D(shadowcolor0, SampleCoords.xy);
    vec3 TransmittedColor = ShadowColor0.rgb * (3.0f - ShadowColor0.a);
    return mix(TransmittedColor * ShadowVisibility1, vec3(1.0f), ShadowVisibility0);
}

#define ShadowSamples 3 //[1 2 3 4 5 6 7 8]
const int ShadowSamplesPerSize = 2 * ShadowSamples + 1;
const int TotalSamples = ShadowSamplesPerSize * ShadowSamplesPerSize;

vec3 GetShadow(float depth) {
    vec3 ClipSpace = vec3(TexCoords, depth) * 2.0f - 1.0f;
    vec4 ViewW = gbufferProjectionInverse * vec4(ClipSpace, 1.0f);
    vec3 View = ViewW.xyz / ViewW.w;
    vec4 World = gbufferModelViewInverse * vec4(View, 1.0f);
    vec4 ShadowSpace = shadowProjection * shadowModelView * World;
    ShadowSpace.xy = DistortPosition(ShadowSpace.xy);
    vec3 SampleCoords = ShadowSpace.xyz * 0.5f + 0.5f;
    float RandomAngle = texture2D(noisetex, TexCoords * 20.0f).r * 100.0f;
    float cosTheta = cos(RandomAngle);
	float sinTheta = sin(RandomAngle);
    mat2 Rotation =  mat2(cosTheta, -sinTheta, sinTheta, cosTheta) / shadowMapResolution;
    vec3 ShadowAccum = vec3(0.0f);
    for(int x = -ShadowSamples; x <= ShadowSamples; x++){
        for(int y = -ShadowSamples; y <= ShadowSamples; y++){
            vec2 Offset = Rotation * vec2(x, y);
            vec3 CurrentSampleCoordinate = vec3(SampleCoords.xy + Offset, SampleCoords.z);
            ShadowAccum += TransparentShadow(CurrentSampleCoordinate);
        }
    }
    ShadowAccum /= TotalSamples;
    return ShadowAccum;
}

void main(){
    vec3 Albedo = pow(texture2D(colortex0, TexCoords).rgb, vec3(1.1f));
    Albedo *= vec3(0.5f);
    float Depth = texture2D(depthtex0, TexCoords).r;
    if(Depth == 1.0f){
        gl_FragData[0] = vec4(Albedo, 1.0f);
        return;
    }
    vec3 Normal = normalize(texture2D(colortex1, TexCoords).rgb * 2.0f - 1.0f);
    vec2 Lightmap = texture2D(colortex2, TexCoords).rg;
    vec3 LightmapColor = GetLightmapColor(Lightmap);
    float NdotL = max(dot(Normal, normalize(sunPosition)), 0.0f);
    vec3 Diffuse = Albedo * (LightmapColor + GetShadow(Depth)*0.65f + Ambient);
    if ((sin(worldTime*3.14f/12000)+1.4f)/4 < 0.25f) {
      Diffuse = Albedo * (LightmapColor + Ambient*3);
    }
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(Diffuse, 1.0f);
}
