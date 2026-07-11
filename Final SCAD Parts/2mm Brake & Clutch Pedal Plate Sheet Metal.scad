// 2mm Brake & Clutch Pedal Plate Sheet Metal
// Refactored to use standard parameterized engineering dimensions

$fn = 100;

// --- CONFIGURATION VARIABLES ---

// Basic dimensions
plate_thickness = 2.0;
pedal_width     = 50.0;
corner_radius   = 8.0;

// Outer Profile Alignment
// Preserving the original global coordinate space for drop-in replacement compatibility
offset_x = 8.0;
cx_left  = offset_x;
cx_right = offset_x + pedal_width - (2 * corner_radius); // 42.0
cy_top   = 34.5;
cy_bot   = -35.0;

// Mounting Holes
hole_radius = 2.25;  // 4.5mm diameter (standard M4 clearance)
hole_x      = 25.0;  // Centered horizontally
hole_y_top  = 13.0;
hole_y_bot  = -18.0;

// Diagonal Cutout Slots (45-degree angle)
slot_radius    = 2.25;
slot_margin    = 9.5;  // Uniform spacing from the outer boundaries
slot_spacing   = 15.5; // Orthogonal spacing between parallel slots
slot_base_c    = -8.5; // Starting constant for Y = -X + C 

// Bounding box mapping for slot centers 
// (Derived dynamically from outer shape minus the uniform slot margin)
y_max_outer = cy_top + corner_radius; 
y_min_outer = cy_bot - corner_radius; 
slot_x_min  = offset_x - corner_radius + slot_margin; // 9.5
slot_x_max  = cx_right + corner_radius - slot_margin; // 40.5
slot_y_min  = y_min_outer + slot_margin;              // -33.5
slot_y_max  = y_max_outer - slot_margin;              // 33.0

// Keepout zone to prevent slots from cutting into mounting holes
// Ensures a solid 3mm metal web between the hole and the slot (7.5 - 2.25 - 2.25 = 3mm)
hole_keepout_x = 7.5; 


// --- MODULES ---

// Helper: Generates a single slot segment with fully rounded ends
module draw_slot(x1, y1, x2, y2) {
    hull() {
        translate([x1, y1]) circle(r = slot_radius);
        translate([x2, y2]) circle(r = slot_radius);
    }
}

// Helper: Programmatically generates the 45-degree diagonal pattern array
module pattern_slots() {
    // Generate the 6 diagonal line axes
    for(i = [0 : 5]) {
        // Line equation: Y = -X + C
        c = slot_base_c + (i * slot_spacing);
        
        // Calculate bounded X coordinates using the Y limits
        x_start = max(slot_x_min, c - slot_y_max);
        x_end   = min(slot_x_max, c - slot_y_min);
        
        // Ensure line actually exists within the bounds
        if (x_start < x_end) {
            
            // Check if this diagonal intersects our mounting holes (Indices 1 & 3)
            is_hole_line = (i == 1 || i == 3);
            
            if (is_hole_line) {
                // Split the line into two segments to leave solid material around the hole
                gap_start = hole_x - hole_keepout_x;
                gap_end   = hole_x + hole_keepout_x;
                
                if (x_start < gap_start) {
                    draw_slot(x_start, c - x_start, gap_start, c - gap_start);
                }
                if (gap_end < x_end) {
                    draw_slot(gap_end, c - gap_end, x_end, c - x_end);
                }
            } else {
                // Draw uninterrupted slot segment
                draw_slot(x_start, c - x_start, x_end, c - x_end);
            }
        }
    }
}

// Main 2D Shape Assembly
module pedal_plate_2d() {
    difference() {
        // 1. Outer Plate Profile
        hull() {
            translate([cx_left, cy_top]) circle(r = corner_radius);
            translate([cx_right, cy_top]) circle(r = corner_radius);
            translate([cx_right, cy_bot]) circle(r = corner_radius);
            translate([cx_left, cy_bot]) circle(r = corner_radius);
        }
        
        // 2. Circular Mounting Holes
        translate([hole_x, hole_y_bot]) circle(r = hole_radius);
        translate([hole_x, hole_y_top]) circle(r = hole_radius);
        
        // 3. Diagonal Cutout Array
        pattern_slots();
    }
}


// --- 3D OUTPUT EXTRUSION ---

// Extrude the 2D logic to match the component sheet metal thickness
linear_extrude(height = plate_thickness) {
    pedal_plate_2d();
}