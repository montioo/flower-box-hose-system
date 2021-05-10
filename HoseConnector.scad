//
//  HoseConnector.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

include <Parameters.scad>

$fn = 100;


// Model of the connector that fits into a tube.
// @param hose_type: Defines the type of hose this connector should fit into.
//   A list of hose indices along with a detailed explanation is given in Parameters.scad
//   Default is hose_type with id 0 (hoses with 4mm inner diameter).
module HoseConnector(hose_type=0) {
    difference() {
        for (i = [0 : hc_tooth_number[hose_type]-1]) {
            translate([0, 0, i*hc_tooth_length[hose_type]]) cylinder(
                h=hc_tooth_length[hose_type],
                d1=hc_outer_dia_upper[hose_type],
                d2=hc_outer_dia_lower[hose_type]
            );
        }
        translate([0, 0, -0.01]) cylinder(
            h=hc_tooth_number[hose_type] * hc_tooth_length[hose_type] + 2 * 0.01,
            d=hc_pipe_inner_dia[hose_type]
        );
    }
}

// Example for a connector modeled after hose_type 0:
HoseConnector(0);
