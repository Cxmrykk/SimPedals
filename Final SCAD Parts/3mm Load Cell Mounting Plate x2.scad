/*
 * 3mm Load Cell Mounting Plate
 * Modified to support 3D printing natively by folding tabs mathematically.
 * Internal bevels/fillets have been completely removed to ensure the load 
 * cell can seat perfectly flush against the inside walls and bolt holes.
 */

module load_cell_mounting_plate_2d() {
    difference() {
        polygon(points = [
            [0, 38], [0, 0], [5, 0], [5, -3], [15, -3], [15, 0], 
            [20, 0], [20, 38], [15, 38], [15, 41], [5, 41], [5, 38]
        ]);
        
        translate([10, 11.5]) circle(r = 2.75, $fn = 64);
        translate([10, 26.5]) circle(r = 2.75, $fn = 64);
    }
}

module load_cell_mounting_plate(thickness = 3) {
    // Center Piece
    linear_extrude(height = thickness, convexity = 4)
        intersection() {
            load_cell_mounting_plate_2d();
            translate([-100, 0]) square([200, 38]);
        }
        
    // Bottom Tab (Y < 0) - folded up 90 deg
    translate([0, -thickness, 0])
        rotate([-90, 0, 0])
            linear_extrude(height = thickness, convexity = 4)
                intersection() {
                    load_cell_mounting_plate_2d();
                    translate([-100, -100]) square([200, 100]);
                }
                
    // Top Tab (Y > 38) - folded up 90 deg
    translate([0, 38 + thickness, 0])
        rotate([90, 0, 0])
            translate([0, -38, 0])
                linear_extrude(height = thickness, convexity = 4)
                    intersection() {
                        load_cell_mounting_plate_2d();
                        translate([-100, 38]) square([200, 100]);
                    }
}

load_cell_mounting_plate(thickness = 3);