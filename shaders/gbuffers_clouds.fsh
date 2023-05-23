#version 120

uniform sampler2D texture;

varying vec2 TexCoords;
varying vec4 Color;
varying vec3 Normal;
varying vec2 LightmapCoords;

void main()
{
    vec4 cloudcolor = texture2D(texture, TexCoords) * Color;

/* DRAWBUFFERS:0 */
    gl_FragData[0] = cloudcolor;
    gl_FragData[1] = vec4(Normal * 0.5f + 0.5f, 1.0f);
    gl_FragData[2] = vec4(LightmapCoords, 0.0f, 1.0f);
}