//this is the top plate for the wormtown extruder.  It holds the brackets, and is connected to the bottom via four screws. It is meant to be laser cut (render -> export as dxf), but can be printed as well.

$fn=100;
use <
use <wormtownbracket.scad>
use <wormtownwheel.scad>
use <wormtownbottom.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>


//function


module wormtowntop(3dPrinterTolerance){
	difference(){
		cube([bracketwidth(),wheelradius(.4)*2+PlasticWidth(),1]);






	}
}

wormtowntop(.4);