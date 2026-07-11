/* 
 * 3mm Angled Load Cell Bracket
 * Modified for native 3D printing by splitting the pattern at the V-notches,
 * wrapping the tabs to 90 degrees, and infilling the inside corner for durability.
 */

$fn = 64;
thickness = 3.0;

function make_arc(cx, cy, r, a1, a2) = 
    let(steps = max(4, ceil($fn * abs(a2 - a1) / 360)), step_ang = (a2 - a1) / steps)
    [ for (i = [0 : steps]) [ cx + r * cos(a1 + i * step_ang), cy + r * sin(a1 + i * step_ang) ] ];

module bracket_profile() {
    points = concat(
        make_arc(3.0, 15.0865482874, 3.0, 232.0, 149.7698776489),
        make_arc(7.2865684576, 22.4427118760, 3.0, 149.7698776489, 59.7698776489),
        make_arc(21.1322087809, 21.3189711744, 3.0, 239.7698776489, 309.7698776489),
        [
            [24.2370935026, 20.0], [24.5722703804, 20.0], [25.5722703804, 19.0], [26.5722703804, 20.0],
            [64.8426241360, 20.0], [65.8426241360, 19.0], [66.8426241360, 20.0], [67.1778010138, 20.0]
        ],
        make_arc(70.2826857355, 21.3189711744, 3.0, 230.2301223511, 300.2301223511),
        make_arc(84.1283260588, 22.4427118760, 3.0, 120.2301223511, 30.2301223511),
        make_arc(88.4148945164, 15.0865482874, 3.0, 390.2301223511, 308.0),
        make_arc(70.5345248809, 10.0, 10.0, 308.0, 270.0),
        [
            [66.8426241360, 0.0], [65.8426241360, 1.0], [64.8426241360, 0.0],
            [26.5722703804, 0.0], [25.5722703804, 1.0], [24.5722703804, 0.0], [20.8803696355, 0.0]
        ],
        make_arc(20.8803696355, 10.0, 10.0, 270.0, 232.0)
    );
    polygon(points);
}

module bracket_profile_2d() {
    difference() {
        bracket_profile();
        translate([85.0191381936, 14.6171121125]) circle(r = 2.5);
        translate([ 6.3957563228, 14.6171121125]) circle(r = 2.5);
        translate([45.7074472582, 10.0000000000]) circle(r = 2.5);
    }
}

module bracket_3d(thickness = 3.0) {
    x_left = 25.5722703804;
    x_right = 65.8426241360;
    
    // Center Piece
    linear_extrude(height = thickness, convexity = 4)
        intersection() {
            bracket_profile_2d();
            translate([x_left, -100]) square([x_right - x_left, 200]);
        }
        
    // Left Tab Folded 90 deg up
    translate([x_left - thickness, 0, 0])
        rotate([0, 90, 0])
            translate([-x_left, 0, 0])
                linear_extrude(height = thickness, convexity = 4)
                    intersection() {
                        bracket_profile_2d();
                        translate([-200, -100]) square([200 + x_left, 200]);
                    }
                    
    // Right Tab Folded 90 deg up
    translate([x_right + thickness, 0, 0])
        rotate([0, -90, 0])
            translate([-x_right, 0, 0])
                linear_extrude(height = thickness, convexity = 4)
                    intersection() {
                        bracket_profile_2d();
                        translate([x_right, -100]) square([200, 200]);
                    }
                    
    // Added structure inside the folded joints
    translate([x_left, 0, thickness])
        rotate([-90, 0, 0])
            linear_extrude(height = 20)
                polygon([[0,0], [2,0], [0,2]]);
                
    translate([x_right, 0, thickness])
        rotate([-90, 0, 0])
            linear_extrude(height = 20)
                polygon([[0,0], [-2,0], [0,2]]);
}

bracket_3d(thickness);