use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>;
use <../../../Vitamins/Vitamins/Sensors/Encoders/EncoderMagnet_Vitamin.scad>;
use <../../../Vitamins/Vitamins/Tools/Filament_Vitamin.scad>;
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>;


$fn=50;

function wheelheight()= FilamentDiam()*2+.1;
function offsetheight()= .75;
function offsetdiam() = 9;
function MKIIwheelheight() = wheelheight()+offsetheight()+MagnetLength(.4)-.1;

module bearingshaft(3dPrinterTolerance=.4)
{
	rotate([0,180,0]){
		magshaft(608BallBearingInnerDiam(3dPrinterTolerance)/2+.1,MagnetLength(.4)+2);
	}
}
module MKIIwheel(){
	union()
	{
		translate([0,0,0]){
			bearingshaft(.4);
		}
		translate([0,0,-offsetheight()]){
			cylinder(h=offsetheight(),r=offsetdiam()/2);
		}
		cylinder(h=wheelheight(),r=(608BallBearingDiam(.4)/2+608BallBearingInnerDiam(.4))/2);

	//the 608 bearing
		translate([0,0,-MKIIwheelheight()+608BallBearingHeight(.4)/2]){
			608BallBearing(.4);
		}
	}
}


translate([0,0,wheelheight()])
{
	rotate([0,180,0])
	{
		//MKIIwheel(.4);
	}
}

module MKIIwheelprint(){
	translate([-offsetdiam()*2,offsetdiam(),wheelheight()]){
		rotate([0,180,0]){	
			union(){
				translate([0,0,0]){
					bearingshaft(.4);
				}
				translate([0,0,-offsetheight()]){
					cylinder(h=offsetheight(),r=offsetdiam()/2);
				}
				difference(){
					cylinder(h=wheelheight(),r=((608BallBearingDiam(.4)/2+608BallBearingInnerDiam(.4)))/2);
					translate([0,0,wheelheight()/2]){
						rotate_extrude(convexity=10,$fn=100){
							translate([9.5,0,0]){
								circle(r=FilamentDiam(.4)/2);
							}
						}
					}	
				}
			}
		}
	}
}
MKIIwheelprint();
