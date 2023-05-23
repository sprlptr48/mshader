#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;
uniform int worldTime;


void main()
{
    vec3 Color = texture2D(colortex0, TexCoords).rgb;
    if(worldTime > 12000)
    {
        Color *= 0.45f;
    }
    // Sample and apply gamma correction
    Color = pow(Color, vec3(1.0f / 2.2f));
    gl_FragColor = vec4(Color, 1.0f);
}