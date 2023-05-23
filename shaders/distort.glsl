#ifndef DISTORT_GLSL
#define DISTORT_GLSL

vec2 DistortPosition(in vec2 position)
{
    float CenterDistance = length(position);
    float DistortionFactor = mix(1.0f, CenterDistance, 0.9f);
    return position / DistortionFactor;
}

//CURRENTLY DOES NOT WORK LOL
//from https://www.shadertoy.com/view/NdKyz1

/*vec2 waterDistort(vec2 position, int Time, float random)
{
    float X = position.x*0.001+Time;
    float Y = position.y*0.001+Time;
    position.y += cos(X+Y)*0.01*cos(Y)*(random/100.0);
    position.x += sin(X-Y)*0.01*sin(Y)*(random/100.0);

    return position;
}*/

// End of include guard
#endif