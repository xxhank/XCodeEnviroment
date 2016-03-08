
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

attribute vec4 a_position;

void main() {
    int vertexID = int(a_position.x);
    
    vec4 position = a_position;
    float capWith = 13.0 * backingScaleFactor; // Pass in?
    float halfCapWith = capWith/2.0;
    
    float pinLength = 6.0  * backingScaleFactor;
    
    float lineWidth = ptLineWidth * backingScaleFactor;
    float halfLineWidth = lineWidth/2.0;
    
    if (horizontal == 1) { // Horizontal I-Beam constraint
        // Inset X by half line width, so the constraint doesn't grow outside its bounds.
        float halfLineWidthModelSpace = halfLineWidth * scaleFactor.x;
        
        /// X
        if (vertexID == 0 || vertexID == 1) { // Bottom T bottom edge
            position.x = anchorPositions.x - halfLineWidthModelSpace - (pinLength * scaleFactor.x);
        }
        else if (vertexID == 6|| vertexID == 7 || vertexID == 2 || vertexID == 3) { // Bottom T middle edge
            position.x = anchorPositions.x - halfLineWidthModelSpace;
        }
        else if (vertexID == 5 || vertexID == 4) { // Bottom T top edge
            position.x = anchorPositions.x - halfLineWidthModelSpace;
        }
        else if (vertexID == 13 || vertexID == 12) { // Top T top edge
            position.x = anchorPositions.z + halfLineWidthModelSpace + (pinLength * scaleFactor.x);
        }
        else if (vertexID == 15 || vertexID == 14 || vertexID == 11 || vertexID == 10) { // Top T middle edge
            position.x = anchorPositions.z + halfLineWidthModelSpace;
        }
        else if (vertexID == 8 || vertexID == 9) { // Top T bottom edge
            position.x = anchorPositions.z + halfLineWidthModelSpace;
        }
        
        /// Y
        if (vertexID == 12 || vertexID == 11 || vertexID == 2 || vertexID == 1) { // Middle right
            position.y = anchorPositions.y;
        }
        else if (vertexID == 13 || vertexID == 14 || vertexID == 7 || vertexID == 0) { // Middle left
            position.y = anchorPositions.y;
        }
        else if (vertexID == 10 || vertexID == 9 || vertexID == 4 || vertexID == 3) { // Right edge
            position.y = anchorPositions.y + (halfCapWith * scaleFactor.y);
        }
        else if (vertexID == 15 || vertexID == 8 || vertexID == 5 || vertexID == 6) { // Left edge
            position.y = anchorPositions.y - (halfCapWith * scaleFactor.y);
        }
    }
    else { // Vertical I-Beam constraint
        
        // Inset Y by half line width, so the constraint doesn't grow outside its bounds.
        float halfLineHeightModelSpace = halfLineWidth * scaleFactor.y;
        
        /// Y
        if (vertexID == 0 || vertexID == 1) { // Bottom T bottom edge
            position.y = anchorPositions.y - halfLineHeightModelSpace - (pinLength * scaleFactor.y);
        }
        else if (vertexID == 6|| vertexID == 7 || vertexID == 2 || vertexID == 3) { // Bottom T middle edge
            position.y = anchorPositions.y - halfLineHeightModelSpace;
        }
        else if (vertexID == 5 || vertexID == 4) { // Bottom T top edge
            position.y = anchorPositions.y - halfLineHeightModelSpace;
        }
        else if (vertexID == 13 || vertexID == 12) { // Top T top edge
            position.y = anchorPositions.w + halfLineHeightModelSpace + (pinLength * scaleFactor.y);
        }
        else if (vertexID == 15 || vertexID == 14 || vertexID == 11 || vertexID == 10) { // Top T middle edge
            position.y = anchorPositions.w + halfLineHeightModelSpace;
        }
        else if (vertexID == 8 || vertexID == 9) { // Top T bottom edge
            position.y = anchorPositions.w + halfLineHeightModelSpace;
        }
        
        /// X
        if (vertexID == 12 || vertexID == 11 || vertexID == 2 || vertexID == 1) { // Middle right
            position.x = anchorPositions.x;
        }
        else if (vertexID == 13 || vertexID == 14 || vertexID == 7 || vertexID == 0) { // Middle left
            position.x = anchorPositions.x;
        }
        else if (vertexID == 10 || vertexID == 9 || vertexID == 4 || vertexID == 3) { // Right edge
            position.x = anchorPositions.x + (halfCapWith * scaleFactor.x);
        }
        else if (vertexID == 15 || vertexID == 8 || vertexID == 5 || vertexID == 6) { // Left edge
            position.x = anchorPositions.x - (halfCapWith * scaleFactor.x);
        }
    }
    
    vec4 screenSpacePosition = u_mvp * position; // World space to screen space
    
    float cosAngleLine = angles.x;
    float sinAngleLine = angles.y;
    float cosAngleCap = angles.z;
    float sinAngleCap = angles.w;
    
    // - Screen space manipulations -
    if (vertexID == 12 || vertexID == 11 || vertexID == 2 || vertexID == 1) { // Middle right
        
        screenSpacePosition.x += (halfLineWidth * screenSpacePixelSize.x) * cosAngleLine;
        screenSpacePosition.y += (halfLineWidth * screenSpacePixelSize.y) * sinAngleLine;
    }
    else if (vertexID == 13 || vertexID == 14 || vertexID == 7 || vertexID == 0) { // Middle left
        
        screenSpacePosition.x -= (halfLineWidth * screenSpacePixelSize.x) * cosAngleLine;
        screenSpacePosition.y -= (halfLineWidth * screenSpacePixelSize.y) * sinAngleLine;
    }
    
    // -- Top Cap --
    else if (vertexID == 8 || vertexID == 9) { // Top Cap bottom left / right
        screenSpacePosition.x -= (halfLineWidth * screenSpacePixelSize.x) * cosAngleCap;
        screenSpacePosition.y -= (halfLineWidth * screenSpacePixelSize.y) * sinAngleCap;
    }
    else if (vertexID == 15 || vertexID == 10) { // Top Cap top left / right
        screenSpacePosition.x += (halfLineWidth * screenSpacePixelSize.x) * cosAngleCap;
        screenSpacePosition.y += (halfLineWidth * screenSpacePixelSize.y) * sinAngleCap;
    }

    // -- Bottom Cap --
    else if (vertexID == 6 || vertexID == 3) { // Bottom Cap bottom left / right
        screenSpacePosition.x += (halfLineWidth * screenSpacePixelSize.x) * cosAngleCap;
        screenSpacePosition.y += (halfLineWidth * screenSpacePixelSize.y) * sinAngleCap;
    }
    else if (vertexID == 5 || vertexID == 4) { // Bottom Cap top left / right
        screenSpacePosition.x -= (halfLineWidth * screenSpacePixelSize.x) * cosAngleCap;
        screenSpacePosition.y -= (halfLineWidth * screenSpacePixelSize.y) * sinAngleCap;
    }
    
    // Let all vertices fall on the pixel grid
    if (snapToPixelGrid == 1) {
        screenSpacePosition.x -= mod(screenSpacePosition.x, screenSpacePixelSize.x);
        screenSpacePosition.y -= mod(screenSpacePosition.y, screenSpacePixelSize.y);
    }
    
    gl_Position = screenSpacePosition;
}
