#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 LightmapCoords;
varying vec2 TexCoords;
varying vec4 Color;

void main() {
    vec4 watercolor = texture2D(texture, TexCoords) * Color;
    watercolor *= texture2D(lightmap, LightmapCoords);

/* DRAWBUFFERS:0 */
    gl_FragData[0] = watercolor;
}