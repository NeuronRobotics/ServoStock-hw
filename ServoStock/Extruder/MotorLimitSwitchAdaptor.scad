use <../Axis/Parameters.scad>
use <../../../Vitamins/Vitamins/Actuators/MiniServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Sensors/LimitSwitch_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/ScrewsAsBolts/Motor_Screw_As_Bolt_Vitamin.scad>

function MotorLimitSwitchAdaptorLength()=50;
//this is length to keep it wherever it needs to be in relation to the extruder, needs to be updated from 50 placeholder

module MotorLimitSwitchAdaptor()
{
	difference()
	{
		translate([MiniServoCylinderDiam()/4,0,0])
		{
			union()
			{
				cube([MotorLimitSwitchAdaptorLength(), PlasticWidth()/2,MiniServoHornMaxWidth()*1.2]);
				translate([MotorLimitSwitchAdaptorLength()-LimitSwitchBoxHeight(),0,0])
				{
				cube([LimitSwitchBoxHeight(), PlasticWidth()/2,LimitSwitchBoxLength()]);
				}
			}
		}
		translate([0,MiniServoHeight()+MiniServoCylinderHeight()+MiniServoNubHeight()+MiniServoHornHeight(),0])
		{
			rotate([90,0,0])
			{
				#MiniServoMotor(true, 2, true, .2);
			}
		}
		translate([MiniServoCylinderDiam()/4+MotorLimitSwitchAdaptorLength()-LimitSwitchBoxHeight()+LimitSwitchHoleTopInset(),PlasticWidth()/2+1,LimitSwitchHoleSideInset()])
		{
			rotate([90,0,0])
			{
				cylinder(r=MotorScrewBoltDiameter()/2, h=PlasticWidth()/2+2,$fn=15);
			}
		}
		translate([MiniServoCylinderDiam()/4+MotorLimitSwitchAdaptorLength()-LimitSwitchBoxHeight()+LimitSwitchHoleTopInset(),PlasticWidth()/2+1,LimitSwitchBoxLength()-LimitSwitchHoleSideInset()])
		{
			rotate([90,0,0])
			{
				cylinder(r=MotorScrewBoltDiameter()/2, h=PlasticWidth()/2+2,$fn=15);
			}
		}
	}
}

MotorLimitSwitchAdaptor();
