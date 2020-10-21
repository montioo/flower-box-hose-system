//
//  HoseExtender.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

include <Parameters.scad>
use <HoseSplitter_Y-Shape.scad>

$fn = 100;


// Uses a water splitter (i.e.) a water intersection with arbitrary angles.
module ExtenderConnector() {
    MultiConnectorY(ports=[[0, 1], [180, 1]], middle_pipe_length=8, sphere_multiplier=1.2);
}

// Uses a water splitter (i.e.) a water intersection with arbitrary angles.
// Has differently sized hoses at either size and thus creates an adapter.
module AdapterConnector() {
    // Creates a water intersection in arbitrary angles
    MultiConnectorY(ports=[[0, 0], [180, 1]]);
}


AdapterConnector();

// ExtenderConnector();
