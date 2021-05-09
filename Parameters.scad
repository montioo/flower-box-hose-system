//
//  Parameters.scad
//  flower-box-hose-system
//
//  Author: Marius Montebaur
//  montebaur.tech, github.com/montioo
//

//
// Parameterization for Hose Connectors.
//
// This file holds the measures that are employed by all adapters.
// Additional information is available here:
//  https://montebaur.tech/hose_connectors.html


// Parameters for 8mm x 1.5mm hoses
// (8mm inner diameter and the wall strength: 8mm + 2*1.5mm = 11mm diameter)
// ===============================================

// inner and outer diameter refer to the 3D printed connectors, NOT the hose.
hc8mm_pipe_inner_dia = 5.4;
hc8mm_pipe_outer_dia = 8;
hc8mm_outer_dia_lower = 7.75;
hc8mm_outer_dia_upper = 9;
hc8mm_tooth_length = 4.3;
hc8mm_tooth_number = 4;


// Parameters for 6mm x 1mm
// ===============================================

// inner and outer diameter refer to the 3D printed connectors, NOT the hose.
hc6mm_pipe_inner_dia = 4;
hc6mm_pipe_outer_dia = 6;
hc6mm_outer_dia_lower = 6;
hc6mm_outer_dia_upper = 6.9;
hc6mm_tooth_length = 4;
hc6mm_tooth_number = 4;


// Parameters for 4mm x 1mm
// ===============================================

// inner and outer diameter refer to the 3D printed connectors, NOT the hose.
hc4mm_pipe_inner_dia = 2.4;
hc4mm_pipe_outer_dia = 4;
hc4mm_outer_dia_lower = 4;
hc4mm_outer_dia_upper = 4.5;
hc4mm_tooth_length = 3;
hc4mm_tooth_number = 4;


// Your custom parameters ...
// 1. Add your parameterization instead of dots (...)
// 2. Add the variables to the lists below
// 3. Index your parameters by index 2 in each list (the lists
//    are imported in file in this project).
// A schematic for the parameters can be found here:
//   https://montebaur.tech/projects/hose_connectors.html#parameterization
// ===============================================

// hcXmm_pipe_inner_dia = ...;
// hcXmm_pipe_outer_dia = ...;
// hcXmm_outer_dia_lower = ...;
// hcXmm_outer_dia_upper = ...;
// hcXmm_tooth_length = ...;
// hcXmm_tooth_number = ...;


// These variables are available throughout the project (after using
// `include <Parameters.scad>`) and hold parameterizations for hoses
// with different diameters.
// A schematic for the parameters can be found here:
//   https://montebaur.tech/projects/hose_connectors.html#parameterization
hc_pipe_inner_dia =  [hc4mm_pipe_inner_dia,  hc6mm_pipe_inner_dia,  hc8mm_pipe_inner_dia  ];  // a
hc_pipe_outer_dia =  [hc4mm_pipe_outer_dia,  hc6mm_pipe_outer_dia,  hc8mm_pipe_outer_dia  ];  // b
hc_outer_dia_lower = [hc4mm_outer_dia_lower, hc6mm_outer_dia_lower, hc8mm_outer_dia_lower ];  // c
hc_outer_dia_upper = [hc4mm_outer_dia_upper, hc6mm_outer_dia_upper, hc8mm_outer_dia_upper ];  // d
hc_tooth_length =    [hc4mm_tooth_length,    hc6mm_tooth_length,    hc8mm_tooth_length    ];  // e
hc_tooth_number =    [hc4mm_tooth_number,    hc6mm_tooth_number,    hc8mm_tooth_number    ];  // #teeth
