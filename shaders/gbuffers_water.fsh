#version 460 compatibility

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

// texture atlas
uniform sampler2D texture;

void main()
{
    // Sample from texture atlas and account for biome color + ambien occlusion
    vec4 Albedo = texture2D(texture, TexCoords) * Color;
    //Normal = maxvector(Normal, 0.11111f/frametime);
/* DRAWBUFFERS:012 */
    gl_FragData[0] = Albedo;
    gl_FragData[1] = vec4(Normal * 0.5f + 0.5f, 1.0f);
    gl_FragData[2] = vec4(LightmapCoords, 0.0f, 1.0f);
}