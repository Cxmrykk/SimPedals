// Metal Components/Steel Parts/3mm Pedal Base Plate Mirrored x3.scad
// Thickness: 3mm

$fn = 64; 

// We import/reuse the base plate module from above
use <3mm Pedal Base Plate x3.scad>

module 3mm_Pedal_Base_Plate_Mirrored() {
    // Mirroring across the X axis to create the opposing base plate,
    // then translating it to sit inside positive coordinates.
    translate([170, 0, 0]) mirror([1, 0, 0]) 3mm_Pedal_Base_Plate();
}

3mm_Pedal_Base_Plate_Mirrored();