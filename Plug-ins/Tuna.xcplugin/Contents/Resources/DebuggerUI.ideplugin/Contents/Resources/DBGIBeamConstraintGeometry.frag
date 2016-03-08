uniform float dashFactor;
uniform vec4 lineColor;

varying float t;

void main()
{
    if (t > 1.0) { // = Solid (caps e.g. are always solid)
        gl_FragColor = lineColor;
    }
    else {
        if (dashFactor > 0.0) {
#if 1 // 1 = no anti-aliasing
            if (cos(dashFactor * t) > 0.0)
                discard;
            gl_FragColor = lineColor;
#else
            float time = cos(dashFactor * t);
            float dash  = smoothstep(0.0, 1.0, time * time);
            gl_FragColor = lineColor * dash;
#endif
        }
        else {
            gl_FragColor = lineColor;
        }
    }
}
