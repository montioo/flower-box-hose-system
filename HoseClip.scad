//
//  HoseClip.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

$fn = 100;


// A tip or spike to stick into soil. Coordinate origin is the top part.
// @param overhang: How far the spike should extend over the coordinate origin.
// @param stick_dia: Diameter of the stick.
module Spike(overhang=20, stick_dia=12) {
    bar_thickness = 2.5;
    spire_length = 20;
    stick_length = 80;

    difference() {
        for (i = [0, 1]) {
            rotate([i*90, 0, 0]) translate([-overhang, -bar_thickness/2, -stick_dia/2])
                cube([stick_length+overhang, bar_thickness, stick_dia]);
        }

        t = 1;  // parameter for polygon generation
        for (i = [0 : 3]) {
            rotate([i*90, 0, 0]) translate([stick_length, 0, stick_dia/2])
                rotate([90, 180, 0]) translate([0, 0, -bar_thickness/2 - 0.01])
                linear_extrude(height=bar_thickness+0.02)
                polygon([[-t, -t], [-t, stick_dia/2], [0, stick_dia/2], [spire_length, 0], [spire_length, -t]]);
        }
    }
}

// Models a hose clip
// @param head_width: Width of the upper part that clips to the hose.
// @param inner_diameter: inner diameters of the clip. Should be a bit less than the hose's diameter.
module HoseClip(head_width, inner_diameter) {
    outer_diameter = max(12, inner_diameter + 2*3);
    holder_opening = inner_diameter * 0.8;

    difference() {
        union() {
            Spike(overhang=outer_diameter/2, stick_dia=head_width);
            translate([-outer_diameter/2, head_width/2, 0]) rotate([90, 0, 0]) cylinder(h=head_width, d=outer_diameter);
        }

        translate([-outer_diameter/2, head_width/2, 0]) rotate([90, 0, 0]) {
            translate([0, 0, -1]) cylinder(h=head_width + 2, d=inner_diameter);

            rotate([0, 0, 20]) translate([-holder_opening/2, 0, -1]) cube([holder_opening, outer_diameter, head_width + 2]);
        }
    }
}

// Parameterization for a 8mm x 1.5mm hose => 11mm diameter
module HoseClip8mm() {
    head_width = 12;
    inner_diameter = 10.8;  // hose has an outer diameter of 11mm
    
    HoseClip(head_width=head_width, inner_diameter=inner_diameter);
}

// Parameterization for a 4mm x 1mm hose => 6mm diameter
module HoseClip4mm() {
    head_width = 12;
    inner_diameter = 5.8;
    
    HoseClip(head_width=head_width, inner_diameter=inner_diameter);
}

// Custom clip
// module HoseClipXmm(hose_type=0) {
//     Add the diameter of your hose here:
//     hose_outer_diameter = ...;
//     head_width = 12;
//     inner_diameter = hose_outer_diameter - 0.2;
//     
//     HoseClip(head_width=head_width, inner_diameter=inner_diameter);
// }


HoseClip4mm();
