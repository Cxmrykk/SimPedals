/*
  3mm Spring Back Plate
  Generated from 2D DXF Flat Pattern
*/

// Set resolution for smooth arcs and circles
$fn = 100;

// Material thickness specified in file name
thickness = 3.0;

module spring_back_plate() {
    linear_extrude(height = thickness) {
        difference() {
            // Main Outer Profile
            polygon([
                // Bottom-Left Arc (180 to 270 degrees)
                for (a = [180 : 1 : 270]) 
                    [-28.926990817 + 5 * cos(a), 5.0 + 5 * sin(a)],
                
                // Bottom edge and first (left) relief notch
                [-1.9634954085, 0.0],
                [-0.9634954085, 1.0],
                [0.0365045915, 0.0],
                
                // Bottom edge and second (right) relief notch
                [46.4634954085, 0.0],
                [47.4634954085, 1.0],
                [48.4634954085, 0.0],
                
                // Bottom-Right Arc (270 to 360 degrees)
                for (a = [270 : 1 : 360]) 
                    [75.426990817 + 5 * cos(a), 5.0 + 5 * sin(a)],
                
                // Top-Right Arc (0 to 90 degrees)
                for (a = [0 : 1 : 90]) 
                    [75.426990817 + 5 * cos(a), 15.0 + 5 * sin(a)],
                
                // Top edge and right relief notch
                [48.4634954085, 20.0],
                [47.4634954085, 19.0],
                [46.4634954085, 20.0],
                
                // Top edge and left relief notch
                [0.0365045915, 20.0],
                [-0.9634954085, 19.0],
                [-1.9634954085, 20.0],
                
                // Top-Left Arc (90 to 180 degrees)
                for (a = [90 : 1 : 180]) 
                    [-28.926990817 + 5 * cos(a), 15.0 + 5 * sin(a)]
            ]);
            
            // Internal Holes
            // Left mounting hole
            translate([-28.926990817, 10.0]) 
                circle(r = 2.5);
                
            // Right mounting hole
            translate([75.426990817, 10.0]) 
                circle(r = 2.5);
                
            // Center large clearance hole
            translate([23.25, 10.0]) 
                circle(r = 6.0);
        }
    }
}

// Render the part
spring_back_plate();