#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

uniform sampler2D texture;
uniform int worldTime;

void main(){
    vec4 albedo = texture2D(texture, TexCoords) * Color;
    albedo.rg *= 1.2f;

    if ((sin(worldTime*3.14f/12000)+1.4f)/4 < 0.25f) {
      albedo.rgb *= vec3(0.8f)+vec3(LightmapCoords.r)*vec3(1.17f,1.15f,0.96f);
    }
    else {
      albedo.rgb *= vec3(LightmapCoords.g)*1.5f;
      albedo.rgb *= vec3(1.0f)+vec3(LightmapCoords.r)*vec3(0.47f,0.45f,0.36f);
    }

    /* DRAWBUFFERS:01 */
    gl_FragData[0] = albedo;
    gl_FragData[1] = vec4(Normal * 0.5f + 0.5f, 1.0f);
    gl_FragData[2] = vec4(LightmapCoords, 0.5f, 1.0f);
}
