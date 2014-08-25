use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Kinematics/Belts/OneFifthinXLTimingBelt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Kinematics/Pulleys/Pulley_Vitamin.scad>


function BearingClipSideWidth()= (PulleyInnerDiam()-608BallBearingDiam(.3))/2;

function BearingClipDiam()= 608BallBearingDiam(.3)+ BearingClipSideWidth()*2;

function getHeight() = 2XLBeltWidth(.4)+BearingClipSideWidth()+1;


$fn=100;

module IdlerBearingClip()
{
	difference()
	{
		union()
		{
			cylinder(h=getHeight()+BearingClipSideWidth()-1, r=BearingClipDiam()/2);
			cylinder(h=BearingClipSideWidth(), r=PulleyInnerDiam()/2+BearingClipSideWidth());
			translate([0,0,getHeight()])
			{
				cylinder(h=BearingClipSideWidth(), r=PulleyInnerDiam()/2+BearingClipSideWidth());
			}
		}
		union()
		{
			//leve just enough room for the 7mm thick bearing
			translate([0,0,BearingClipSideWidth()+(getHeight()-7)])
			{
				cylinder(h=getHeight()+1, r=608BallBearingDiam(.3)/2);
			}
			translate([0,0,-1])
			{
				cylinder(h=getHeight()+2, r=608BallBearingDiam(.3)/2-BearingClipSideWidth());		
			}		
		}
	}
}



IdlerBearingClip();