//
//  HoseWallConnector.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

//
// NOTE:
// Make sure to also use more flow (108%) for printing the wall connector
// because it is also intended to be waterproof. However, due to the additional
// material, the holes you plan to use for screws become smaller. To counteract
// this, enlarge the diameter of the holes you would like to leave for screws.
//
// Example:
// If you would normally plan a hole for an M3 screw with a diameter of 3.3mm,
// make it 4mm when using more flow (i.e. greater extrusion multiplier).
//

include <Parameters.scad>
use <HoseConnector.scad>

$fn = 100;


// Creates the shape of a flat head screw.  Since this module is intended to be
// used as the difference, so that a hole for a screw is created, it is
// recommended to add ~0.3 to the diameter parameters measured from a real
// screw. The origin of the screw is the center of the point where body and head
// of the screw are connected.
// @param body_diameter: The diameter of the body (the threaded part) of the screw.
// @param body_height: Lenght of the screw, not including the head.
// @param head_diameter: Diameter of the screw's head.
// @param head_height: Height of the screw's head.
module ScrewHole(body_diameter, body_height, head_diameter, head_height) {
    translate([0, 0, -body_height]) {
        translate([0, 0, -1]) cylinder(d=body_diameter, h=body_height+2);
        translate([0, 0, body_height]) cylinder(d=head_diameter, h=head_height+1);
    }
}


// Creates a cube where four edges are rounded. In this file, it is used as the
// base shape of the part that is screwed against the wall.
// @param size: The size of the rounded cube, respresented as a tuple [height,
//   width, depth]. depth represents the axis along which the edges are rounded.
// @param corner_radius: Radius of the rounded corners.
// @param center: Whether or not the cube's origin is in its center. This type
//   of argument is known from the regular cube.
module RoundedCube(size, corner_radius, center=false) {
    module RoundedCorner(r, h) {
        difference() {
            cube([r+1, r+1, h]);
            translate([0, 0, h/2]) cylinder(r=r, h=h+2, center=true);
        }
    }
    width = size[0];
    height = size[1];
    thickness = size[2];
    x_off = center ? -width/2 : 0;
    y_off = center ? -height/2 : 0;
    z_off = center ? -thickness/2 : 0;
    translate([x_off, y_off, z_off]) difference() {
        cube(size);
        translate([corner_radius, corner_radius, -1]) rotate([0, 0, 180]) RoundedCorner(r=corner_radius, h=thickness+2);
        translate([width-corner_radius, corner_radius, -1]) rotate([0, 0, -90]) RoundedCorner(r=corner_radius, h=thickness+2);
        translate([corner_radius, height-corner_radius, -1]) rotate([0, 0, 90]) RoundedCorner(r=corner_radius, h=thickness+2);
        translate([width-corner_radius, height-corner_radius, -1]) rotate([0, 0, 0]) RoundedCorner(r=corner_radius, h=thickness+2);
    }
}


// This module creates a wall connector with two hose connectors and a washer.
// It is intended to be used with thin walls, e.g. from a plastic box that acts
// as a housing for some magnetic valves.
// The connector and the washer can be generated independently from each other.
// Two .stl files can be created to print them independenly.
//
// @param hose_type: Selects the type of hose to be used. See Parameters.scad
// @param wall_strength: The thickness of the wall on which the connector and
//   washer will be mounted.
// @param hole_dia: Diameter of the hole that you have to drill in the center.
// @param show_connector: Whether or not to show the connector.
// @param show_washer: Whether or not to show the washer.
// --> If show_connector and show_washer are both false, onlye a mask containing
//     the center locations of the holes that have to be drilled will be shown.
module WallConnector(hose_type, wall_strength, hole_dia, show_connector=true, show_washer=true) {

    face_depth = 4;  // thickness of the mounting part
    face_height = max(12, hole_dia + 2*3);
    face_width = 32;

    backplate_depth = 3;  // thickness of the washer

    corner_radius = 4;
    screw_diameter = 4;  // For M3 screw. Chose this a bit bigger, to compensate for greater material flow.
    screw_head_diameter = 6.5;

    tube_length = 1;  // distance from wall to beginn of the connector

    inner_ring_depth = wall_strength + backplate_depth;
    screw_hole_offset = hole_dia/2 + (32-hole_dia)/4;

    if (show_connector) {
        difference() {

            union() {
                rotate([0, 90, ]) {
                    translate([0, 0, face_depth+tube_length]) HoseConnector(hose_type);
                    cylinder(h=face_depth+tube_length, d=hc_pipe_outer_dia[hose_type]);
                }

                translate([face_depth/2, 0, 0]) rotate([0, 90, 0]) RoundedCube([face_height, face_width, face_depth], corner_radius, center=true);

                rotate([0, -90, ]) {
                    translate([0, 0, inner_ring_depth+tube_length]) HoseConnector(hose_type);
                    cylinder(h=inner_ring_depth+tube_length, d=hc_pipe_outer_dia[hose_type]);
                    cylinder(h=inner_ring_depth, d=hole_dia);
                }
            }

            translate([-20, 0, 0]) rotate([0, 90, 0]) cylinder(h=40, d=hc_pipe_inner_dia[hose_type]);

            for (side = [-1, 1]) {
                translate([3, side*screw_hole_offset, 0]) rotate([0, 90, 0]) ScrewHole(screw_diameter, inner_ring_depth, screw_head_diameter, 2);
            }
        }
    }

    if (show_washer) {
        translate([-inner_ring_depth, 0, 0]) difference() {
            translate([backplate_depth/2, 0, 0]) rotate([0, 90, 0]) RoundedCube([face_height, face_width, backplate_depth], corner_radius, center=true);

            translate([-20, 0, 0]) rotate([0, 90, 0]) cylinder(h=40, d=hole_dia*1.1);

            for (side = [-1, 1]) {
                translate([-1, side*screw_hole_offset, 0]) rotate([0, 90, 0]) cylinder(d=screw_diameter, h=face_depth+2);
            }
        }
    }

    // If neither the connector nor the washer are shown, create markins for where to drill the needed holes.
    if (!show_washer && !show_connector) {
        mask_depth = 1;  // depth of the drill mask
        drill_hole_dia = 1.4;  // diameter of the hole markings

        translate([-mask_depth/2, 0, 0]) {
            rotate([0, 90, 0]) cylinder(h=mask_depth, d=drill_hole_dia);

            for (side = [-1, 1]) {
                translate([0, side*screw_hole_offset, 0]) rotate([0, 90, 0]) cylinder(d=drill_hole_dia, h=mask_depth);
            }
        }
    }
}


difference() {
    // Connector and washer for a 6mm hose, 1.5mm wall in which a hole of 12mm diameter has to be drilled.
    WallConnector(1, 1.5, 11.7, show_washer=true, show_connector=true);
    // Uncomment to inspect the cross section of the component.
    // translate([-30, 0, -10]) cube([60, 20, 20]);
}

// Exemplary wall.
// color("#80808060") translate([-0.75, 0, 0]) cube([1, 40, 40], center=true);
