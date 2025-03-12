// This shader was written by claude.ai

// Fragment shader that discards pixels below a certain alpha threshold
#version 330

// Input vertex attributes (from vertex shader)
in vec2 fragTexCoord;
in vec4 fragColor;

// Input uniform values
uniform sampler2D texture0;
uniform vec4 colDiffuse;

// Output fragment color
out vec4 finalColor;

// Threshold value for alpha discard
uniform float alphaThreshold = 0.1;

void main()
{
    // Texel color fetching from texture sampler
    vec4 texelColor = texture(texture0, fragTexCoord);
    
    // Apply color tint and gamma correction
    vec4 color = texelColor*colDiffuse;
    
    // Discard fragment if alpha is less than the threshold
    if (color.a < alphaThreshold) discard;
    
    // Final fragment color
    finalColor = color;
}
