use <../Axis/Parameters.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <CanvasPulley.scad>

function CanvasPulleyHerringboneMotorOffset()=
CanvasPulleyEffectiveHeight()-StandardServoThickness()/2-sin(CanvasPulleyGearOffsetAngle())*(CanvasPulleyGearRadius()+CanvasPulleyDriverRadius());
function HerringboneMotorMountHeight()=StandardServoThickness()+CanvasPulleyHerringboneMotorOffset();

module HerringBoneMotorMountClearance()
{
	translate([0,-1,0])
	{
		rotate([0,-78,0])
		{
			cube([HerringboneMotorMountHeight()*1.5,PrinterBedPlasticWidth()+2,HerringboneMotorMountHeight()]);
		}
	}
}

module CanvasPulleyMotorMount(herringbone=true)
{
	if (herringbone==true)
	{
		translate([-(StandardServoWingLength()+StandardServoBaseLength()-StandardServoCylinderDiam()/2),StandardServoOutcrop()-PrinterBedPlasticWidth(),0])
		{
			difference()
			{
				translate([-HiLoScrewHeadDiameter(),0,0])
				{
					union()	
					{
						
						cube([HerringboneMotorMountLength(),PrinterBedPlasticWidth(),HerringboneMotorMountHeight()]);						
						cube([HerringboneMotorMountLength(),HiLoScrewHeadDiameter()*3,PrinterBedPlasticWidth()]);
						translate([-PrinterBedPlasticWidth(),0,0])
						{
							cube([PrinterBedPlasticWidth(),HiLoScrewHeadDiameter()*3,HerringboneMotorMountHeight()]);
						}		
						translate([HerringboneMotorMountLength(),0,0])
						{
							cube([PrinterBedPlasticWidth(),HiLoScrewHeadDiameter()*3,HerringboneMotorMountHeight()]);
						}				
					}
				}
				translate([0,PrinterBedPlasticWidth(),StandardServoThickness()+CanvasPulleyHerringboneMotorOffset()])
				{
					rotate([0,90,-90])
					{
						#StandardServoMotor(true, 1, false, .4, 10);
					}
				}
				translate([0,PrinterBedPlasticWidth()+HiLoScrewHeadDiameter()*1.5,PrinterBedPlasticWidth()])
				{
					#HiLoScrew();
				
				}
				translate([HerringboneMotorMountLength()-HiLoScrewHeadDiameter()*2,PrinterBedPlasticWidth()+HiLoScrewHeadDiameter()*1.5,PrinterBedPlasticWidth()])
				{
					#HiLoScrew();
				}				
			}
		}
	}
	else
	{
//this is where the mount for the worm drive would go... IF I HAD ONE
	}
}

//translate([0,-StandardServoOutcrop()-HiLoScrewHeadDiameter()*1.5,0])
//CanvasPulleyMotorMount(true);

translate([0,0,-StandardServoOutcrop()+PrinterBedPlasticWidth()])
rotate([90,0,0])
CanvasPulleyMotorMount(true);