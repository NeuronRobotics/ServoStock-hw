use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <CanvasPulley.scad>

function CanvasPulleyMotorMountThickness()=5;
function CanvasPulleyHerringboneMotorOffset()=12;
function HerringboneMotorMountHeight()=StandardServoThickness()+CanvasPulleyHerringboneMotorOffset();
function HerringboneMotorMountLength()=StandardServoLength()+HiLoScrewHeadDiameter()*2;

module CanvasPulleyMotorMount(herringbone=true)
{
	if (herringbone==true)
	{
		difference()
		{
			translate([-HiLoScrewHeadDiameter(),0,0])
			{
				union()	
				{
					cube([HerringboneMotorMountLength(),CanvasPulleyMotorMountThickness(),HerringboneMotorMountHeight()]);
					cube([HerringboneMotorMountLength(),HiLoScrewHeadDiameter()*3,CanvasPulleyMotorMountThickness()]);
					
				}
			}
			translate([0,CanvasPulleyMotorMountThickness(),StandardServoThickness()+CanvasPulleyHerringboneMotorOffset()])
			{
				rotate([0,90,-90])
				{
					#StandardServoMotor(true, 1, false, .4, 10);
				}
			}
			translate([0,CanvasPulleyMotorMountThickness()+HiLoScrewHeadDiameter()*1.5,CanvasPulleyMotorMountThickness()])
			{
				#HiLoScrew();
				
			}
			translate([HerringboneMotorMountLength()-HiLoScrewHeadDiameter()*2,CanvasPulleyMotorMountThickness()+HiLoScrewHeadDiameter()*1.5,CanvasPulleyMotorMountThickness()])
			{
				#HiLoScrew();
				
			}
		}
	}
	else
	{
//this is where the mount for the worm drive would go... IF I HAD ONE
	}
}

CanvasPulleyMotorMount(true);