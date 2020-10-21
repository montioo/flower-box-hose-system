//
//  SprinklerRing.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

include <Parameters.scad>
use <HoseConnector.scad>

// set this to a lower value (e.g. 30) while editing.
$fn = 100;


// Creates a watering ring that can be placed at the foot of a plant
// @param hose_type: Type of hose to use for all connectors. See Parameters.scad for more info.
// @param watering_ring_inner_radius: The inner radius of the whole ring.
module WateringRing(hose_type=0, watering_ring_inner_radius=50/2) {
    
    ring_angle = 225;  // angular size of the ring
    port_length = 4;  // additional length of the hose connector
    hole_count = 6;  // number of sprinkler holes
    hole_angle = 40;  // angular offset of the holes
    hole_dia = 1;  // diameter of the sprinkler holes

    outer_diameter = hc_pipe_outer_dia[hose_type] * 2.0;
    inner_diameter = hc_pipe_inner_dia[hose_type] * 1.2;
    ending_angle = -(ring_angle-180)/2;  // part of the ring that is open

    difference() {
        union() {
            translate([0, -watering_ring_inner_radius - outer_diameter, 0]) {
                rotate([0, 0, ending_angle]) rotate_extrude(angle=ring_angle) translate([watering_ring_inner_radius + outer_diameter/2 , 0, 0]) circle(d=outer_diameter);
                for (i = [-1, 1]) {
                    rotate([0, 0, i * ending_angle]) translate([i * (watering_ring_inner_radius + outer_diameter/2), 0, 0]) sphere(d=outer_diameter);
                }
                
            }
            rotate([-90, 0, 0]) union() {
                translate([0, 0, -outer_diameter/2]) cylinder(d1=outer_diameter, d2=hc_pipe_outer_dia[hose_type], h=port_length + outer_diameter/2);
                translate([0, 0, port_length]) HoseConnector(hose_type);
            }
        }
        translate([0, -watering_ring_inner_radius - outer_diameter, 0]) {
            rotate([0, 0, ending_angle]) rotate_extrude(angle=ring_angle) translate([watering_ring_inner_radius + outer_diameter/2 , 0, 0]) circle(d=inner_diameter);
            hole_angle_offset = ring_angle / (hole_count -1);
            for (i = [0 : hole_count-1]) {
                rotate([0, 0, ending_angle + i * hole_angle_offset]) translate([watering_ring_inner_radius + outer_diameter/2, 0, 0]) rotate([0, -hole_angle, 0]) cylinder(d=hole_dia, h=10);
            }
            for (i = [-1, 1]) {
                rotate([0, 0, i * ending_angle]) translate([i * (watering_ring_inner_radius + outer_diameter/2), 0, 0]) sphere(d=inner_diameter);
            }
        }
        rotate([-90, 0, 0]) translate([0, 0, -outer_diameter/2 - 0.01]) cylinder(d=hc_pipe_inner_dia[hose_type], h=0.02 + port_length + outer_diameter/2);
    }
}


// Watering ring with a difference applied to check that all pipes look as expected on the inside.
// difference() {
//     WateringRing();
//     translate([-120, -120, 0]) cube([240, 240, 40]);
// }

WateringRing();