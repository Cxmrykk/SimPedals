// 2mm Brake & Clutch Pedal Plate Sheet Metal
// Generated completely from DXF specifications

$fn = 100;

// Helper function to generate ordered points for an arc
// Automatically handles angles wrapping past 360 degrees
function arc_pts(cx, cy, r, start_a, end_a, steps=24) =
    let(
        end_a_c = end_a < start_a ? end_a + 360 : end_a,
        step_a = (end_a_c - start_a) / steps
    )
    [ for (i = [0:steps]) 
        [ cx + r * cos(start_a + i * step_a), cy + r * sin(start_a + i * step_a) ]
    ];

module pedal_plate_2d() {
    difference() {
        // Outer Profile
        // Formed precisely by the 4 corner arcs in the DXF file
        hull() {
            translate([7.993033, 34.353099]) circle(r=7.993094);
            translate([42.007067, 34.353199]) circle(r=7.992994);
            translate([42.006967, -35.018715]) circle(r=7.993094);
            translate([7.992933, -35.018815]) circle(r=7.992994);
        }
        
        // Circular Mounting Holes
        translate([25.018584, -18.151597]) circle(r=2.251660);
        translate([25.018717, 12.947430]) circle(r=2.251441);
        
        // Internal Slots (Cutouts)
        // Reconstructed by concatenating arc segments in their natural CCW order. 
        // Polygons will automatically close the shape with straight lines where connecting points meet.
        
        // Loop 1
        polygon(concat(
            arc_pts(17.230560, 20.616744, 2.221879, 224.467558, 2.050949),
            arc_pts(16.989297, 20.673505, 2.461824, 0.529620, 42.693077),
            arc_pts(9.220460, 28.814561, 2.221788, 44.432653, 182.997848),
            arc_pts(9.450808, 28.700280, 2.449097, 180.044809, 222.777337)
        ));
        
        // Loop 2
        polygon(concat(
            arc_pts(25.285451, -34.026489, 2.216966, 224.086280, 3.714520),
            arc_pts(25.051302, -33.868771, 2.446499, 359.669987, 42.784323),
            arc_pts(9.221382, -17.752593, 2.221828, 44.467667, 181.769385),
            arc_pts(9.459819, -17.787825, 2.459431, 180.777426, 222.728413)
        ));
        
        // Loop 3
        polygon(concat(
            arc_pts(40.785451, -34.026489, 2.216966, 224.086280, 3.714520),
            arc_pts(40.551302, -33.868771, 2.446499, 359.669987, 42.784323),
            arc_pts(32.769739, -25.783969, 2.222263, 44.488665, 182.398551),
            arc_pts(33.016234, -25.866877, 2.466832, 180.234479, 222.629681)
        ));
        
        // Loop 4
        // Incorporates segmented inline line-points originating from split CAD references
        polygon(concat(
            arc_pts(17.231549, -10.368185, 2.220909, 224.405619, 1.490648),
            arc_pts(17.021730, -10.366442, 2.430622, 1.320927, 43.022318),
            [[10.806981, -0.739765], [10.246302, -0.332808]],
            arc_pts(9.229794, -2.414086, 2.316582, 64.443210, 115.187831),
            [[8.213853, -0.332808]],
            arc_pts(9.264616, -2.339095, 2.264794, 117.642632, 179.144005),
            arc_pts(9.451612, -2.238122, 2.452457, 181.568733, 222.834483)
        ));
        
        // Loop 5
        polygon(concat(
            arc_pts(40.779578, -2.893183, 2.220691, 224.402388, 0.911932),
            arc_pts(40.571383, -2.936862, 2.429889, 1.863644, 43.008657),
            [[41.398806, -0.332808]],
            arc_pts(32.768507, 5.178357, 2.220788, 44.404508, 181.136700),
            arc_pts(32.980346, 5.205527, 2.433232, 181.677413, 223.016534),
            [[35.091194, -0.332808]]
        ));
        
        // Loop 6
        polygon(concat(
            arc_pts(20.204578, 33.360805, 2.216993, 44.088062, 183.713339),
            arc_pts(20.437332, 33.202626, 2.445136, 179.657959, 222.796960),
            arc_pts(40.778580, 12.588693, 2.221758, 224.467224, 1.412866),
            arc_pts(40.543511, 12.596679, 2.456597, 1.091484, 42.771315)
        ));
        
        // Loop 7
        polygon(concat(
            arc_pts(9.220347, 13.252378, 2.221033, 44.408628, 181.762391),
            arc_pts(9.437238, 13.231363, 2.437332, 181.111788, 222.947876),
            [[19.591194, -0.332808]],
            arc_pts(40.779708, -18.444134, 2.221164, 224.410031, 2.122936),
            arc_pts(40.559669, -18.395802, 2.439914, 0.797219, 42.906397),
            [[25.898806, -0.332808]]
        ));
        
        // Loop 8
        polygon(concat(
            arc_pts(35.704578, 33.360805, 2.216993, 44.088062, 183.713339),
            arc_pts(35.937332, 33.202626, 2.445136, 179.657959, 222.796960),
            arc_pts(40.778772, 28.054450, 2.222004, 224.466594, 2.658007),
            arc_pts(40.536731, 28.159183, 2.461655, 359.960697, 42.666069)
        ));
    }
}

// Extrude 2D pattern matching component sheet metal thickness (2mm)
linear_extrude(height = 2.0) {
    pedal_plate_2d();
}