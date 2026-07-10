// Metal Components/Steel Parts/3mm Spring Back Plate x2.scad
// Thickness: 3mm

$fn = 64; 

// Helper function to generate points along an arc
function make_arc(x, y, r, a1, a2, steps=16) =
    [for (i=[0:steps]) [
        x + r*cos(a1 + (a2-a1)*i/steps),
        y + r*sin(a1 + (a2-a1)*i/steps)
    ]];

module 3mm_Spring_Back_Plate() {
    
    // Trace outer perimeter CCW combining straight line coordinates and mathematical arcs
    pts = concat(
        // Bottom Edge right-to-left
        [[-28.927, 0], [-1.963, 0]],
        [[-0.963, 1], [0.0365, 0]], // Relief cut
        [[46.463, 0]],
        [[47.463, 1], [48.463, 0]], // Relief cut
        [[75.427, 0]],
        
        // Right ear
        make_arc(75.427, 5, 5, 270, 360),
        [[80.427, 5], [80.427, 15]],
        make_arc(75.427, 15, 5, 0, 90),
        
        // Top Edge left-to-right
        [[75.427, 20], [48.463, 20]],
        [[47.463, 19], [46.463, 20]], // Relief cut
        [[0.0365, 20]],
        [[-0.963, 19], [-1.963, 20]], // Relief cut
        [[-28.927, 20]],
        
        // Left ear
        make_arc(-28.927, 15, 5, 90, 180),
        [[-33.927, 15], [-33.927, 5]],
        make_arc(-28.927, 5, 5, 180, 270)
    );

    difference() {
        // Base plate extrusion
        linear_extrude(height = 3) {
            difference() {
                polygon(pts);
                
                // M5 Side mounting holes (Radius 2.5)
                translate([75.427, 10]) circle(r = 2.5);
                translate([-28.927, 10]) circle(r = 2.5);
                
                // Center clear hole for M6 rod (Radius 6.0)
                translate([23.25, 10]) circle(r = 6.0);
            }
        }
        
        // Visual fold scoring marks (subtracted 0.2mm into the top surface)
        translate([-0.963, 10, 3 - 0.2])
            cube([0.5, 19, 0.4], center=true);
        translate([47.463, 10, 3 - 0.2])
            cube([0.5, 19, 0.4], center=true);
    }
}

// Render the part
3mm_Spring_Back_Plate();