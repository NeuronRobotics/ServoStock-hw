use <../Axis/Parameters.scad>
use <../../../Vitamins/Threaded_Library/HerringBoneGear_Modified.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>

module CanvasPulleyHerringboneDriver()
{
	difference()
	{
		mirror([0,1,0])
		{
			double_helix_gear (teeth=CanvasDriverTeeth());
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
	

translate([0,0,10])
rotate([0,180,0])
CanvasPulleyHerringboneDriver();