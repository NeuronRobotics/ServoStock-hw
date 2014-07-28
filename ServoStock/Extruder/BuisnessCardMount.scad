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

module BusinessCardMount()
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
}


module BusinessCardHolder()
{
	union()
	{
		translate([-CardHolderLength()+1,CardHolderWidth()/2+LimitSwitchConnectorWidth()/2,-CardHolderWidth()/2])
		{
			rotate([90,0,0])
			{
				BusinessCardMount();
			}
		}
		LimitSwitchMount();
	}
}

BusinessCardHolder();


translate([-BusinessCardLength()*.82,-BusinessCardWidth()/4,0])
{
	//#BusinessCard();
}