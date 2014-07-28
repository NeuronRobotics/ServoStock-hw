use <../../../Vitamins/Vitamins/Tools/Business_Card_Vitamin.scad>
use <../../../Vitamins/Vitamins/Sensors/LimitSwitch_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/MiniServo_Vitamin.scad>



//this works well but the fork needs to be rotated 90 degrees







function CardHolderThickness()=BusinessCardThickness()*2.5;
function CardHolderWidth()=BusinessCardWidth()/2;
function CardHolderLength()=BusinessCardLength()/5+LimitSwitchConnectorLength();
function CardHolderProngWidth()=CardHolderWidth()/5.5;
function CardHolderSpaceWidth()=(CardHolderWidth()-CardHolderProngWidth()*4)/3;
function LimitSwitchConnectorWidth()=LimitSwitchWidth()+4;
function LimitSwitchConnectorLength()=LimitSwitchLength();

module CardHolderNegativeSpace()
{
	translate([-1,0,-1])
	{
		cube([CardHolderLength()*.9-LimitSwitchConnectorLength(),CardHolderSpaceWidth(),CardHolderThickness()+2]);
	}
}


//CardHolderNegativeSpace();

module BusinessCardHolder()
{
	union()
	{
		difference()
		{
			cube([CardHolderLength(),CardHolderWidth(),CardHolderThickness()]);
			translate([0,CardHolderProngWidth(),0])
			{
				CardHolderNegativeSpace();
			}
			translate([0,CardHolderProngWidth()*2+CardHolderSpaceWidth(),0])
			{
				CardHolderNegativeSpace();
			}
			translate([0,CardHolderProngWidth()*3+CardHolderSpaceWidth()*2,0])
			{
				CardHolderNegativeSpace();
			}
			translate([CardHolderLength()-LimitSwitchConnectorLength(),-1,-1])
			{
				cube([LimitSwitchConnectorLength()+1, (CardHolderWidth()-LimitSwitchConnectorWidth())/2+1, CardHolderThickness()+2]);
			}
			translate([CardHolderLength()-LimitSwitchConnectorLength(),CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2,-1])
			{
				cube([LimitSwitchConnectorLength()+1, (CardHolderWidth()-LimitSwitchConnectorWidth())/2+1, CardHolderThickness()+2]);
			}
		translate([CardHolderLength()-LimitSwitchConnectorLength()+2,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2+1,CardHolderThickness()+.5])
			{
				rotate([90,0,0])
				{
					cylinder(r=LimitSwitchCurveDiam()/2, h=LimitSwitchConnectorWidth()+2, $fn=10);
				}
			}
		}

		difference()
		{
			union()
			{
				translate([CardHolderLength()-LimitSwitchConnectorLength()-LimitSwitchCurveDiam()/3,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-(LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,0])
				cube([LimitSwitchCurveDiam()*1.5, (LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,CardHolderThickness()*2.5]);

				translate([CardHolderLength()-LimitSwitchConnectorLength()-LimitSwitchCurveDiam()/3,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-LimitSwitchConnectorWidth(),0])
				cube([LimitSwitchCurveDiam()*1.5, (LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,CardHolderThickness()*2.5]);

				translate([CardHolderLength()-LimitSwitchConnectorLength()/1.5,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-(LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,0])
				cube([LimitSwitchCurveDiam()*1.5, (LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,CardHolderThickness()*2.5]);

				translate([CardHolderLength()-LimitSwitchConnectorLength()/1.5,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-LimitSwitchConnectorWidth(),0])
				cube([LimitSwitchCurveDiam()*1.5, (LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,CardHolderThickness()*2.5]);
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
}

BusinessCardHolder();


translate([-BusinessCardLength()*.82,-BusinessCardWidth()/4,0])
{
	//#BusinessCard();
}