//
//  SprinklerRing.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

include <Parameters.scad>
use <HoseConnector.scad>

$fn = 100;


// Creates a watering ring that can be placed at the foot of a plant
// @param hose_type: Type of hose to use for all connectors. See Parameters.scad for more info.
// @param pipe_length: Lenght of the part the has the holes in it.
module WateringBar(hose_type=0, pipe_length=50) {

    port_length = 4;  // additional length of the hose connector
    hole_count = 6;  // number of sprinkler holes
    hole_angle = 40;  // hole's angle from z axis
    hole_dia = 1;  // diameter of the sprinkler holes
    hole_spacing = pipe_length / hole_count;  // distance between two holes on the y axis

    outer_diameter = hc_pipe_outer_dia[hose_type] * 2.0;  // outer diameter of the pipe
    inner_diameter = hc_pipe_inner_dia[hose_type] * 1.2;  // inner diameter of the pipe

    difference() {
        union() {
            rotate([90, 0, 0]) cylinder(h=pipe_length, d=outer_diameter);
            translate([0, -pipe_length, 0]) sphere(d=outer_diameter);

            // hose connector
            rotate([-90, 0, 0]) union() {
                cylinder(d1=outer_diameter, d2=hc_pipe_outer_dia[hose_type], h=port_length);
                translate([0, 0, port_length]) HoseConnector(hose_type);
            }
        }

        rotate([90, 0, 0]) cylinder(h=pipe_length, d=inner_diameter);
        translate([0, port_length + 0.01, 0]) rotate([90, 0, 0]) cylinder(h=port_length + 0.02, d1=hc_pipe_inner_dia[hose_type], d2=inner_diameter);
        translate([0, -pipe_length, 0]) sphere(d=inner_diameter);

        // holes for water to exit
        for (i = [1 : hole_count]) {
            translate([0, -hole_spacing * (i - 0.5), 0]) rotate([0, -hole_angle * (2*(i % 2) - 1), 0]) cylinder(d=hole_dia, h=10);
        }

        // flattening the bottom
        translate([0, -pipe_length * 0.6, -1.7 * outer_diameter/2]) cube([outer_diameter, pipe_length * 1.4, outer_diameter], center=true);
    }
}


// Watering bar with a difference applied to check that all pipes look as expected on the inside.
// difference() {
//     WateringBar();
//     translate([-120, -120, 0]) cube([240, 240, 40]);
// }

WateringBar();
