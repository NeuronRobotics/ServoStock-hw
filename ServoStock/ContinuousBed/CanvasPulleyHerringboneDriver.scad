use <../Axis/Parameters.scad>
use <CanvasPulleyMotorMount.scad>
use <../../../Vitamins/Threaded_Library/HerringBoneGear_Modified.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>

module CanvasPulleyHerringboneDriver()
{
	difference()
	{
		union()
		{
			mirror([0,1,0])
			{
				double_helix_gear (teeth=CanvasDriverTeeth());
			}
			translate([0,0,-608BallBearingHeight()/3])
			{
				cylinder(r=608BallBearingInnerDiam()/1.5, h=608BallBearingHeight()/3, $fn=30);
			translate([0,0,-608BallBearingHeight()])
				cylinder(r1=608BallBearingInnerDiam(3dPrinterTolerance=.5)/2,r2=608BallBearingInnerDiam(3dPrinterTolerance=.3)/2, h=608BallBearingHeight(), $fn=30);
			}
		}
		rotate([0,180,0])
		{
			translate([0,0,-StandardServoCylinderHeight()-StandardServoBoltHeadHeight()*2])
			{
				StandardServoMotor(false, 1, true, 1, 10);
			}
		}
	}
}
	
//CanvasPulleyHerringboneDriver();

module CanvasPulleyHerringBoneDriverBearingMount()
{
	difference()
	{
		union()
		{
			cylinder(r=608BallBearingDiam()/2+PrinterBedPlasticWidth()/2, h=608BallBearingHeight()+PrinterBedPlasticWidth());
			translate([0,-608BallBearingDiam()/2,608BallBearingHeight()])
			{
				cube([CanvasPulleyHerringboneMotorOffset()+StandardServoCylinderDiam()/2,608BallBearingDiam(),PrinterBedPlasticWidth()]);
				translate([CanvasPulleyHerringboneMotorOffset()+StandardServoCylinderDiam()/2-PrinterBedPlasticWidth(),-608BallBearingDiam()/2,-608BallBearingHeight()])
				{
					cube([PrinterBedPlasticWidth(),608BallBearingDiam()*2,608BallBearingHeight()+PrinterBedPlasticWidth()]);
				}
			}
		}
		translate([0,0,-1])
		{
			cylinder(r=608BallBearingDiam()/2, h=608BallBearingHeight()+1);
		}
		translate([CanvasPulleyHerringboneMotorOffset()+StandardServoCylinderDiam()/2-PrinterBedPlasticWidth(),608BallBearingDiam()*3/4,(608BallBearingHeight()+PrinterBedPlasticWidth())/2])
		{
			rotate([0,-90,0])
			{
				#HiLoScrew();
			}
		}
		translate([CanvasPulleyHerringboneMotorOffset()+StandardServoCylinderDiam()/2-PrinterBedPlasticWidth(),-608BallBearingDiam()*3/4,(608BallBearingHeight()+PrinterBedPlasticWidth())/2])
		{
			rotate([0,-90,0])
			{
				#HiLoScrew();
			}
		}
	}
}

CanvasPulleyHerringBoneDriverBearingMount();








