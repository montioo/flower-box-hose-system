//
//  HoseSplitter_Y-Shape.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

include <Parameters.scad>
use <HoseConnector.scad>

$fn = 100;


// End cap to stop water leaving a hose. This is useful when a hose with a lot
// of tiny holes is used to water plants with little droplets only.
// @param hose_type: Type of hose. Look at Parameters.scad for details.
module EndCap(hose_type) {
    HoseConnector(hose_type);
    translate([0, 0, -1]) cylinder(h=1, d=hc_pipe_outer_dia[hose_type]);
    translate([0, 0, -2]) cylinder(h=1, d=1.4*hc_pipe_outer_dia[hose_type]);
    cylinder(h=4, d=hc_pipe_inner_dia[hose_type]);
}


// End cap for a 4mm hose.
EndCap(0);
