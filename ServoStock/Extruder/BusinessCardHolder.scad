use <../../../Vitamins/Vitamins/Tools/Business_Card_Vitamin.scad>

function CardHolderThickness()=BusinessCardThickness()*2.5;
function CardHolderWidth()=BusinessCardWidth()/2;
function CardHolderLength()=BusinessCardLength()/4;
function CardHolderProngWidth()=CardHolderWidth()/5.5;
function CardHolderSpaceWidth()=(CardHolderWidth()-CardHolderProngWidth()*4)/3;

module CardHolderNegativeSpace()
{
	translate([-1,0,-1])
	{
		cube([CardHolderLength()*.7+1,CardHolderSpaceWidth(),CardHolderThickness()+2]);
	}
}

//CardHolderNegativeSpace();

module BusinessCardHolder()
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

BusinessCardHolder();


translate([-BusinessCardLength()*.82,-BusinessCardWidth()/4,0])
{
	#BusinessCard();
}