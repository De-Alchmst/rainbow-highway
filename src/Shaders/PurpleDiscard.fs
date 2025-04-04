// This shader was written by claude.ai

// Fragment shader that discards purple colored pixels
#version 330

// Input vertex attributes (from vertex shader)
in vec2 fragTexCoord;
in vec4 fragColor;

// Input uniform values
uniform sampler2D texture0;
uniform vec4 colDiffuse;

// Output fragment color
out vec4 finalColor;
vec4 purple = vec4(1.0, 0, 1.0, 1.0);

void main()
{
    // Texel color fetching from texture sampler
    vec4 texelColor = texture(texture0, fragTexCoord);
    
    // Apply color tint
    vec4 color = texelColor*colDiffuse;
    
    if (color == purple) discard;
    
    // Final fragment color
    finalColor = color;
}
