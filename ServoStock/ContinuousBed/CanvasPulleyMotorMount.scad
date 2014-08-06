use <../Axis/Parameters.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <CanvasPulley.scad>

function CanvasPulleyHerringboneMotorOffset()=12;
function HerringboneMotorMountHeight()=StandardServoThickness()+CanvasPulleyHerringboneMotorOffset();


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
						cube([HerringboneMotorMountLength(),PlasticWidth(),HerringboneMotorMountHeight()]);
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
CanvasPulleyMotorMount(true);