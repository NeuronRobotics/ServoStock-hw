//this is the bracket for the extruder wheel.  It holds the bearing and encoder, and mounts to the top plate.

$fn=100;

use <../Axis/Parameters.scad>
use <../Axis/StructuralFeet.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Sensors/Encoders/Encoder_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/ORing_Vitamin.scad>
use <wormtownwheel.scad>
use <wormtownwheelpin.scad>


//function
//function
//function

module encodermount(){
	union(){
		translate([PlasticWidth()*2,EncoderMountWidth()/2-1,wheelradius(.4)+1]){
			rotate([90,180,270]){
				Encoder_Keepaway(true,.8);
			}
		}
		translate([PlasticWidth()*3+608BallBearingHeight(.4),EncoderMountWidth()/2,wheelradius(.4)]){
			rotate([0,180,0]){
				BearingCutout();
			}
		}	
	}
}

module wormtownbracket(encoder=true,3dPrinterTolerance){
	difference(){
		union(){
			cube([PlasticWidth()*3, EncoderMountWidth(), wheelradius(.4)+PlasticWidth()*3]);
			translate([0,-(EncoderMountWidth()-wheelradius(.4))-1,0]){
				cube([PlasticWidth()*3+608BallBearingHeight(.4)-.1,wheelradius(.4)*2,PlasticWidth()*2]);
			}
			translate([PlasticWidth()*3,0,0]){
				cube([608BallBearingHeight(.4)-.1,EncoderMountWidth(),wheelradius(.4)+PlasticWidth()*3]);	
			}
		}
		translate([PlasticWidth()*1.5,EncoderMountWidth()+HiLoScrewHeadDiameter(.4)-2,PlasticWidth()*2+1]){
			HiLoScrew(.4);
		}
		translate([PlasticWidth()*1.5,-HiLoScrewHeadDiameter(.4)+2,PlasticWidth()*2+1]){
			HiLoScrew(.4);
		}	
		if (encoder==true){
			encodermount();
		}	
		else {
			translate([PlasticWidth()*3+608BallBearingHeight(.4),EncoderMountWidth()/2,wheelradius(.4)]){
				rotate([0,180,0]){
					BearingCutout();
				}
			}		
		}
	}
}

wormtownbracket(true,.4);
translate([PlasticWidth()*6,0,0]){
	wormtownbracket(false,.4);	
}












