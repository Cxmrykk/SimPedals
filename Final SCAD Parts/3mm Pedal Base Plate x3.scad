// Metal Components/Steel Parts/3mm Pedal Base Plate x3.scad
// Thickness: 3mm

$fn = 64; 

// Helper function to generate points along an arc
function make_arc(x, y, r, a1, a2, steps=16) =
    let (delta = (a2 < a1 && a2 > a1 - 360) ? a2 - a1 : 
                 (a2 > a1 ? a2 - a1 : a2 - a1 + 360))
    [for (i=[0:steps]) [
        x + r*cos(a1 + delta*i/steps),
        y + r*sin(a1 + delta*i/steps)
    ]];

module 3mm_Pedal_Base_Plate() {
    // Outer perimeter traced CCW
    pts_outer = concat(
        [[170, 30.1415], [170, 17.070], [169, 16.070], [170, 15.070], [170, 3]],
        make_arc(167, 3, 3, 0, -90),
        [[167, 0], [153, 0]],
        make_arc(153, 3, 3, -90, -180),
        [[150, 3], [150, 15.070], [151, 16.070], [150, 17.070], [20, 17.070], [19, 16.070], [20, 15.070], [20, 3]],
        make_arc(17, 3, 3, 0, -90),
        [[17, 0], [3, 0]],
        make_arc(3, 3, 3, -90, -180),
        [[0, 3], [0, 15.070], [1, 16.070], [0, 17.070], [0, 34.962]],
        make_arc(3, 34.962, 3, 180, 108),
        [[2.072, 37.815], [16.787, 42.596]],
        make_arc(15.242, 47.351, 5, 288, 378), // 378 is 18 degrees
        [[19.997, 48.896], [4.499, 96.596]],
        make_arc(9.254, 98.141, 5, 198, 90),
        [[9.254, 103.141], [18.239, 103.141]],
        make_arc(18.239, 93.141, 10, 90, 18),
        [[27.749, 96.231], [33.657, 78.051]],
        make_arc(43.167, 81.141, 10, 198, 270), 
        [[43.167, 71.141], [63.636, 71.141]],
        make_arc(63.636, 61.141, 10, 90, 18),
        [[73.147, 64.231], [77.105, 52.051]],
        make_arc(86.615, 55.141, 10, 198, 270),
        [[86.615, 45.141], [110.722, 45.141]],
        make_arc(110.722, 40.141, 5, 90, 19.471),
        make_arc(124.864, 45.141, 10, 199.471, 270),
        [[124.864, 35.141], [139.564, 35.141]],
        make_arc(139.564, 45.141, 10, 270, 319.294),
        make_arc(157.0, 30.141, 13, 139.294, 0)
    );

    linear_extrude(height = 3) {
        difference() {
            // Main exterior shape
            polygon(pts_outer);
            
            // Mounting Holes
            translate([13, 30.1415]) circle(r=2.5);
            translate([139.969, 63.325]) circle(r=2.75);
            translate([142.442, 70.934]) circle(r=2.75);
            translate([144.914, 78.542]) circle(r=2.75);
            translate([147.386, 86.151]) circle(r=2.75);
            translate([149.858, 93.759]) circle(r=2.75);
            translate([160, 25.641]) circle(r=2.5);
            translate([10, 7.5]) circle(r=1.75);
            translate([160, 7.5]) circle(r=1.75);
            
            // Interior Slot 1 (Horizontal Top)
            hull() {
                translate([94, 39.1415]) circle(r=2.55);
                translate([109, 39.1415]) circle(r=2.55);
            }
            // Interior Slot 2 (Vertical Right)
            hull() {
                translate([120, 22.6415]) circle(r=1.55);
                translate([120, 27.6415]) circle(r=1.55);
            }
            // Interior Slot 3 (Vertical Left)
            hull() {
                translate([50, 22.6415]) circle(r=1.55);
                translate([50, 27.6415]) circle(r=1.55);
            }
            
            // Slanted Cutout 1
            polygon([[117.931, 47.121], [127.516, 50.610], [128.610, 47.603], [119.025, 44.114]]);
            // Slanted Cutout 2
            polygon([[126.892, 22.501], [136.477, 25.990], [137.571, 22.983], [127.986, 19.494]]);
            // Slanted Cutout 3
            polygon([[41.389, 47.603], [50.974, 44.114], [52.068, 47.121], [42.483, 50.610]]);
            // Slanted Cutout 4
            polygon([[32.428, 22.983], [42.013, 19.494], [43.107, 22.501], [33.522, 25.990]]);
        }
    }
}

3mm_Pedal_Base_Plate();