// Title: 2mm Throttle Pedal Plate Sheet Metal
// Description: Parametric reconstruction of throttle pedal plate, 
//              refactored from a rigid DXF point-cloud export.
// Thickness: 2.0 mm

// ---- Configuration & Parameters ----
thickness = 2.0;
$fn = 64; // High resolution for internal smooth cutouts
arc_resolution = 32; // Steps per arc segment for the outer perimeter

// Slot and hole dimensions
slot_radius = 2.22;
hole_radius = 2.25;

// Grip Slots (Diagonal cutouts)
// Defined as pairs of [start_point, end_point] representing the centers of the slot ends.
// Note: X-coordinates have been aligned to logical boundaries (e.g., exactly 40.78 for the right edge) 
// to remove CAD export artifacts and preserve design intent.
grip_slots = [
    [[40.78, -32.03], [35.77, -26.82]],
    [[40.78,  45.50], [ 9.21,  77.77]],
    [[40.78,  30.00], [ 9.21,  62.06]],
    [[20.23,  19.58], [14.92,  25.07]],
    [[28.28, -35.05], [15.22, -21.78]],
    [[40.78, -16.47], [15.22,   9.21]],
    [[40.78,  -0.91], [35.77,   4.14]], 
    [[20.23, -11.40], [15.22,  -6.32]],
    [[40.78,  61.04], [24.57,  77.92]], 
    [[40.78,  14.55], [ 9.21,  46.41]]
];

// Mounting Holes
mounting_holes = [
    [28.02, -19.19],
    [28.02,  11.91]
];

// ---- Helper Functions ----

// Generates points for an arc sequence, allowing perfect CCW/CW continuous polygons
function arc_pts(cx, cy, r, start_ang, end_ang, steps=arc_resolution) =
    [ for(i=[0:steps])
        let( a = start_ang + i*(end_ang - start_ang)/steps )
        [ cx + r*cos(a), cy + r*sin(a) ]
    ];

// ---- Outer Profile Definition ----

// The exact continuous perimeter of the pedal plate. 
// Using `concat` of explicit arcs seamlessly connects them with the exact intended straight lines 
// between the tangent points, completely bypassing complex boolean operations.
outer_perimeter = concat(
    arc_pts(42.007, -36.053, 7.993, 270, 360),     // Bottom right corner
    arc_pts(42.007,  78.721, 7.993,   0,  90),     // Top right corner
    arc_pts( 7.993,  78.721, 7.993,  90, 180),     // Top left corner
    arc_pts( 8.269,  34.411, 8.270, 180, 224.176), // S-curve top (convex transition)
    arc_pts(-2.428,  21.489, 8.429, 43.748, 1.083),// S-curve bottom (concave transition, tracing CW)
    arc_pts(13.993, -36.053, 7.993, 180, 270)      // Bottom left corner
);


// ---- Main Module Generator ----

module throttle_pedal_plate() {
    linear_extrude(height = thickness) {
        difference() {
            // 1. Draw solid outer base profile
            polygon(outer_perimeter);
            
            // 2. Subtract isolated diagonal grip slots
            // The DXF split some of these slots due to a folded bend-line feature. 
            // Representing them as a single hull() completely repairs the flat pattern logic.
            for(slot = grip_slots) {
                hull() {
                    translate(slot[0]) circle(r = slot_radius);
                    translate(slot[1]) circle(r = slot_radius);
                }
            }
            
            // 3. Subtract standalone circular mounting holes
            for(hole = mounting_holes) {
                translate(hole) circle(r = hole_radius);
            }
        }
    }
}

// Render the design
throttle_pedal_plate();