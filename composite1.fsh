#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;
uniform float viewHeight;
uniform float viewWidth;

#define Blur 0 // [0 1]


void main(){

    vec3 color = texture2D(colortex0, TexCoords).rgb;

    if (Blur == 1) {
      float var1 = -0.1f;
      float var2 = 0.1f;
      float ratio = 0.8f;
      if ((texture2D(colortex0, TexCoords).r+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,0)).r || texture2D(colortex0, TexCoords).g+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,0)).g || texture2D(colortex0, TexCoords).b+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,0)).b) || (texture2D(colortex0, TexCoords).r+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,0)).r || texture2D(colortex0, TexCoords).g+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,0)).g || texture2D(colortex0, TexCoords).b+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,0)).b)) {
      color *= ratio;
      color += texture2D(colortex0, TexCoords + vec2(1/viewWidth,0)).rgb*(1.0f-ratio);
      }
      if ((texture2D(colortex0, TexCoords).r+var1 > texture2D(colortex0, TexCoords + vec2(0,1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var1 > texture2D(colortex0, TexCoords + vec2(0,1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var1 > texture2D(colortex0, TexCoords + vec2(0,1/viewHeight)).b) || (texture2D(colortex0, TexCoords).r+var2 < texture2D(colortex0, TexCoords + vec2(0,1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var2 < texture2D(colortex0, TexCoords + vec2(0,1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var2 < texture2D(colortex0, TexCoords + vec2(0,1/viewHeight)).b)) {
      color *= ratio;
      color += texture2D(colortex0, TexCoords + vec2(0,1/viewHeight)).rgb*(1.0f-ratio);
      }
      if ((texture2D(colortex0, TexCoords).r+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewWidth,0)).r || texture2D(colortex0, TexCoords).g+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewWidth,0)).g || texture2D(colortex0, TexCoords).b+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewWidth,0)).b) || (texture2D(colortex0, TexCoords).r+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewWidth,0)).r || texture2D(colortex0, TexCoords).g+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewWidth,0)).g || texture2D(colortex0, TexCoords).b+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewWidth,0)).b)) {
      color *= ratio;
      color += texture2D(colortex0, TexCoords + vec2(-1/viewWidth,0)).rgb*(1.0f-ratio);
      }
      if ((texture2D(colortex0, TexCoords).r+var1 > texture2D(colortex0, TexCoords + vec2(0,-1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var1 > texture2D(colortex0, TexCoords + vec2(0,-1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var1 > texture2D(colortex0, TexCoords + vec2(0,-1/viewHeight)).b) || (texture2D(colortex0, TexCoords).r+var2 < texture2D(colortex0, TexCoords + vec2(0,-1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var2 < texture2D(colortex0, TexCoords + vec2(0,-1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var2 < texture2D(colortex0, TexCoords + vec2(0,-1/viewHeight)).b)) {
      color *= ratio;
      color += texture2D(colortex0, TexCoords + vec2(0,-1/viewHeight)).rgb*(1.0f-ratio);
      }
      if ((texture2D(colortex0, TexCoords).r+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,1/viewHeight)).b) || (texture2D(colortex0, TexCoords).r+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,1/viewHeight)).b)) {
      color *= ratio;
      color += texture2D(colortex0, TexCoords + vec2(1/viewWidth,1/viewHeight)).rgb*(1.0f-ratio);
      }
      if ((texture2D(colortex0, TexCoords).r+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewHeight,-1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewHeight,-1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewHeight,-1/viewHeight)).b) || (texture2D(colortex0, TexCoords).r+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewHeight,-1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewHeight,-1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewHeight,-1/viewHeight)).b)) {
      color *= ratio;
      color += texture2D(colortex0, TexCoords + vec2(-1/viewHeight,-1/viewHeight)).rgb*(1.0f-ratio);
      }
      if ((texture2D(colortex0, TexCoords).r+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewWidth,1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewWidth,1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var1 > texture2D(colortex0, TexCoords + vec2(-1/viewWidth,1/viewHeight)).b) || (texture2D(colortex0, TexCoords).r+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewWidth,1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewWidth,1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var2 < texture2D(colortex0, TexCoords + vec2(-1/viewWidth,1/viewHeight)).b)) {
      color *= ratio;
      color += texture2D(colortex0, TexCoords + vec2(-1/viewWidth,1/viewHeight)).rgb*(1.0f-ratio);
      }
      if ((texture2D(colortex0, TexCoords).r+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,-1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,-1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var1 > texture2D(colortex0, TexCoords + vec2(1/viewWidth,-1/viewHeight)).b) || (texture2D(colortex0, TexCoords).r+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,-1/viewHeight)).r || texture2D(colortex0, TexCoords).g+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,-1/viewHeight)).g || texture2D(colortex0, TexCoords).b+var2 < texture2D(colortex0, TexCoords + vec2(1/viewWidth,-1/viewHeight)).b)) {
      color *= ratio;
      color += texture2D(colortex0, TexCoords + vec2(1/viewWidth,-1/viewHeight)).rgb*(1.0f-ratio);
      }
    }

    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(color, 1.0f);

}
