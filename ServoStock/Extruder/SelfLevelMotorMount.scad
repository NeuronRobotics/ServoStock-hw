use <effector.scad>
use <../../../Vitamins/Vitamins/Electronics/Hot_Ends/PrintrBotJHeadHotEnd_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/MiniServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>


module SelfLevelingMotorMount()
{
	union()
	{
		difference()
		{
			rotate([-20,0,0])
			{
				difference()
				{
					translate([-MiniServoThickness(),-MiniServoLength()-8,-2])
					{
						cube([MiniServoThickness()*1.3, MiniServoLength(),  MiniServoHeight()*1.5]);
					}
					rotate([0,180,180])
					{
						translate([-MiniServoThickness()*.85,8,2])
						{
							#MiniServoMotor(false, 2, false, 0);
						}
					}
				}
			}
			translate([-25,-40,23])
			{
				cube([50,100,50]);
			}
			translate([-3,-14,39])
			HiLoScrew();
		}		
		translate([-3,11,MiniServoHeight()*1.1])
		{
			difference()
			{
				cylinder(r=offset()*1.2, h=MiniServoHeight()/10, center=true, $fn=60);
				cylinder(r=HotEndDiam()/1.2 ,h=MiniServoHeight()/10+1, center=true);	
				translate([0,25,15])
				HiLoScrew();
			}
		}
	}
}

translate([3,-26,-23])
{
	SelfLevelingMotorMount();
}




