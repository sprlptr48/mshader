#version 330 compatibility
#include "distort.glsl"

/*
    The shader that does the pixel art effect.
*/

varying vec2 TexCoords;

// The color textures which we wrote to
uniform sampler2D colortex0;
/*
const int colortex0Format = RGBA16F;
*/

uniform float viewWidth;
uniform float viewHeight;
uniform int isEyeInWater;
uniform int worldTime;

#ifndef PIXELIZE_AMOUNT
#define PIXELIZE_AMOUNT 1
#endif

vec4 PixelShader(vec2 pos) { //Copied from ChatGPT, Originally made for Magpie check those.
    //vec2 texSize = vec2(textureSize(TexCoords, 0));
    vec2 texelSize = vec2(1.0) / vec2(viewWidth / PIXELIZE_AMOUNT, viewHeight / PIXELIZE_AMOUNT); //texSize;

    vec2 range = ((TexCoords.xy-0.5)/100.0) / 2.0 * 0.999; //Change the 1.0 so fov is fixed

    float left = pos.x - range.x;
    float top = pos.y + range.y;
    float right = pos.x + range.x;
    float bottom = pos.y - range.y;

    vec3 topLeftColor = texture2DLod(colortex0, (floor(vec2(left, top) / texelSize) + vec2(0.5)) * texelSize, 0.0).rgb;
    vec3 bottomRightColor = texture2DLod(colortex0, (floor(vec2(right, bottom) / texelSize) + vec2(0.5)) * texelSize, 0.0).rgb;
    vec3 bottomLeftColor = texture2DLod(colortex0, (floor(vec2(left, bottom) / texelSize) + vec2(0.5)) * texelSize, 0.0).rgb;
    vec3 topRightColor = texture2DLod(colortex0, (floor(vec2(right, top) / texelSize) + vec2(0.5)) * texelSize, 0.0).rgb;


    vec2 border = min(max(ceil((pos / texelSize) - 0.5)/texelSize, vec2(left, bottom)), vec2(right, top));

    float totalArea = 4.0 * range.x * range.y;

    vec3 averageColor;
    averageColor = ((border.x - left) * (top - border.y) / totalArea) * topLeftColor;
    averageColor += ((right - border.x) * (border.y - bottom) / totalArea) * bottomRightColor;
    averageColor += ((border.x - left) * (border.y - bottom) / totalArea) * bottomLeftColor;
    averageColor += ((right - border.x) * (top - border.y) / totalArea) * topRightColor;

    return vec4(averageColor, 1.0);
}

void main()
{
/* DRAWBUFFERS:0 */
    vec4 result = PixelShader(TexCoords);
    if (isEyeInWater == 1)
    {
        result *= vec4(0.2,0.4,.9,1.);
    }
    //vec3 modifiedDiffuse = result.rgb; //* Diffuse;
    // Write the modified diffuse color to gl_FragData[0]
    gl_FragData[0] = result;
    //gl_FragData[0] = vec4(Diffuse, 1.0f);
}