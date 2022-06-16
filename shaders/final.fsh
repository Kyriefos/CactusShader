#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;
uniform int isEyeInWater;

uniform int worldTime;

#define ColorCorrection 2 // [1 2 3]

void main() {
   vec3 Color = texture2D(colortex0, TexCoords).rgb;

   if(isEyeInWater == 1){
     Color = vec3(Color.r*0.9f,Color.g*0.9f,Color.b*1.5f);
   }
   if (ColorCorrection == 2 || ColorCorrection == 3) {
     Color = vec3(Color.r*1.23f,Color.g*1.25f,Color.b*1.14f);

     //Color *= (sin(worldTime*3.14f/12000)+1.4f)/4+0.5f;

     if ((sin(worldTime*3.14f/12000)+1.4f)/4 < 0.25f) {
       Color -= vec3(0.13f,0.17f,0.04f);
       Color *= vec3(0.73f,0.77f,0.84f);
     }

     if (ColorCorrection == 3) {
       Color -= vec3(0.04f,0.07f,0.08f);
       Color *= vec3(1.41f,1.38f,1.28f);
     }
   }

   gl_FragColor = vec4(Color, 1.0f);
}
