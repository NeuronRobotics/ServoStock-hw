function getThickness() = 18;
use <../Axis/StructuralFeet.scad>
use <../Axis/Parameters.scad>
use <../Axis/RodEndClips.scad>	
use <../Axis/Clips.scad>	




//circle(getBaseRadius());
for (a = [0:120:359]){
	rotate([0,0,a])
		translate([0,-getBaseRadius(),0]){
			//import (file = "FeetOutline.dxf", origin = 0);
			getStructuralFeetInterface();
		}
				
}
//getStructuralFeetInterface();