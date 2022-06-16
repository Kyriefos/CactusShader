#version 120

uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferProjectionInverse;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform float frameTimeCounter;

varying vec4 starData;
varying vec3 worldpos;
varying vec3 dist;

#define CloudDistance 64 // [16 32 64 128]

float fogify(float x, float w) {
	return w / (x * x + w);
}

vec3 calcSkyColor(vec3 pos) {
	float upDot = dot(vec3(pos.x,pos.y+0.1f,pos.z), gbufferModelView[1].xyz);
	return mix(skyColor, fogColor, fogify(max(upDot, 0.0f), 0.025f));
}

float noise(vec2 pq) {
  return fract(sin(pq.x*347.7f + pq.y*742.3f)*372476.5f);
}

float noiseSmooth(vec2 pq) {
  vec2 index = floor(pq);
  vec2 frag = fract(pq);
  frag = smoothstep(0.0f, 1.0f, frag);

  float topLeft = noise(index);
  float topRight = noise(index + vec2(1,0));
  float top = mix(topLeft,topRight,frag.x);
  float bottomLeft = noise(index + vec2(0,1));
  float bottomRight = noise(index + vec2(1,1));
  float bottom = mix(bottomLeft,bottomRight,frag.x);

  return mix(top,bottom,frag.y);
}

void main() {
	vec3 color;
	if (starData.a > 0.5f) {
		color = starData.rgb;
	}
	else {
		vec4 pos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0f - 1.0f, 1.0f, 1.0f);
		pos = gbufferProjectionInverse * pos;
		vec3 cloudnoise = vec3(0.0f);
		vec3 cloudColor = vec3(0.97f);
		if (dist.y < -4 && dist.x < CloudDistance && dist.z < CloudDistance) {
			vec2 uv = worldpos.xz/32;
			cloudnoise += vec3(noiseSmooth(uv+vec2(frameTimeCounter/6.4f))*1.35f);
			cloudnoise += vec3(noiseSmooth(uv*2+vec2(frameTimeCounter/6.3f))*0.80f);
			cloudnoise += vec3(noiseSmooth(uv*4+vec2(frameTimeCounter/6.4f))*0.65f);
			cloudnoise += vec3(noiseSmooth(uv*8+vec2(frameTimeCounter/6.5f))*0.25f);
			cloudnoise += vec3(noiseSmooth(uv*16+vec2(frameTimeCounter/6.5f))*0.15f);
			cloudnoise += vec3(noiseSmooth(uv*32+vec2(frameTimeCounter/6.4f))*0.05f);
			cloudnoise -= vec3(noiseSmooth(uv+vec2(frameTimeCounter/6.4f))*0.25f);
			cloudnoise -= vec3(noiseSmooth(uv*4+vec2(frameTimeCounter/6.2f))*0.10f);
			cloudnoise -= vec3(noiseSmooth(uv*16+vec2(frameTimeCounter/6.3f))*0.05f);
			cloudnoise /= 2.6f;
			cloudColor *= vec3(0.80f,0.81f,0.89f)*cloudnoise*2;
			cloudColor = mix(cloudColor,vec3(0.95f),(cloudnoise-0.45f)*3);
			cloudnoise = smoothstep(0.45f,0.95f,cloudnoise);
			cloudnoise *= 1.0f-(dist.z/CloudDistance);
			cloudnoise *= 1.0f-(dist.x/CloudDistance);
		}
		color = calcSkyColor(normalize(pos.xyz));
		color.r *= 1.0f-cloudnoise.b*1.31f;
		color.g *= 1.0f-cloudnoise.b*1.28f;
		color.b *= 1.0f-cloudnoise.b*1.24f;
		color += cloudColor*cloudnoise;
		color *= 1.65f;
	}

	//color *= 1.6f;
	//if (color.r > 2.0f) {color.r = 2.0f;}
	//if (color.g > 2.0f) {color.g = 2.0f;}
	//if (color.b > 2.0f) {color.b = 2.0f;}
	//color *= 1.5f;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}
