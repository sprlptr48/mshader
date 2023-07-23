#version 460 compatibility

#define PI 3.1415926538

uniform int worldTime;

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

void main()
{
    // Transform the vertex
    vec4 vertex = gl_Vertex + vec4(0.0, cos(gl_Vertex.z)*cos(gl_Vertex.x)*1.1 * cos((worldTime % 100/31.847 - PI)), 0.0, 0.0);
    gl_Position = gl_ModelViewProjectionMatrix * vertex;
    // Assign values to varying variables
    TexCoords = gl_MultiTexCoord0.xy;
    // Use the texture matrix instead of dividing by 15 to maintain compatiblity for each version of Minecraft
    LightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
    LightmapCoords = (LightmapCoords * 33.05f / 32.0f) - (1.05f / 32.0f); // Transform to [0, 1] range
    Normal = vec3(gl_NormalMatrix * gl_Normal);
    Color = gl_Color;
}