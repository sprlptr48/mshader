#version 120

varying vec2 LightmapCoords;
varying vec2 TexCoords;
varying vec4 Color;

void main() {
    gl_Position = ftransform();
    TexCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    LightmapCoords  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    Color = gl_Color;
///ssds DRAWBUFFERS:0 */
    //gl_FragData[0] = Color;
}