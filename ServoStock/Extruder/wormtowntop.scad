//this is the top plate for the wormtown extruder.  It holds the brackets, and is connected to the bottom via four screws. It is meant to be laser cut (render -> export as dxf), but can be printed as well.

$fn=100;
use <../Axis/Parameters.scad>
use <wormtownbracket.scad>
use <wormtownwheel.scad>
use <wormtownbottom.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>


//function


module wormtowntop(3dPrinterTolerance){
	difference(){
		cube([bracketwidth()+wheelthickness(.4),wheelradius(.4)*2+PlasticWidth(),1]);
			translate([wheelthickness(.4),10,HiLoScrewHeadHeight()]){
				rotate([0,0,0]){
					#HiLoScrew(.4);
				}
			}
	
	}
}

wormtowntop(.4);

wormtownbracket(.4);