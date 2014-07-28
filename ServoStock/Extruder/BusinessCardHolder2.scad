use <../../../Vitamins/Vitamins/Tools/Business_Card_Vitamin.scad>
use <../../../Vitamins/Vitamins/Sensors/LimitSwitch_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/MiniServo_Vitamin.scad>




function CardHolderThickness()=BusinessCardThickness()*2.5;
function CardHolderWidth()=BusinessCardWidth()/2;
function CardHolderLength()=BusinessCardLength()/5;
function CardHolderProngWidth()=CardHolderWidth()/5.5;
function CardHolderSpaceWidth()=(CardHolderWidth()-CardHolderProngWidth()*4)/3;
function LimitSwitchConnectorWidth()=LimitSwitchWidth()+4;
function LimitSwitchConnectorLength()=LimitSwitchLength();

module CardHolderNegativeSpace()
{
	translate([-1,0,-1])
	{
		cube([CardHolderLength()*.9,CardHolderSpaceWidth(),CardHolderThickness()+2]);
	}
}


//CardHolderNegativeSpace();

module BusinessCardMount(switchtolerance=.7)
{
	difference()
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
			}
			translate([CardHolderLength(),CardHolderWidth()/2.4,0])
			{
				cube([LimitSwitchLength()/6,CardHolderThickness()*4, CardHolderThickness()]);
			}
		}
		translate([CardHolderWidth()/1.5,CardHolderWidth()/2.1-switchtolerance/2,CardHolderWidth()*.7])
		{
			rotate([-90,0,0])
			{
				LimitSwitchMount(switchtolerance);
			}
		}
	}
}

module LimitSwitchMount(tolerance=0)
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
			cube([LimitSwitchConnectorLength()*.9, (LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,CardHolderThickness()*2.5+tolerance]);

			translate([CardHolderLength()-LimitSwitchConnectorLength()-LimitSwitchCurveDiam()/3,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-LimitSwitchConnectorWidth(),0])
			cube([LimitSwitchConnectorLength()*.9, (LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,CardHolderThickness()*2.5+tolerance]);

			translate([CardHolderLength()-LimitSwitchConnectorLength()-LimitSwitchCurveDiam()/3,CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2-LimitSwitchConnectorWidth(),0])
			cube([(LimitSwitchConnectorWidth()-LimitSwitchWidth())/2,LimitSwitchConnectorWidth(),CardHolderThickness()*2.5]);

			}
			translate([CardHolderLength()-LimitSwitchConnectorLength()+MiniServoBoltDiam(),CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2+1,LimitSwitchCurveDiam()/2])
			{
				rotate([90,0,0])
				{			
					cylinder(r=MiniServoHornBoltDiam()/2, h=LimitSwitchConnectorWidth()+2, $fn=15);
				}
			}	
			translate([CardHolderLength()-LimitSwitchConnectorLength()*.7+(LimitSwitchConnectorWidth()-LimitSwitchWidth()),CardHolderWidth()-(CardHolderWidth()-LimitSwitchConnectorWidth())/2+1,LimitSwitchCurveDiam()/2+.5])
			{
				rotate([90,0,0])
				{			
					#cylinder(r=MiniServoHornBoltDiam()/2, h=LimitSwitchConnectorWidth()+2, $fn=15);
				}
			}		
		}
	
}

BusinessCardMount();

translate([0,20,0])
{
	LimitSwitchMount();
}

translate([-BusinessCardLength()*.82,-BusinessCardWidth()/4,0])
{
	//#BusinessCard();
}