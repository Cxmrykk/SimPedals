/*
 * 2mm Foot Plate x1
 * Extruded from provided DXF file.
 * 
 * Dimensions: 370mm x 145mm
 * Material Thickness: 2mm
 * Corner Radius: 5mm
 */

// Set curve resolution for smooth circles and arcs
$fn = 100;

// Material thickness defined by the filename
thickness = 2;

module outer_profile() {
    // The outer boundary is a rounded rectangle.
    // Reconstructed using the centers of the 4 corner arcs (Radius 5)
    // Extents match DXF boundaries: X [0 to 370], Y [0 to 145]
    hull() {
        // Bottom-left corner (Arc 81)
        translate([5, 5]) circle(r=5);
        
        // Bottom-right corner (Arc 80)
        translate([365, 5]) circle(r=5);
        
        // Top-right corner (Arc 7F)
        translate([365, 140]) circle(r=5);
        
        // Top-left corner (Arc 7E)
        translate([5, 140]) circle(r=5);
    }
}

module holes() {
    // Four circular cuts located near the top edge
    // All holes have a radius of 1.75mm (Diameter 3.5mm)
    
    // Hole 1 (Circle 76)
    translate([15.0, 135.0]) circle(r=1.75);
    
    // Hole 2 (Circle 73)
    translate([128.3333333333, 135.0]) circle(r=1.75);
    
    // Hole 3 (Circle 75)
    translate([241.6666666667, 135.0]) circle(r=1.75);
    
    // Hole 4 (Circle 74)
    translate([355.0, 135.0]) circle(r=1.75);
}

module foot_plate_2d() {
    // Subtract internal holes from the outer profile
    difference() {
        outer_profile();
        holes();
    }
}

// Extrude the finished 2D profile to the specified 2mm thickness
linear_extrude(height = thickness) {
    foot_plate_2d();
}