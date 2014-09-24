//This is half of the encoder wheel for the extruder. It holds one o-ring and screws together with the magnet pin and other half, with a bearing in the center.

$fn=100;

use <wormtownwheelpin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/ORing_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/Filament_Vitamin.scad>

module wormtownwheel(3dPrinterTolerance){
	difference(){
		union(){
			cylinder(r=ORinnerdiam()/2+ORdiam()+2-3dPrinterTolerance,h=ORdiam()/2);
			cylinder(r=ORinnerdiam()/2-ORdiam()/2+5, h=ORdiam()*1.5);
		}
		translate([0,0,ORdiam()/2]){
			ORing();
		}
		for(i=[0:3]){
			rotate(i*360/4,[0,0,1]){
				translate([608BallBearingDiam(.4)-ORdiam(),0,HiLoScrewLength(.4)]){
					#HiLoScrew();
				}
			}
		}
		cylinder(r=608BallBearingInnerDiam(.4),h=pinheight(.4));
	}
}
difference(){
	union(){
	wormtownwheel(.4);
		translate([0,0,ORdiam()/2+ORdiam()*1.5+ORdiam()+1]){
			rotate([0,180,0]){
				wormtownwheel(.4);
			}
		}
	}
	cube([100,100,20]);
}