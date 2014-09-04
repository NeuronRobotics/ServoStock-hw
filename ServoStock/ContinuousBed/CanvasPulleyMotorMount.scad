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
			cube([HerringboneMotorMountHeight()*1.5,PlasticWidth()+2,HerringboneMotorMountHeight()]);
		}
	}
}

module CanvasPulleyMotorMount(herringbone=true)
{
	if (herringbone==true)
	{
		translate([-(StandardServoWingLength()+StandardServoBaseLength()-StandardServoCylinderDiam()/2),StandardServoOutcrop()-PlasticWidth(),0])
		{
			difference()
			{
				translate([-HiLoScrewHeadDiameter(),0,0])
				{
					union()	
					{
						difference()
						{
							cube([HerringboneMotorMountLength(),PlasticWidth(),HerringboneMotorMountHeight()]);
							HerringBoneMotorMountClearance();
							translate([HerringboneMotorMountLength(),0,0])
							{
								mirror([1,0,0])
								{
									HerringBoneMotorMountClearance();
								}
							}
						}
						cube([HerringboneMotorMountLength(),HiLoScrewHeadDiameter()*3,PlasticWidth()]);
					
					}
				}
				translate([0,PlasticWidth(),StandardServoThickness()+CanvasPulleyHerringboneMotorOffset()])
				{
					rotate([0,90,-90])
					{
						#StandardServoMotor(true, 1, false, .4, 10);
					}
				}
				translate([0,PlasticWidth()+HiLoScrewHeadDiameter()*1.5,PlasticWidth()])
				{
					#HiLoScrew();
				
				}
				translate([HerringboneMotorMountLength()-HiLoScrewHeadDiameter()*2,PlasticWidth()+HiLoScrewHeadDiameter()*1.5,PlasticWidth()])
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

translate([0,0,-StandardServoOutcrop()+PlasticWidth()])
rotate([90,0,0])
CanvasPulleyMotorMount(true);