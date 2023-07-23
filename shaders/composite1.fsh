#version 460 compatibility
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

vec4 colorChange(vec4 color, int quality) //Turn the color into a lower bit style
{
    color.rgb = color.rgb * (quality-1) - 0.5;
    color.rgb = color.rgb / (quality-1);
    return color;
}

vec4 sharpen(vec2 pos, float strength)
{
    float unit = 1.0 / viewWidth;
    vec4 color = (strength*4 + 1.0) * texture2DLod(colortex0, pos, 0.0);
    color -= strength * texture2DLod(colortex0, vec2(pos.x + unit , pos.y), 0.0);
    color -= strength * texture2DLod(colortex0, vec2(pos.x - unit , pos.y), 0.0);
    color -= strength * texture2DLod(colortex0, vec2(pos.x , pos.y + unit), 0.0);
    color -= strength * texture2DLod(colortex0, vec2(pos.x , pos.y - unit), 0.0);
    return color;
}

void main()
{
/* DRAWBUFFERS:0 */
    vec4 result = sharpen(TexCoords, 1.2);
    //vec4 result = texture2DLod(colortex0, TexCoords, 0.0); //No filter applied color
    result = colorChange(result, 40);
    if (isEyeInWater == 1)
    {
        result *= vec4(0.2,0.4,.9,1.);
    }
    gl_FragData[0] = result;
}