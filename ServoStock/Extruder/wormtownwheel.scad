//This is half of the encoder wheel for the extruder. It holds one o-ring and screws together with the magnet pin and other half, with a bearing in the center.  Always call it with the printer tolerance!

$fn=100;

use <wormtownwheelpin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/ORing_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/Filament_Vitamin.scad>

function wheelthickness(3dPrinterTolerance)=(2*ORdiam()+3dPrinterTolerance+4.8);//this is the approximate thickness of both halves of the wheel put together, including the space for the o-ring.
echo(wheelthickness(.4));

module wormtownwheel(countersink,3dPrinterTolerance){
	difference(){
		union(){
			translate([0,0,0]){
				cylinder(r=ORinnerdiam()/2+ORdiam()+2-3dPrinterTolerance,h=ORdiam()/2+2);//outer cylinder.
			}
			cylinder(r=ORinnerdiam()/2-ORdiam()/2+5, h=ORdiam()+3dPrinterTolerance+2);//upper cylinder to mate with other half.
		}
		translate([0,0,ORdiam()/2+3dPrinterTolerance*2+2]){
			ORing();//o-ring subtraction.
		}
		if(countersink==true){
			for(i=[0:3]){
				rotate(i*360/4,[0,0,1]){
					translate([608BallBearingDiam(.4)-ORdiam()/1.5,0,HiLoScrewHeadHeight(.4)]){
						rotate([0,180,0]){
							HiLoScrew();//screw subtraction.
						}
					}
				}
			}
		}
		else {
			for(i=[0:3]){
			rotate(i*360/4,[0,0,1]){
				translate([608BallBearingDiam(.4)-ORdiam()/1.5,0,HiLoScrewHeadHeight()*2+2.1]){
					HiLoScrew();
				}
			}
		}
		}
		translate([0,0,-1]){
			wormpin();//pinhole subtraction.
		}
	}
}

module wheelprintbed(){	
	wormtownwheel(true,.4);
	translate([ORinnerdiam()+15,0,0]){
		rotate([0,0,0]){
			wormtownwheel(false,.4);//mating wheel for construction
		}
	}
}
wheelprintbed();
//wormtownwheel(true,.4);