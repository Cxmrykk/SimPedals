// Title: 2mm Throttle Pedal Plate Sheet Metal
// Modified to boolean a large curve profile into the design, 
// mimicking the slight radius obtained by stamping forming blocks in a vise.
// Curve radius has been flattened significantly to match automotive styling.

thickness = 2.0;
$fn = 64; 
arc_resolution = 32; 

slot_radius = 2.22;
hole_radius = 2.25;

grip_slots = [
    [[40.78, -32.03], [35.77, -26.82]], [[40.78,  45.50], [ 9.21,  77.77]],
    [[40.78,  30.00], [ 9.21,  62.06]], [[20.23,  19.58], [14.92,  25.07]],
    [[28.28, -35.05], [15.22, -21.78]], [[40.78, -16.47], [15.22,   9.21]],
    [[40.78,  -0.91], [35.77,   4.14]], [[20.23, -11.40], [15.22,  -6.32]],
    [[40.78,  61.04], [24.57,  77.92]], [[40.78,  14.55], [ 9.21,  46.41]]
];

mounting_holes = [
    [28.02, -19.19], [28.02,  11.91]
];

function arc_pts(cx, cy, r, start_ang, end_ang, steps=arc_resolution) =
    [ for(i=[0:steps]) let( a = start_ang + i*(end_ang - start_ang)/steps ) [ cx + r*cos(a), cy + r*sin(a) ] ];

outer_perimeter = concat(
    arc_pts(42.007, -36.053, 7.993, 270, 360),
    arc_pts(42.007,  78.721, 7.993,   0,  90),
    arc_pts( 7.993,  78.721, 7.993,  90, 180),
    arc_pts( 8.269,  34.411, 8.270, 180, 224.176),
    arc_pts(-2.428,  21.489, 8.429, 43.748, 1.083),
    arc_pts(13.993, -36.053, 7.993, 180, 270)
);

module curved_shell(radius, thk, width, y_center) {
    translate([width/2, y_center, -radius + thk])
        rotate([0, 90, 0])
            difference() {
                cylinder(r = radius, h = width*3, center = true, $fn=200);
                cylinder(r = radius - thk, h = width*3 + 1, center = true, $fn=200);
            }
}

module throttle_pedal_plate_2d() {
    difference() {
        polygon(outer_perimeter);
        
        for(slot = grip_slots) {
            hull() {
                translate(slot[0]) circle(r = slot_radius);
                translate(slot[1]) circle(r = slot_radius);
            }
        }
        
        for(hole = mounting_holes) {
            translate(hole) circle(r = hole_radius);
        }
    }
}

// 400mm radius produces a much gentler, flatter curve than 150mm.
module throttle_pedal_plate(curve_radius = 400) {
    if (curve_radius > 0) {
        intersection() {
            // Extrude infinitely large Z to capture the boolean curve slice
            translate([0, 0, -50])
                linear_extrude(height = 100, convexity = 10)
                    throttle_pedal_plate_2d();
                    
            curved_shell(radius = curve_radius, thk = thickness, width = 100, y_center = 21);
        }
    } else {
        linear_extrude(height = thickness, convexity = 10)
            throttle_pedal_plate_2d();
    }
}

throttle_pedal_plate(curve_radius = 400);