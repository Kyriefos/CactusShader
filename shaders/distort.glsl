#ifndef SmoothShadows
#define SmoothShadows

vec2 DistortPosition(in vec2 position){
    float CenterDistance = length(position);
    float DistortionFactor = mix(1.0f, CenterDistance, 0.7f);
    return position / DistortionFactor;
}

#endif
