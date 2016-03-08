#version 120

uniform vec2 u_backingSize;
uniform mat2x3 u_matrix;
uniform mat4 u_mvp;
uniform vec3 u_positionA;
uniform vec3 u_positionB;
uniform vec2 u_strokeSize;
uniform int snapToPixelGrid;

attribute vec4 a_position;
attribute vec2 a_uv;

varying vec2 depth;
varying vec2 uv;
varying float t;

void main()
{
    // get each point of the quad and apply the translation+rotation+scale computed in the binding block
    vec4 position = a_position + vec4(a_uv * u_strokeSize, 0.0, 0.0);
    position.xy = vec3(position.xy, 1.0) * u_matrix;
    
    // from screenspace coordinates to NDC (normalized device coordinates)
    position.x = 2.0 * position.x / u_backingSize.x - 1.0;
    position.y = 2.0 * position.y / u_backingSize.y - 1.0;
    
    // Let all vertices fall on the pixel grid
    if (snapToPixelGrid == 1) {
        position.x -= mod(position.x, 2/u_backingSize.x);
        position.y -= mod(position.y, 2/u_backingSize.y);
    }
    
    // abscissa between 0 and 1 (time along the length of the quad)
    t = a_position.x + 0.5;
    
    // we need to compute in depth in the 3D space in order to write a correct value in the depth buffer
    vec4 worldPosition = vec4(mix(u_positionB, u_positionA, t), 1.0);
    vec4 projectedPositon = u_mvp * worldPosition;
    depth = projectedPositon.zw;
    
    uv = a_uv;
    
    gl_Position = position;
}
