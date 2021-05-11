
![Overview Image](images/hose-parts-overview.png)

# flower-box-hose-system

A set of 3D printable sprinklers and hose connectors to build an automatic watering system for flower boxes, e.g. on your balcony.

This project is licensed under the terms of the GNU General Public License v3.0.

Author: Marius Montebaur

## Print Settings

Detailed descriptions on how to adjust the print settings can be found [here](https://montebaur.tech/projects/waterproof_3d-printing.html).

Summary: To make the components waterproof adjustments to the print setting are necessary (parameter names from Cura)
- Infill density: `100%`
- Wall thickness: 4 lines
- Flow (or extrusion multiplier): `108%`. Tells the printer to use more filament than necessary to close gaps between neighboring filament lines.
  - If your slicer is capable of setting different values for the flow used for the object and the support material, stick with 100% flow for the support material. Otherwise, removing the support will be more difficult.
- Printing Temperature: `215°C`. A bit hotter than usual to make the filament flow better.
- Try to orient the objects on the print bet such that the water flow direction is along the z axis ([explanation](https://montebaur.tech/projects/waterproof_3d-printing.html#object-orientation)).

## Changelog

### 2021-05-11:
- Added hose end cap.
- New wall connector that allows mounting a hose extender on a wall, e.g. of a plastic enclosure containing magnetic valves.

![New wall connector](images/wall-con_end-cap.png)

### 2021-05-09:
- Added parameters for hoses with 6mm inner diameter (`Parameters.scad`)
- Updated box shaped splitter (`HoseSplitter_BoxShape.scad`) to accept different inlet and outlet diameters and added numbers on the housing.

![New box shaped connectors with labels for inner hose diameters.](images/hose-splitter-label.png)
