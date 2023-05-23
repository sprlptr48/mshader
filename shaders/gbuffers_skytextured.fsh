#version 120

uniform sampler2D texture;

varying vec2 TexCoords;
varying vec4 Color;

void main() {
    vec4 skycolor = texture2D(texture, TexCoords) * Color;

/* DRAWBUFFERS:0 */
    gl_FragData[0] = skycolor; //gcolor
}