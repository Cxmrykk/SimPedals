// Metal Components/Steel Parts/3mm Load Cell Mounting Plate x2.scad
// Thickness: 3mm

$fn = 64; // High resolution for smooth holes

module 3mm_Load_Cell_Mounting_Plate() {
    // Exact polygon points traced CCW from the DXF
    poly_points = [
        [0, 0],
        [5, 0],
        [5, -3],
        [15, -3],
        [15, 0],
        [20, 0],
        [20, 38],
        [15, 38],
        [15, 41],
        [5, 41],
        [5, 38],
        [0, 38]
    ];

    linear_extrude(height = 3) {
        difference() {
            // Main body
            polygon(poly_points);
            
            // Subtracted Holes (Radius 2.75 -> 5.5mm Dia)
            translate([10, 11.5]) circle(r = 2.75);
            translate([10, 26.5]) circle(r = 2.75);
        }
    }
}

// Render the part
3mm_Load_Cell_Mounting_Plate();