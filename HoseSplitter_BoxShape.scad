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
module ThreePortBox(hose_type_inlet=0, hose_type_outlet=0, port_length=12, outlet_spacing=10) {
    // Creates a water intersection in arbitrary angles

    // [ [rotation, offset, hose_type], ... ]
    ports = [
        [0, 0, hose_type_inlet],
        [180, -outlet_spacing/2, hose_type_outlet],
        [180, outlet_spacing/2, hose_type_outlet]
    ];

    max_outer_dia = max( hc_pipe_outer_dia[hose_type_inlet], hc_pipe_outer_dia[hose_type_outlet] );
    max_inner_dia = max( hc_pipe_inner_dia[hose_type_inlet], hc_pipe_inner_dia[hose_type_outlet] );
    cube_wall = max_outer_dia * 1.5;

    difference() {

        // unify hose connectors, box and tubes
        union() {
            for (port = ports) {
                rotation = port[0];
                offset = port[1];
                hose_type = port[2];
                outer_dia = hc_pipe_outer_dia[hose_type];

                rotate([-90, 0, rotation]) {
                    translate([offset, 0, port_length]) HoseConnector(hose_type);
                    translate([offset, 0, cube_wall/2-0.02]) cylinder(h=port_length - cube_wall/2 + 0.02, d1=cube_wall, d2=outer_dia);
                }
            }

            cube([outlet_spacing + cube_wall, cube_wall, cube_wall], center=true);
        }

        // cylinders and spheres are used to make room for the water
        for (port = ports) {
            rotation = port[0];
            offset = port[1];
            hose_type = port[2];
            inner_dia = hc_pipe_inner_dia[hose_type];

            rotate([-90, 0, rotation]) translate([offset, 0, -0.01]) cylinder(h=port_length+0.02, d1=max_inner_dia, d2=inner_dia);
            translate([offset, 0, -0.01]) sphere(d=max_inner_dia);
        }

        rotate([-90, 0, 90]) translate([0, 0, -0.01 - outlet_spacing/2]) cylinder(h=outlet_spacing+0.02, d=max_inner_dia);
    }

    inlet_type = hc_pipe_outer_dia[hose_type_inlet];
    outlet_type = hc_pipe_outer_dia[hose_type_outlet];
    translate([0, 0, cube_wall/2]) scale([0.8, 0.8, 1])
        color("lightblue")
        linear_extrude(0.8)
        text(str(outlet_type, "-", inlet_type, "-", outlet_type), valign="center", halign="center", size=cube_wall, spacing=0.9);
}


// Three port connector for 8mm inner diameter tubes
difference() {
    ThreePortBox(2, 1, outlet_spacing=20, port_length=8);
    // Uncomment this line to see the complete component.
    // translate([-40, -40, 0]) cube([80, 80, 40]);
}

// Three port connector for 4mm inner diameter tubes
// difference() {
//     ThreePortBox(0, 0, outlet_spacing=12, port_length=6);
//     // translate([-40, -40, 0]) cube([80, 80, 40]);
// }
