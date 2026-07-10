/* 
 * 3mm Angled Load Cell Bracket
 * Converted from DXF to OpenSCAD
 * 
 * The outer profile is traced continuously along the provided lines and arcs 
 * to guarantee a watertight, non-self-intersecting 2D polygon. This ensures 
 * that boolean operations (like hole subtraction) execute flawlessly.
 */

// General rendering resolution
$fn = 64;

// Material thickness specified in filename
thickness = 3.0;

/**
 * Helper function to generate an array of 2D points for an arc.
 * Handles both forward and backward arc traversal smoothly.
 */
function make_arc(cx, cy, r, a1, a2) = 
    let(
        steps = max(4, ceil($fn * abs(a2 - a1) / 360)),
        step_ang = (a2 - a1) / steps
    )
    [ for (i = [0 : steps]) [ cx + r * cos(a1 + i * step_ang), cy + r * sin(a1 + i * step_ang) ] ];

/**
 * Generates the 2D outer boundary polygon of the bracket.
 * The sequence traces the perimeter clockwise/counter-clockwise,
 * naturally forming straight connecting lines where endpoints differ.
 */
module bracket_profile() {
    points = concat(
        // Arc 148 (backward traversal)
        make_arc(3.0, 15.0865482874, 3.0, 232.0, 149.7698776489),
        
        // Arc 149 (backward traversal)
        make_arc(7.2865684576, 22.4427118760, 3.0, 149.7698776489, 59.7698776489),
        
        // Arc 14A (forward traversal)
        make_arc(21.1322087809, 21.3189711744, 3.0, 239.7698776489, 309.7698776489),
        
        // Top straight edge incorporating V-notches for folding relief
        [
            [24.2370935026, 20.0],
            [24.5722703804, 20.0],
            [25.5722703804, 19.0],
            [26.5722703804, 20.0],
            [64.8426241360, 20.0],
            [65.8426241360, 19.0],
            [66.8426241360, 20.0],
            [67.1778010138, 20.0]
        ],
        
        // Arc 143 (forward traversal)
        make_arc(70.2826857355, 21.3189711744, 3.0, 230.2301223511, 300.2301223511),
        
        // Arc 144 (backward traversal)
        make_arc(84.1283260588, 22.4427118760, 3.0, 120.2301223511, 30.2301223511),
        
        // Arc 145 (backward traversal crossing 0-degree mark, mapped to 390.23 deg)
        make_arc(88.4148945164, 15.0865482874, 3.0, 390.2301223511, 308.0),
        
        // Arc 146 (backward traversal)
        make_arc(70.5345248809, 10.0, 10.0, 308.0, 270.0),
        
        // Bottom straight edge incorporating V-notches for folding relief
        [
            [66.8426241360, 0.0],
            [65.8426241360, 1.0],
            [64.8426241360, 0.0],
            [26.5722703804, 0.0],
            [25.5722703804, 1.0],
            [24.5722703804, 0.0],
            [20.8803696355, 0.0]
        ],
        
        // Arc 147 (backward traversal)
        // Closing back onto the start of Arc 148 seamlessly.
        make_arc(20.8803696355, 10.0, 10.0, 270.0, 232.0)
    );
    
    polygon(points);
}

/**
 * Main module: Extrudes the profile and cleanly subtracts the holes.
 */
module bracket_3d() {
    linear_extrude(height = thickness, center = false, convexity = 4) {
        difference() {
            // Main Bracket Silhouette
            bracket_profile();
            
            // Mounting Holes
            translate([85.0191381936, 14.6171121125]) circle(r = 2.5);
            translate([ 6.3957563228, 14.6171121125]) circle(r = 2.5);
            translate([45.7074472582, 10.0000000000]) circle(r = 2.5);
        }
    }
}

// Instantiate the final 3D part
bracket_3d();