/*
 * 3mm Pedal Base Plate
 * Generated from DXF
 */

$fn = 100;
thickness = 3.0;

// Helper function to generate arc points along a curve
function arc_points(cx, cy, r, a1, a2, cw=false, fn=100) =
    cw ? 
        let(
            s = a1 < a2 ? a1 + 360 : a1,
            e = a2,
            steps = max(2, ceil(abs(s - e) / 360 * fn))
        )
        [ for (i = [0 : steps]) 
            [ cx + r * cos(s - i * (s - e) / steps), cy + r * sin(s - i * (s - e) / steps) ] 
        ]
    :
        let(
            s = a1,
            e = a2 < a1 ? a2 + 360 : a2,
            steps = max(2, ceil(abs(e - s) / 360 * fn))
        )
        [ for (i = [0 : steps]) 
            [ cx + r * cos(s + i * (e - s) / steps), cy + r * sin(s + i * (e - s) / steps) ] 
        ];

// Constructing the outer profile point by point, following the DXF boundary perfectly
outer_profile_points = concat(
    [ [3.0, 0.0], [17.0, 0.0] ],
    arc_points(17.0, 3.0, 3.0, 270, 0, false, $fn),
    
    // Notch
    [ 
      [20.0, 15.0707963268], 
      [19.0, 16.0707963268], 
      [20.0, 17.0707963268], 
      [150.0, 17.0707963268], 
      [151.0, 16.0707963268], 
      [150.0, 15.0707963268] 
    ],
    arc_points(153.0, 3.0, 3.0, 180, 270, false, $fn),
    [ [167.0, 0.0] ],
    arc_points(167.0, 3.0, 3.0, 270, 0, false, $fn),
    
    // Notch
    [ 
      [170.0, 15.0707963268], 
      [169.0, 16.0707963268], 
      [170.0, 17.0707963268], 
      [170.0, 34.9622488511] 
    ],
    
    // Complex perimeter sequence
    arc_points(167.0, 34.9622488511, 3.0, 0, 72, false, $fn),
    arc_points(154.7574561828, 47.3517902632, 5.0, 252, 162, true, $fn),
    arc_points(160.7454411049, 98.1415926536, 5.0, 342, 90, false, $fn),
    arc_points(151.760607054, 93.1415926536, 10.0, 90, 162, false, $fn),
    arc_points(126.8323262145, 81.1415926536, 10.0, 342, 270, true, $fn),
    arc_points(106.3631767746, 61.1415926536, 10.0, 90, 162, false, $fn),
    arc_points(83.3844141124, 55.1415926536, 10.0, 342, 270, true, $fn),
    arc_points(59.2773527738, 40.1415926536, 5.0, 90, 160.5287793655, false, $fn),
    arc_points(45.1352171501, 45.1415926536, 10.0, 340.5287793655, 270, true, $fn),
    arc_points(30.4355957742, 45.1415926536, 10.0, 270, 220.705706831, true, $fn),
    arc_points(13.0, 30.1415926536, 13.0, 40.705706831, 180, false, $fn),
    
    // Final Notch and closing boundary
    [ 
      [0.0, 17.0707963268], 
      [1.0, 16.0707963268], 
      [0.0, 15.0707963268], 
      [0.0, 3.0] 
    ],
    arc_points(3.0, 3.0, 3.0, 180, 270, false, $fn)
);

module internal_holes_and_slots() {
    // Standard Circular Holes
    translate([13.0, 30.1415926536]) circle(r=2.5);
    translate([139.9699502014, 63.3258181209]) circle(r=2.75);
    translate([142.4420861564, 70.9342702513]) circle(r=2.75);
    translate([144.9142221114, 78.5427223816]) circle(r=2.75);
    translate([147.3863580664, 86.1511745120]) circle(r=2.75);
    translate([149.8584940214, 93.7596266423]) circle(r=2.75);
    translate([160.0, 25.6415926536]) circle(r=2.5);
    translate([10.0, 7.5]) circle(r=1.75);
    translate([160.0, 7.5]) circle(r=1.75);
    
    // Rounded Slot 1 (Horizontal)
    hull() {
        translate([61.0, 39.1415926536]) circle(r=2.55);
        translate([76.0, 39.1415926536]) circle(r=2.55);
    }
    
    // Rounded Slot 2 (Vertical)
    hull() {
        translate([50.0, 22.6415926536]) circle(r=1.55);
        translate([50.0, 27.6415926536]) circle(r=1.55);
    }
    
    // Tilted Rectangular Slot 1
    polygon(points=[
        [117.9312213654, 47.1214784482],
        [127.5160860975, 50.6100839101],
        [128.6105505561, 47.6030675236],
        [119.0256858241, 44.1144620617]
    ]);
    
    // Tilted Rectangular Slot 2
    polygon(points=[
        [126.8921491206, 22.5015317836],
        [136.4770138526, 25.9901372455],
        [137.5714783112, 22.9831208590],
        [127.9866135792, 19.4945153971]
    ]);
}

// 3D Rendering Segment
linear_extrude(height = thickness) {
    difference() {
        polygon(points=outer_profile_points);
        internal_holes_and_slots();
    }
}