use <../../../Libraries/Threaded_Library/WormDrive-NoThroat_ModifiedDriver.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>

function DriverRodRadius()=wormRadius()/2.6;

module CanvasPulleyDriver()
{
	union()
	{
		translate([0,0,wormLength()/15+wormLength()/5])
		{
			WormDriver();
		}
		translate([0,0,wormLength()/15-1])
		{
			cylinder(r=DriverRodRadius(), h=wormLength()/5+2, $fn=27);
		}
		difference()
		{
			cylinder(r=StandardServoCylinderDiam()/2, h=wormLength()/15);
			StandardServoMotor(true, 1, true, .4, 10);
		}

	}
}
	

CanvasPulleyDriver();