//
//  HoseSplitter_BoxShape.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

include <Parameters.scad>
use <HoseConnector.scad>

$fn = 100;


// Models a box with three connectors that has a box as its center piece so that all 
//  connectors are parallel.
// @param hose_type: Type of hose to use for all connectors. See Parameters.scad for more info.
// @param port_length: Additional length of a port's tube.
// @param outlet_spacing: Spacing between the two outlets.
module ThreePortBox(hose_type=0, port_length=12, outlet_spacing=10) {
    // Creates a water intersection in arbitrary angles

    // [ [rotation, offset], ... ]
    ports = [[0, 0], [180, -outlet_spacing/2], [180, outlet_spacing/2]];

    inner_dia = hc_pipe_inner_dia[hose_type];
    outer_dia = hc_pipe_outer_dia[hose_type];

    offset_min = min( [ for (port = ports) port[1] ] );
    offset_max = max( [ for (port = ports) port[1] ] );

    difference() {
        union() {
            for (port = ports) {
                rotation = port[0];
                offset = port[1];

                rotate([-90, 0, rotation]) {
                    translate([offset, 0, port_length]) HoseConnector(hose_type);
                    translate([offset, 0, 0]) cylinder(h=port_length, d=outer_dia);
                }
            }

            cube_wall = outer_dia * 2;
            cube([offset_max - offset_min + cube_wall, cube_wall, cube_wall], center=true);
        }

        for (port = ports) {
            rotation = port[0];
            offset = port[1];
            rotate([-90, 0, rotation]) translate([offset, 0, -0.01]) cylinder(h=port_length+0.02, d=inner_dia);
            translate([offset, 0, -0.01]) sphere(d=inner_dia);
        }

        rotate([-90, 0, 90]) translate([0, 0, -0.01 + offset_min]) cylinder(h=outlet_spacing+0.02, d=inner_dia);
    }
}


// Three port connector for 8mm inner diameter tubes
difference() {
    ThreePortBox(1, outlet_spacing=20, port_length=12);
    translate([-40, -40, 0]) cube([80, 80, 40]);
}

// Three port connector for 4mm inner diameter tubes
// difference() {
//     ThreePortBox(0, outlet_spacing=12, port_length=6);
//     // translate([-40, -40, 0]) cube([80, 80, 40]);
// }
