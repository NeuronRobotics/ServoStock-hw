use <../../../Vitamins/Vitamins/Sensors/LimitSwitch_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/MiniServo_Vitamin.scad>
use <BusinessCardHolder2.scad>

module LimitSwitchMount()
{
	union()
	{
		difference()
		{
			translate([CardHolderLength()-LimitSwitchConnectorLength(),(CardHolderWidth()-LimitSwitchConnectorWidth())/2,0])
			{
				cube([LimitSwitchConnectorLength(), (CardHolderWidth()-LimitSwitchConnectorWidth())/2+.5, CardHolderThickness()]);
			}
			translate([CardHolderLength()-LimitSwitchConnectorLength()+2,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2+1,CardHolderThickness()+.5])
			{
				rotate([90,0,0])
				{
					cylinder(r=LimitSwitchCurveDiam()/2, h=LimitSwitchConnectorWidth()+2, $fn=10);
				}
			}
		}
	}
	difference()
	{
		union()
		{
			translate([CardHolderLength()-LimitSwitchConnectorLength()-LimitSwitchCurveDiam()/3,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-(LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,0])
			cube([LimitSwitchConnectorLength()*.9, (LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,CardHolderThickness()*2.5]);

			translate([CardHolderLength()-LimitSwitchConnectorLength()-LimitSwitchCurveDiam()/3,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-LimitSwitchConnectorWidth(),0])
			cube([LimitSwitchConnectorLength()*.9, (LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,CardHolderThickness()*2.5]);

			translate([CardHolderLength()-LimitSwitchConnectorLength()-LimitSwitchCurveDiam()/3,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-LimitSwitchConnectorWidth(),0])
			cube([(LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,LimitSwitchConnectorWidth(),CardHolderThickness()*2.5]);

			}
			translate([CardHolderLength()-LimitSwitchConnectorLength()+MiniServoBoltDiam()+1,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2+1,LimitSwitchCurveDiam()/2])
			{
				rotate([90,0,0])
				{			
					cylinder(r=MiniServoHornBoltDiam()/2, h=LimitSwitchConnectorWidth()+2, $fn=15);
				}
			}	
			translate([CardHolderLength()-LimitSwitchConnectorLength()/1.5+(LimitSwitchConnectorWidth()-LimitSwitchWidth()),CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2+1,LimitSwitchCurveDiam()/2+.5])
			{
				rotate([90,0,0])
				{			
					cylinder(r=MiniServoHornBoltDiam()/2, h=LimitSwitchConnectorWidth()+2, $fn=15);
				}
			}		
		}	
}

LimitSwitchMount();