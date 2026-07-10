// Metal Components/Steel Parts/2mm Foot Plate x1.scad
// Thickness: 2mm

$fn = 64; // High resolution for smooth arcs/circles

module 2mm_Foot_Plate() {
    linear_extrude(height = 2) {
        difference() {
            // Main body perimeter using hull
            hull() {
                translate([5, 5]) circle(r = 5);
                translate([365, 5]) circle(r = 5);
                translate([365, 140]) circle(r = 5);
                translate([5, 140]) circle(r = 5);
            }
            
            // Subtracted Holes (Radius 1.75 -> 3.5mm Dia)
            translate([15.0, 135.0]) circle(r = 1.75);
            translate([128.3333, 135.0]) circle(r = 1.75);
            translate([241.6667, 135.0]) circle(r = 1.75);
            translate([355.0, 135.0]) circle(r = 1.75);
        }
    }
}

// Render the part
2mm_Foot_Plate();