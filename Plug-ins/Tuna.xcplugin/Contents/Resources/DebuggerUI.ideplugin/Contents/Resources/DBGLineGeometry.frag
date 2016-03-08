uniform float dashFactor;
uniform vec3 lineColor;
uniform vec3 strokeColor;
uniform float lineOpacity;

varying vec2 depth;
varying vec2 uv;
varying float t;

void main()
{
    float zeroIfStrokeFragment = step(length(uv), 0.1);
    vec3 color = mix(strokeColor, lineColor, zeroIfStrokeFragment);
    
    if (dashFactor > 0.0) {
#if 1 // 1 = no anti-aliasing
        if (cos(dashFactor * t) > 0.0)
            discard;
        gl_FragColor = vec4(color, 1.0) * lineOpacity;
#else
        float time = cos(dashFactor * t);
        float dash  = smoothstep(0.0, 1.0, time * time);
        gl_FragColor = vec4(color, 1.0) * lineOpacity * dash;
#endif
    }
    else {
        gl_FragColor = vec4(color, 1.0) * lineOpacity;
    }
    
    // see http://www.arcsynthesis.org/gltut/Illumination/Tut13%20Deceit%20in%20Depth.html
    float ndc_depth = depth.x / depth.y;
    gl_FragDepth = (gl_DepthRange.diff * ndc_depth + gl_DepthRange.near + gl_DepthRange.far) / 2.0;
}
