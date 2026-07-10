// Metal Components/Steel Parts/3mm Pedal Side Plate x6.scad
// Thickness: 3mm

$fn = 64; 

function make_arc(x, y, r, a1, a2, steps=24) =
    let (delta = (a2 < a1 && a2 > a1 - 360) ? a2 - a1 : 
                 (a2 > a1 ? a2 - a1 : a2 - a1 + 360))
    [for (i=[0:steps]) [
        x + r*cos(a1 + delta*i/steps),
        y + r*sin(a1 + delta*i/steps)
    ]];

module 3mm_Pedal_Side_Plate() {
    // Exterior geometry 
    pts_outer = concat(
        [[10.239, -7.169], [36.383, 30.167]],
        make_arc(20, 41.638, 20, 325, 360),
        [[40, 41.638], [40, 86.044]],
        make_arc(20, 86.044, 20, 0, 17),
        [[39.126, 91.891], [6.529, 198.511]],
        make_arc(3.660, 197.634, 3, 17, 80),
        [[4.181, 200.589], [-0.902, 201.485]],
        make_arc(-1.422, 198.530, 3, 80, 170),
        [[-4.377, 199.051], [-14.984, 138.895]],
        make_arc(-12.030, 138.374, 3, 170, 203.804),
        make_arc(-173.669, 67.066, 183.669, 23.804, -21.115),
        make_arc(0, 0, 12.5, 158.884, 325)
    );

    // Large upper adjustment slot
    pts_slot1 = concat(
        make_arc(7, 87.5, 6.75, 67.958, 10.464),
        make_arc(16.587, 89.270, 3, 190.464, 319.884),
        make_arc(25, 82.183, 8, 139.884, 89.283),
        make_arc(25.137, 93.182, 3, 269.283, 17.0),
        [[28.006, 94.059], [5.820, 166.627]],
        make_arc(2.951, 165.750, 3, 17.0, 170.0),
        [[-0.003, 166.271], [-3.151, 148.418]],
        make_arc(-0.196, 147.897, 3, 170.0, 214.415),
        make_arc(-8.858, 141.962, 7.5, 34.415, -34.467),
        make_arc(-0.202, 136.020, 3, 145.532, 201.677),
        make_arc(-173.669, 67.066, 183.669, 21.677, 9.083),
        make_arc(10.658, 96.537, 3, 189.083, 247.958)
    );

    // Bottom left slotted track
    pts_slot2 = concat(
        make_arc(0, 0, 12, 77.416, 52.583),
        make_arc(7.898, 10.325, 1, 232.583, 350.070),
        [[8.883, 10.152], [9.767, 15.200]],
        make_arc(8.782, 15.372, 1, 350.070, 436.247),
        make_arc(10.565, 22.657, 6.5, 256.247, 233.752),
        make_arc(6.130, 16.609, 1, 53.752, 139.929),
        [[5.365, 17.252], [2.066, 13.331]],
        make_arc(2.832, 12.687, 1, 139.929, 257.416)
    );

    // Middle adjustment slot
    pts_slot3 = concat(
        make_arc(14.416, 49.183, 3, 90.0, 15.826),
        make_arc(25.0, 52.183, 8, 207.035, 195.826),
        make_arc(15.202, 47.183, 3, 27.035, -27.035),
        make_arc(25.0, 42.183, 8, 252.0, 152.964),
        make_arc(21.601, 31.721, 3, 72.001, -35.0),
        [[24.058, 30.000], [21.774, 26.738]],
        make_arc(19.317, 28.459, 3, 325.0, 213.541),
        make_arc(10.565, 22.657, 7.5, 93.686, 33.541),
        make_arc(9.890, 33.135, 3, 273.686, 169.527),
        make_arc(-173.669, 67.066, 183.669, 354.502, 349.527),
        make_arc(12.141, 49.183, 3, 174.502, 90.0),
        [[12.141, 52.183], [14.416, 52.183]]
    );

    linear_extrude(height = 3) {
        difference() {
            polygon(pts_outer);
            
            // Subtract interior tracks
            polygon(pts_slot1);
            polygon(pts_slot2);
            polygon(pts_slot3);
            
            // Clearance and Mounting Holes
            translate([-0.176, 191.203]) circle(r=2.5);
            translate([-8.858, 141.962]) circle(r=2.5);
            translate([7.0, 75.0]) circle(r=2.5);
            translate([10.565, 22.657]) circle(r=2.5);
            translate([7.0, 62.5]) circle(r=1.75);
            translate([7.0, 87.5]) circle(r=1.75);
            translate([25.0, 42.183]) circle(r=3.0);
            translate([25.0, 82.183]) circle(r=3.0);
            translate([25.0, 62.183]) circle(r=3.0);
            translate([25.0, 52.183]) circle(r=3.0);
            translate([25.0, 72.183]) circle(r=3.0);
            translate([0.0, 0.0]) circle(r=8.05); // Pivot point
        }
    }
}

3mm_Pedal_Side_Plate();