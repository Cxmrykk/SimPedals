/*
  3mm Spring Back Plate
  Generated from 2D DXF Flat Pattern
  Modified for native 3D printing by applying 90-degree folds and inner corner fillets.
*/

// Set resolution for smooth arcs and circles
$fn = 100;

// Material thickness specified in file name
thickness = 3.0;

module spring_back_plate_2d() {
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

module spring_back_plate(thickness = 3.0) {
    // Fold locations derived from the tips of the V-notches
    x_left = -0.9634954085;
    x_right = 47.4634954085;
    
    // Center Piece
    linear_extrude(height = thickness, convexity = 4)
        intersection() {
            spring_back_plate_2d();
            translate([x_left, -100]) square([x_right - x_left, 200]);
        }
        
    // Left Tab Folded 90 deg up
    translate([x_left - thickness, 0, 0])
        rotate([0, 90, 0])
            translate([-x_left, 0, 0])
                linear_extrude(height = thickness, convexity = 4)
                    intersection() {
                        spring_back_plate_2d();
                        translate([-200, -100]) square([200 + x_left, 200]);
                    }
                    
    // Right Tab Folded 90 deg up
    translate([x_right + thickness, 0, 0])
        rotate([0, -90, 0])
            translate([-x_right, 0, 0])
                linear_extrude(height = thickness, convexity = 4)
                    intersection() {
                        spring_back_plate_2d();
                        translate([x_right, -100]) square([200, 200]);
                    }
                    
    // Inner Fillets to reinforce printed folds against layer line separation
    translate([x_left, 0, thickness])
        rotate([-90, 0, 0])
            linear_extrude(height = 20)
                polygon([[0,0], [2,0], [0,2]]);
                
    translate([x_right, 0, thickness])
        rotate([-90, 0, 0])
            linear_extrude(height = 20)
                polygon([[0,0], [-2,0], [0,2]]);
}

// Render the folded 3D part
spring_back_plate(thickness);