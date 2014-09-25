// This is the pin for the encoder wheel.

$fn=100;

use <../../../Vitamins/Vitamins/Sensors/Encoders/EncoderMagnet_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>

function pinheight()=608BallBearingHeight(.4)*4;

module wormpin(){
	difference(){
		cylinder (r=608BallBearingInnerDiam(.4),h=pinheight());
		translate([0,0,pinheight()-MagnetLength()]){
			MagnetDraft(.4);
		}
		translate([608BallBearingInnerDiam(.4)/2/2+MagnetDiam(.4)/2,-608BallBearingInnerDiam(.4),0]){
			cube([608BallBearingInnerDiam(.4)*2,608BallBearingInnerDiam(.4)*2,pinheight(.4)]);
		}
	}
}

wormpin();
