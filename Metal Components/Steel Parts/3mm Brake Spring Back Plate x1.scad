// 3mm Brake Spring Back Plate
// Extracted and reconstructed from DXF
// Modified for native 3D printing by applying 90-degree folds and inner corner fillets.

$fn = 100;

// Reconstruct the 2D outer perimeter with all lines, V-notches, and arcs
module outer_profile() {
    cx1 = -13.926990817; 
    cx2 = 60.426990817;  
    cy_bot = 5.0;        
    cy_top = 15.0;       
    rad = 5.0;           
    n_arc = 32; 
    
    points = concat(
        [ for (i = [0 : n_arc]) [cx1 + rad * cos(90 + i * 90 / n_arc), cy_top + rad * sin(90 + i * 90 / n_arc)] ],
        [ for (i = [0 : n_arc]) [cx1 + rad * cos(180 + i * 90 / n_arc), cy_bot + rad * sin(180 + i * 90 / n_arc)] ],
        [
            [-1.9634954085, 0.0],
            [-0.9634954085, 1.0],
            [0.0365045915, 0.0],
            [46.4634954085, 0.0],
            [47.4634954085, 1.0],
            [48.4634954085, 0.0]
        ],
        [ for (i = [0 : n_arc]) [cx2 + rad * cos(270 + i * 90 / n_arc), cy_bot + rad * sin(270 + i * 90 / n_arc)] ],
        [ for (i = [0 : n_arc]) [cx2 + rad * cos(0 + i * 90 / n_arc), cy_top + rad * sin(0 + i * 90 / n_arc)] ],
        [
            [48.4634954085, 20.0],
            [47.4634954085, 19.0],
            [46.4634954085, 20.0],
            [0.0365045915, 20.0],
            [-0.9634954085, 19.0],
            [-1.9634954085, 20.0]
        ]
    );
    polygon(points);
}

module internal_holes() {
    translate([-13.926990817, 10.0]) circle(r = 2.5);
    translate([60.426990817, 10.0]) circle(r = 2.5);
    translate([23.25, 10.0]) circle(r = 6.0);
}

module brake_spring_back_plate_2d() {
    difference() {
        outer_profile();
        internal_holes();
    }
}

// Generate the folded 3D part
module brake_spring_back_plate(thickness = 3.0) {
    x_left = -0.9634954085;
    x_right = 47.4634954085;
    
    // Center Piece
    linear_extrude(height = thickness, convexity = 4)
        intersection() {
            brake_spring_back_plate_2d();
            translate([x_left, -100]) square([x_right - x_left, 200]);
        }
        
    // Left Tab
    translate([x_left - thickness, 0, 0])
        rotate([0, 90, 0])
            translate([-x_left, 0, 0])
                linear_extrude(height = thickness, convexity = 4)
                    intersection() {
                        brake_spring_back_plate_2d();
                        translate([-200, -100]) square([200 + x_left, 200]);
                    }
                    
    // Right Tab
    translate([x_right + thickness, 0, 0])
        rotate([0, -90, 0])
            translate([-x_right, 0, 0])
                linear_extrude(height = thickness, convexity = 4)
                    intersection() {
                        brake_spring_back_plate_2d();
                        translate([x_right, -100]) square([200, 200]);
                    }
                    
    // Inner Fillets
    translate([x_left, 0, thickness])
        rotate([-90, 0, 0])
            linear_extrude(height = 20)
                polygon([[0,0], [2,0], [0,2]]);
                
    translate([x_right, 0, thickness])
        rotate([-90, 0, 0])
            linear_extrude(height = 20)
                polygon([[0,0], [-2,0], [0,2]]);
}

brake_spring_back_plate(thickness = 3.0);