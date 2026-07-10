// Metal Components/Steel Parts/3mm Angled Load Cell Bracket x1.scad
// Thickness: 3mm

$fn = 64; 

// Helper function to generate points along an arc
function make_arc(x, y, r, a1, a2, steps=16) =
    [for (i=[0:steps]) [
        x + r*cos(a1 + (a2-a1)*i/steps),
        y + r*sin(a1 + (a2-a1)*i/steps)
    ]];

module 3mm_Angled_Load_Cell_Bracket() {
    
    // Trace outer perimeter CCW combining straight line coordinates and mathematical arcs
    pts = concat(
        // Bottom Edge right-to-left
        [[20.8803, 0], [24.5722, 0]],
        [[25.5722, 1], [26.5722, 0]], // Relief cut
        [[64.8426, 0]],
        [[65.8426, 1], [66.8426, 0]], // Relief cut
        [[70.5345, 0]],
        
        // Right Side Complex
        make_arc(70.5345, 10.0, 10.0, 270.0, 308.0),
        make_arc(88.4148, 15.0865, 3.0, 308.0, 390.23), // 30.23 + 360 mapped
        make_arc(84.1283, 22.4427, 3.0, 30.23, 120.23),
        make_arc(70.2826, 21.3189, 3.0, 300.23, 230.23), // Reverse sweep
        
        // Top Edge left-to-right
        [[67.1778, 20.0], [66.8426, 20.0]],
        [[65.8426, 19.0], [64.8426, 20.0]], // Relief cut
        [[26.5722, 20.0]],
        [[25.5722, 19.0], [24.5722, 20.0]], // Relief cut
        [[24.2370, 20.0], [23.0513, 19.0131]],
        
        // Left Side Complex
        make_arc(21.1322, 21.3189, 3.0, 309.769, 239.769), // Reverse sweep
        make_arc(7.2865, 22.4427, 3.0, 59.769, 149.769),
        make_arc(2.9999, 15.0865, 3.0, 149.769, 232.0),
        make_arc(20.8803, 10.0, 10.0, 232.0, 270.0)
    );

    difference() {
        // Base plate extrusion
        linear_extrude(height = 3) {
            difference() {
                polygon(pts);
                
                // Mounting and clearance holes (Radius 2.5)
                translate([85.0191, 14.6171]) circle(r = 2.5);
                translate([6.3957, 14.6171]) circle(r = 2.5);
                translate([45.7074, 10.0]) circle(r = 2.5);
            }
        }
        
        // Visual fold scoring marks (subtracted 0.2mm into the top surface)
        translate([25.5722, 10, 3 - 0.2])
            cube([0.5, 17, 0.4], center=true);
        translate([65.8426, 10, 3 - 0.2])
            cube([0.5, 17, 0.4], center=true);
    }
}

// Render the part
3mm_Angled_Load_Cell_Bracket();