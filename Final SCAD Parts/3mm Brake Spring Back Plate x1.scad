// 3mm Brake Spring Back Plate
// Extracted and reconstructed from DXF

$fn = 100;

// Main module to generate the part
module brake_spring_back_plate(thickness = 3.0) {
    linear_extrude(height = thickness) {
        difference() {
            outer_profile();
            internal_holes();
        }
    }
}

// Reconstruct the 2D outer perimeter with all lines, V-notches, and arcs
module outer_profile() {
    // Arc center points and radii derived from DXF
    cx1 = -13.926990817; // Left arcs X center
    cx2 = 60.426990817;  // Right arcs X center
    cy_bot = 5.0;        // Bottom arcs Y center
    cy_top = 15.0;       // Top arcs Y center
    rad = 5.0;           // Corner arcs radius
    
    // Resolution for individual 90-degree corner arcs
    n_arc = 32; 
    
    // Construct the continuous perimeter point list by concatenating segments counter-clockwise
    points = concat(
        // Left-top arc (90 to 180 degrees)
        [ for (i = [0 : n_arc]) 
            [cx1 + rad * cos(90 + i * 90 / n_arc), cy_top + rad * sin(90 + i * 90 / n_arc)] ],
        
        // Left-bottom arc (180 to 270 degrees)
        [ for (i = [0 : n_arc]) 
            [cx1 + rad * cos(180 + i * 90 / n_arc), cy_bot + rad * sin(180 + i * 90 / n_arc)] ],
        
        // Bottom straight edge with structural fold V-notches
        [
            [-1.9634954085, 0.0],
            [-0.9634954085, 1.0],
            [0.0365045915, 0.0],
            
            [46.4634954085, 0.0],
            [47.4634954085, 1.0],
            [48.4634954085, 0.0]
        ],
        
        // Right-bottom arc (270 to 360 degrees)
        [ for (i = [0 : n_arc]) 
            [cx2 + rad * cos(270 + i * 90 / n_arc), cy_bot + rad * sin(270 + i * 90 / n_arc)] ],
        
        // Right-top arc (0 to 90 degrees)
        [ for (i = [0 : n_arc]) 
            [cx2 + rad * cos(0 + i * 90 / n_arc), cy_top + rad * sin(0 + i * 90 / n_arc)] ],
        
        // Top straight edge with structural fold V-notches
        [
            [48.4634954085, 20.0],
            [47.4634954085, 19.0],
            [46.4634954085, 20.0],
            
            [0.0365045915, 20.0],
            [-0.9634954085, 19.0],
            [-1.9634954085, 20.0]
        ]
    );
    
    // Draw the main enclosed shape
    polygon(points);
}

// Precise circle locations from CUT layer
module internal_holes() {
    // Left side hole (aligned with arcs centers)
    translate([-13.926990817, 10.0]) circle(r = 2.5);
    
    // Right side hole (aligned with arcs centers)
    translate([60.426990817, 10.0]) circle(r = 2.5);
    
    // Main central hole
    translate([23.25, 10.0]) circle(r = 6.0);
}

// Generate part
brake_spring_back_plate();