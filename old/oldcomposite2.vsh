#version 460 compatibility
#include "distort.glsl"

varying vec2 TexCoords;

uniform int worldTime;
uniform int isEyeInWater;
uniform float frameTime;

void main()
{
    gl_Position = ftransform();
    TexCoords = gl_MultiTexCoord0.st;
}