// 2mm Brake & Clutch Pedal Plate Sheet Metal
// Modified to boolean a large curve profile into the design, 
// mimicking the slight radius obtained by stamping forming blocks in a vise.
// Curve radius has been flattened significantly to match automotive styling.

$fn = 100;

plate_thickness = 2.0;
pedal_width     = 50.0;
corner_radius   = 8.0;

offset_x = 8.0;
cx_left  = offset_x;
cx_right = offset_x + pedal_width - (2 * corner_radius); 
cy_top   = 34.5;
cy_bot   = -35.0;

hole_radius = 2.25;  
hole_x      = 25.0;  
hole_y_top  = 13.0;
hole_y_bot  = -18.0;

slot_radius    = 2.25;
slot_margin    = 9.5;  
slot_spacing   = 15.5; 
slot_base_c    = -8.5; 

y_max_outer = cy_top + corner_radius; 
y_min_outer = cy_bot - corner_radius; 
slot_x_min  = offset_x - corner_radius + slot_margin; 
slot_x_max  = cx_right + corner_radius - slot_margin; 
slot_y_min  = y_min_outer + slot_margin;              
slot_y_max  = y_max_outer - slot_margin;              

hole_keepout_x = 7.5; 

module draw_slot(x1, y1, x2, y2) {
    hull() {
        translate([x1, y1]) circle(r = slot_radius);
        translate([x2, y2]) circle(r = slot_radius);
    }
}

module pattern_slots() {
    for(i = [0 : 5]) {
        c = slot_base_c + (i * slot_spacing);
        
        x_start = max(slot_x_min, c - slot_y_max);
        x_end   = min(slot_x_max, c - slot_y_min);
        
        if (x_start < x_end) {
            is_hole_line = (i == 1 || i == 3);
            if (is_hole_line) {
                gap_start = hole_x - hole_keepout_x;
                gap_end   = hole_x + hole_keepout_x;
                
                if (x_start < gap_start) draw_slot(x_start, c - x_start, gap_start, c - gap_start);
                if (gap_end < x_end) draw_slot(gap_end, c - gap_end, x_end, c - x_end);
            } else {
                draw_slot(x_start, c - x_start, x_end, c - x_end);
            }
        }
    }
}

module curved_shell(radius, thk, width, y_center) {
    translate([width/2, y_center, -radius + thk])
        rotate([0, 90, 0])
            difference() {
                cylinder(r = radius, h = width*3, center = true, $fn=200);
                cylinder(r = radius - thk, h = width*3 + 1, center = true, $fn=200);
            }
}

module pedal_plate_2d() {
    difference() {
        hull() {
            translate([cx_left, cy_top]) circle(r = corner_radius);
            translate([cx_right, cy_top]) circle(r = corner_radius);
            translate([cx_right, cy_bot]) circle(r = corner_radius);
            translate([cx_left, cy_bot]) circle(r = corner_radius);
        }
        
        translate([hole_x, hole_y_bot]) circle(r = hole_radius);
        translate([hole_x, hole_y_top]) circle(r = hole_radius);
        
        pattern_slots();
    }
}

// 400mm radius produces a much gentler, flatter curve than 150mm.
module pedal_plate_3d(curve_radius = 400) {
    if (curve_radius > 0) {
        intersection() {
            translate([0, 0, -50])
                linear_extrude(height = 100, convexity = 10)
                    pedal_plate_2d();
                    
            curved_shell(radius = curve_radius, thk = plate_thickness, width = 100, y_center = 0);
        }
    } else {
        linear_extrude(height = plate_thickness, convexity = 10)
            pedal_plate_2d();
    }
}

pedal_plate_3d(curve_radius = 400);