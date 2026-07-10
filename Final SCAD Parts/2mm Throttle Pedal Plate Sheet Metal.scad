// Title: 2mm Throttle Pedal Plate Sheet Metal
// Converted from DXF to OpenSCAD
// Thickness: 2.0 mm

thickness = 2.0;
tolerance = 0.05;
arc_resolution = 24; // Steps for arc discretization

// ---- Helper Functions ----

// Finds the maximum value in a list
function list_max(l, i=0, m=-1e9) = 
    i >= len(l) ? m : list_max(l, i+1, l[i] > m ? l[i] : m);

// Finds the minimum value in a list
function list_min(l, i=0, m=1e9) = 
    i >= len(l) ? m : list_min(l, i+1, l[i] < m ? l[i] : m);

// Calculates the bounding box area of a 2D loop
function bbox_area(loop) =
    let( xs = [for(p=loop) p[0]], ys = [for(p=loop) p[1]] )
    (list_max(xs) - list_min(xs)) * (list_max(ys) - list_min(ys));

// Finds the index of the largest loop (outer profile)
function find_outer_idx(loops, i=0, max_area=-1, max_idx=-1) =
    i >= len(loops) ? max_idx :
    let( a = bbox_area(loops[i]) )
    find_outer_idx(loops, i+1, a > max_area ? a : max_area, a > max_area ? i : max_idx);

// Generates points for an arc, maintaining CCW direction
function arc_pts(cx, cy, r, start_ang, end_ang, steps=arc_resolution) =
    let( e = end_ang < start_ang ? end_ang + 360 : end_ang )
    [ for(i=[0:steps])
        let( a = start_ang + i*(e - start_ang)/steps )
        [ cx + r*cos(a), cy + r*sin(a) ]
    ];

// Reverses the order of points in a path
function reverse(l) = [for (i = [len(l)-1 : -1 : 0]) l[i]];

// Tries to merge two paths if their endpoints are within tolerance
function try_merge(p1, p2, tol=tolerance) =
    norm(p1[len(p1)-1] - p2[0]) < tol ? 
        concat(p1, [for(i=[1:len(p2)-1]) p2[i]]) :
    norm(p1[len(p1)-1] - p2[len(p2)-1]) < tol ? 
        try_merge(p1, reverse(p2), tol) :
    norm(p1[0] - p2[len(p2)-1]) < tol ? 
        try_merge(p2, p1, tol) :
    norm(p1[0] - p2[0]) < tol ? 
        try_merge(reverse(p1), p2, tol) :
    undef;

// Finds a compatible path to merge within a list of paths
function find_merge(p, paths, idx=0) =
    idx >= len(paths) ? -1 :
    (try_merge(paths[idx], p) != undef) ? idx :
    find_merge(p, paths, idx+1);

// Performs a single pass through the paths to stitch them together
function merge_pass(paths, i=0, out=[]) =
    i >= len(paths) ? out :
    let(
        p = paths[i],
        m_idx = find_merge(p, out)
    )
    m_idx != -1 ?
        // Replace merged path
        merge_pass(paths, i+1, [for(j=[0:len(out)-1]) j==m_idx ? try_merge(out[m_idx], p) : out[j]])
    :
        // Append unmerged path
        merge_pass(paths, i+1, concat(out, [p]));

// Repeatedly merges paths until no more fusions are possible (fully assembled loops)
function fully_merge(paths) =
    let( merged = merge_pass(paths) )
    len(merged) == len(paths) ? merged : fully_merge(merged);

// Removes duplicate closing vertices for a neat polygon
function clean_loop(p, tol=tolerance) =
    norm(p[0] - p[len(p)-1]) < tol ? 
        [for(i=[0:len(p)-2]) p[i]] : p;

// ---- DXF Geometry Extraction ----

all_segments = [
    // --- LWPOLYLINEs ---
    [[42.3468, -30.2444], [42.8338, -31.0221], [42.9981, -31.9107]],
    [[34.2012, -28.5715], [33.7163, -27.7945], [33.5494, -26.9108]],
    [[42.3468, 47.4076], [42.8399, 46.6027], [42.9955, 45.6774]],
    [[7.6531, 60.0413], [7.1546, 60.8629], [7.0080, 61.8147]],
    [[42.3468, 31.8085], [42.8342, 31.0243], [42.9979, 30.1291]],
    [[13.3519, 23.3085], [12.8667, 24.0809], [12.7002, 24.9612]],
    [[21.7987, 21.3087], [22.2821, 20.5380], [22.4509, 19.6626]],
    [[29.8468, -33.2410], [30.3349, -34.0225], [30.4977, -34.9168]],
    [[13.6531, -23.5021], [13.1701, -22.7315], [13.0008, -21.8574]],
    [[42.3468, -14.7763], [42.8277, -15.5346], [42.9995, -16.3940]],
    [[13.6531, 7.5450], [13.1739, 8.2977], [13.0002, 9.1488]],
    [[34.2012, 2.5115], [33.7240, 3.2582], [33.5481, 4.1001]],
    [[21.7987, -9.7420], [22.2777, -10.4942], [22.4516, -11.3442]],
    [[13.6531, -7.9486], [13.1759, -7.1977], [13.0000, -6.3518]],
    [[42.3468, 63.0543], [42.8456, 62.2278], [42.9921, 61.2708]],
    [[7.6531, 44.4981], [7.1601, 45.2983], [7.0045, 46.2192]],
    [[42.3468, 16.2414], [42.8283, 15.4769], [42.9994, 14.6108]],

    // --- LINEs ---
    [[37.3550, -25.2606], [42.3468, -30.2444]],
    [[39.1930, -33.5871], [34.2012, -28.5715]],
    [[39.1930, 43.9576], [7.6531, 75.6440]],
    [[10.8069, 79.3128], [42.3468, 47.4076]],
    [[39.1930, 28.4597], [7.6531, 60.0413]],
    [[10.8069, 63.6003], [42.3468, 31.8085]],
    [[18.6449, 18.0262], [13.3519, 23.3085]],
    [[16.5057, 26.6243], [21.7987, 21.3087]],
    [[16.8069, -20.2230], [29.8468, -33.2410]],
    [[26.6930, -36.6029], [13.6531, -23.5021]],
    [[39.1930, -18.0215], [22.5911, -1.3668]],
    [[28.8988, -1.3668], [42.3468, -14.7763]],
    [[16.8069, 10.7624], [28.8988, -1.3668]],
    [[22.5911, -1.3668], [13.6531, 7.5450]],
    [[39.1930, -2.4719], [38.0911, -1.3668]],
    [[42.9488, -1.3668], [42.9244, -1.4667]],
    [[42.9884, -1.1155], [42.9488, -1.3668]],
    [[37.3550, 5.6982], [42.3468, 0.6913]],
    [[38.0911, -1.3668], [34.2012, 2.5115]],
    [[16.8069, -4.7648], [21.7987, -9.7420]],
    [[18.6449, -12.9562], [13.6531, -7.9486]],
    [[39.1930, 59.4990], [23.0071, 75.7914]],
    [[26.1609, 79.4612], [42.3468, 63.0543]],
    [[39.1930, 12.9903], [7.6531, 44.4981]],
    [[10.8069, 47.9517], [42.3468, 16.2414]],
    [[50.0, -36.0214], [50.0, 78.6899]],
    [[14.0, -44.0458], [42.0, -44.0458]],
    [[6.0, 21.6487], [6.0, -36.0214]],
    [[2.3380, 28.6477], [3.6614, 27.3180]],
    [[0.0, 78.6899], [0.0, 34.3165]],
    [[42.0, 86.7142], [8.0, 86.7142]],

    // --- ARCs ---
    arc_pts(40.7802, -32.0331, 2.2213, 224.3946, 3.1582),
    arc_pts(35.7698, -26.8183, 2.2223, 44.4977, 182.3863),
    arc_pts(9.2114, 77.7704, 2.2191, 44.0303, 187.7216),
    arc_pts(9.3475, 77.2642, 2.3443, 174.9089, 223.7169),
    arc_pts(40.7845, 45.5023, 2.2179, 224.1453, 4.5287),
    arc_pts(9.2129, 62.0578, 2.2182, 44.0583, 186.2914),
    arc_pts(40.7839, 30.0046, 2.2175, 224.1582, 3.2186),
    arc_pts(14.9191, 25.0695, 2.2215, 44.4197, 182.7935),
    arc_pts(20.2299, 19.5840, 2.2224, 224.5029, 2.0248),
    arc_pts(28.2803, -35.0489, 2.2213, 224.3929, 3.4081),
    arc_pts(15.2218, -21.7807, 2.2223, 44.4996, 181.9784),
    arc_pts(40.7794, -16.4667, 2.2212, 224.4219, 1.8768),
    arc_pts(15.2205, 9.2078, 2.2211, 44.4211, 181.5214),
    arc_pts(40.7744, -0.9139, 2.2199, 224.5728, 345.5805),
    arc_pts(40.6755, -0.9195, 2.3212, 355.1558, 43.9463),
    arc_pts(35.7687, 4.1437, 2.2210, 44.4189, 181.1258),
    arc_pts(20.2312, -11.4016, 2.2211, 224.4209, 1.4790),
    arc_pts(15.2220, -6.3225, 2.2222, 44.5027, 180.7578),
    arc_pts(24.5654, 77.9188, 2.2191, 44.0301, 187.7354),
    arc_pts(24.7018, 77.4116, 2.3446, 174.8988, 223.7142),
    arc_pts(40.7856, 61.0432, 2.2182, 224.1149, 5.8899),
    arc_pts(9.2138, 46.4093, 2.2174, 44.0728, 184.9190),
    arc_pts(40.7780, 14.5481, 2.2223, 224.5043, 1.6160),
    arc_pts(42.0070, 78.7212, 7.9929, 359.7752, 90.0506),
    arc_pts(42.0069, -36.0527, 7.9930, 269.9500, 0.2240),
    arc_pts(13.9929, -36.0528, 7.9929, 179.7752, 270.0506),
    arc_pts(-2.4275, 21.4894, 8.4290, 1.0829, 43.7481),
    arc_pts(8.2691, 34.4105, 8.2697, 180.6510, 224.1756),
    arc_pts(7.9930, 78.7211, 7.9930, 89.9500, 180.2240)
];

// ---- Main Module Generator ----

module throttle_pedal_plate() {
    // Reconstruct all perfectly closed topological loops dynamically
    loops = fully_merge(all_segments);
    
    // Auto-detect the loop index representing the outer profile hull
    outer_idx = find_outer_idx(loops);
    
    linear_extrude(height = thickness) {
        difference() {
            // 1. Draw solid outer base profile
            polygon(clean_loop(loops[outer_idx]));
            
            // 2. Subtract isolated inner cutouts / grip slots
            for(i = [0 : len(loops) - 1]) {
                if (i != outer_idx) {
                    polygon(clean_loop(loops[i]));
                }
            }
            
            // 3. Subtract standalone circular mounting holes
            translate([28.0226, -19.1871]) circle(r=2.25, $fn=48);
            translate([28.0228, 11.9121]) circle(r=2.25, $fn=48);
        }
    }
}

// Render the design
throttle_pedal_plate();