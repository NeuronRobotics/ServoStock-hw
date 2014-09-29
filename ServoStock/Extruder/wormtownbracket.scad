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
	difference(){
		translate([0,0,0]){
			cube([PlasticWidth()*3, EncoderMountWidth(), EncoderHeight()+PlasticWidth()*2.5]);
		}	
		translate([PlasticWidth()*2,EncoderMountWidth()/2-1,EncoderHeight(.4)]){
			rotate([90,180,270]){
				Encoder_Keepaway(true,.8);
			}
		}
		translate([PlasticWidth()*3+608BallBearingHeight(.4),EncoderMountWidth()/2-1,EncoderHeight()]){
			rotate([0,180,0]){
				BearingCutout();
			}
		}	
	}
}

module wormtownbracket(encoder=true,3dPrinterTolerance){
	union(){
		translate([0,0,wheelradius(.4)]){
			difference(){
				if (encoder==true){
					encodermount();
				}	
				else {
				}
			}
		}
	}
}


wormtownbracket(true,.4);	











