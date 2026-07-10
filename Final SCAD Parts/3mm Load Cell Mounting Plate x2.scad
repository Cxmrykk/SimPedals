/*
 * 3mm Load Cell Mounting Plate
 * 
 * Reconstructed from DXF entities.
 * The outer profile is generated as a continuous polygon based on the 
 * provided line segments, and the internal mounting holes are subtracted 
 * before extruding to the specified 3mm material thickness.
 */

// Module definition for the mounting plate
module load_cell_mounting_plate(thickness = 3) {
    // Extrude the final 2D shape to the specified thickness
    linear_extrude(height = thickness, convexity = 4) {
        difference() {
            // Outer Profile Polygon
            // Traced sequentially from the DXF line segments
            polygon(points = [
                [0, 38],    // Top-left inner corner
                [0, 0],     // Bottom-left inner corner
                [5, 0],     // Bottom-left inner jog
                [5, -3],    // Bottom-left outer tab corner
                [15, -3],   // Bottom-right outer tab corner
                [15, 0],    // Bottom-right inner jog
                [20, 0],    // Bottom-right inner corner
                [20, 38],   // Top-right inner corner
                [15, 38],   // Top-right inner jog
                [15, 41],   // Top-right outer tab corner
                [5, 41],    // Top-left outer tab corner
                [5, 38]     // Top-left inner jog
            ]);
            
            // Internal Holes
            // Hole 1 (Handle 6E)
            translate([10, 11.5]) 
                circle(r = 2.75, $fn = 64);
                
            // Hole 2 (Handle 6F)
            translate([10, 26.5]) 
                circle(r = 2.75, $fn = 64);
        }
    }
}

// Render a single instance of the part
load_cell_mounting_plate(thickness = 3);