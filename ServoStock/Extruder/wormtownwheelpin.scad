// This is the pin for the encoder wheel.  when printing, call '3dPrinterTolerance in the module as zero.  add .4-.8 for subtractions in the wheel and elsewhere.

$fn=100;

use <wormtownwheel.scad>
use <../../../Vitamins/Vitamins/Sensors/Encoders/EncoderMagnet_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>

function pinheight()=(2*608BallBearingHeight(.4))+wheelthickness(.4);

module wormpin(3dPrinterTolerance){
	difference(){
		cylinder (r=608BallBearingInnerDiam(.4)/2+3dPrinterTolerance,h=pinheight());
		translate([0,0,pinheight()-MagnetLength()]){
			EncoderMagnet(true,.4);
		}
		translate([608BallBearingInnerDiam(.4)/3,-608BallBearingInnerDiam(.4),0]){
			cube([608BallBearingInnerDiam(.4)*2,608BallBearingInnerDiam(.4)*2,pinheight(.4)]);
		}
	}
}

wormpin();
//test