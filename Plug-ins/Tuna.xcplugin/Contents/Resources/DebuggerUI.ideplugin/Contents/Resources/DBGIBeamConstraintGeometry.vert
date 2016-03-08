
#version 120

uniform vec2 screenSpacePixelSize;
uniform mat4 u_mvp;

uniform vec4 angles;

uniform vec4 anchorPositions; // x, y (A), x, y (B)
uniform vec2 scaleFactor; // x, y
uniform float ptLineWidth;
uniform float backingScaleFactor;
uniform int horizontal;
uniform int snapToPixelGrid;

uniform vec3 u_positionA;
uniform vec3 u_positionB;

attribute vec4 a_position;

varying float t;

void main() {
    int vertexID = int(a_position.x);
    
    vec4 position = a_position;
    
    float capWith = 7.0 * backingScaleFactor; // Pass in?
    float halfCapWith = capWith/2.0;

    float lineWidth = ptLineWidth * backingScaleFactor;
    float halfLineWidth = lineWidth/2.0;
    
    if (horizontal == 1) { // Horizontal I-Beam constraint
        
        // Inset X by half line width, so the constraint doesn't grow outside its bounds.
        float halfLineWidthModelSpace = halfLineWidth * scaleFactor.x;
        /// X
        if (vertexID == 0 || vertexID == 1) { // Left line left edge
            position.x = anchorPositions.x + halfLineWidthModelSpace;
        }
        else if (vertexID == 6 || vertexID == 7) { // Right line right edge
            position.x = anchorPositions.z - halfLineWidthModelSpace;
        }
        else if (vertexID == 2 || vertexID == 3 || vertexID == 10 || vertexID == 11) { // Right line left edge
            position.x = anchorPositions.x + halfLineWidthModelSpace;
        }
        else if (vertexID == 4 || vertexID == 5 || vertexID == 8 || vertexID == 9) { // Left line right edge
            position.x = anchorPositions.z - halfLineWidthModelSpace;
        }
        
        /// Y
        if (vertexID == 3 || vertexID == 4) { // Middle bottom edge
            position.y = anchorPositions.y;
        }
        else if (vertexID == 9 || vertexID == 10) { // Middle top edge
            position.y = anchorPositions.y;
        }
        else if (vertexID == 1 || vertexID == 2 || vertexID == 5 || vertexID == 6) { // Bottom edge
            position.y = anchorPositions.y + (halfCapWith * scaleFactor.y);
        }
        else if (vertexID == 7 || vertexID == 8 || vertexID == 11 || vertexID == 0) { // Top edge
            position.y = anchorPositions.y - (halfCapWith * scaleFactor.y);
        }
    }
    else { // Vertical I-Beam constraint
        
        // Inset Y by half line width, so the constraint doesn't grow outside its bounds.
        float halfLineHeightModelSpace = halfLineWidth * scaleFactor.y;
        /// Y
        if (vertexID == 0 || vertexID == 1) { // Bottom line bottom edge
            position.y = anchorPositions.y + halfLineHeightModelSpace;
        }
        else if (vertexID == 6 || vertexID == 7) { // Bottom line bottom edge
            position.y = anchorPositions.w - halfLineHeightModelSpace;
        }
        else if (vertexID == 2 || vertexID == 3 || vertexID == 10 || vertexID == 11) { // Bottom line top edge
            position.y = anchorPositions.y + halfLineHeightModelSpace;
        }
        else if (vertexID == 4 || vertexID == 5 || vertexID == 8 || vertexID == 9) { // Top line bottom edge
            position.y = anchorPositions.w - halfLineHeightModelSpace;
        }
        
        /// X
        if (vertexID == 3 || vertexID == 4) { // Middle right
            position.x = anchorPositions.x;
        }
        else if (vertexID == 9 || vertexID == 10) { // Middle left
            position.x = anchorPositions.x;
        }
        else if (vertexID == 1 || vertexID == 2 || vertexID == 5 || vertexID == 6) { // Right edge
            position.x = anchorPositions.x + (halfCapWith * scaleFactor.x) + lineWidth * scaleFactor.x;
        }
        else if (vertexID == 7 || vertexID == 8 || vertexID == 11 || vertexID == 0) { // Left edge
            position.x = anchorPositions.x - (halfCapWith * scaleFactor.x) - lineWidth * scaleFactor.x;
        }
    }
    
    vec4 screenSpacePosition = u_mvp * position; // World space to screen space
    
    float cosAngleLine = angles.x;
    float sinAngleLine = angles.y;
    float cosAngleCap = angles.z;
    float sinAngleCap = angles.w;
    
    // - Screen space manipulations -
    if (vertexID == 3 || vertexID == 4) { // Middle right
        
        screenSpacePosition.x += (halfLineWidth * screenSpacePixelSize.x) * cosAngleLine;
        screenSpacePosition.y += (halfLineWidth * screenSpacePixelSize.y) * sinAngleLine;
    }
    else if (vertexID == 9 || vertexID == 10) { // Middle right
        
        screenSpacePosition.x -= (halfLineWidth * screenSpacePixelSize.x) * cosAngleLine;
        screenSpacePosition.y -= (halfLineWidth * screenSpacePixelSize.y) * sinAngleLine;
    }
    
    // -- Top Cap --
    else if (vertexID == 8 || vertexID == 5) { // Top Cap bottom left / right
        screenSpacePosition.x += (halfLineWidth * screenSpacePixelSize.x) * cosAngleCap;
        screenSpacePosition.y += (halfLineWidth * screenSpacePixelSize.y) * sinAngleCap;
    }
    else if (vertexID == 7 || vertexID == 6) { // Top Cap bottom left / right
        screenSpacePosition.x -= (halfLineWidth * screenSpacePixelSize.x) * cosAngleCap;
        screenSpacePosition.y -= (halfLineWidth * screenSpacePixelSize.y) * sinAngleCap;
    }

    // -- Bottom Cap --
    else if (vertexID == 2 || vertexID == 11) { // Bottom of top line Y
        screenSpacePosition.x -= (halfLineWidth * screenSpacePixelSize.x) * cosAngleCap;
        screenSpacePosition.y -= (halfLineWidth * screenSpacePixelSize.y) * sinAngleCap;
    }
    else if (vertexID == 0 || vertexID == 1) { // Bottom of top line Y
        screenSpacePosition.x += (halfLineWidth * screenSpacePixelSize.x) * cosAngleCap;
        screenSpacePosition.y += (halfLineWidth * screenSpacePixelSize.y) * sinAngleCap;
    }
    
    // Assign t for dashing support in fragment shader.
    if (vertexID == 9 || vertexID == 4) { // Top of middle line
        t = 0.0;
    }
    else if (vertexID == 10 || vertexID == 3) { // Bottom of middle line
        t = 1.0;
    }
    else { // > 1.0 will always be solid.
        t = 2.0;
    }
    
    // Let all vertices fall on the pixel grid
    if (snapToPixelGrid == 1) {
        screenSpacePosition.x -= mod(screenSpacePosition.x, screenSpacePixelSize.x);
        screenSpacePosition.y -= mod(screenSpacePosition.y, screenSpacePixelSize.y);
    }
    
    gl_Position = screenSpacePosition;
}
