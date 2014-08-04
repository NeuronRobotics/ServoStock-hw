use <CanvasPulley.scad>
use <CanvasPulleyMount.scad>
use <CanvasPulleyHerringboneDriver.scad>
use <CanvasPulleyMotorMount.scad>
use <3dBedPlate.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>

function CanvasPulleySeperation()=100;


//////////figure out where the 1.5 fudge factor is coming from
function CanvasPulleyMountHerringboneDistance()= CanvasPulleyLength()+608BallBearingHeight()*8/3-(HiLoScrewHeadDiameter()*2+CanvasPulleyMountThickness())-1.5;

module IdleCanvasPulleyAssembly()
{
	union()
	{
		CanvasRoller(false);
		translate([0,0,-CanvasPulleyMountThickness()-608BallBearingHeight()/3])
		{
			rotate([90,0,0])
			{
				CanvasPulleyMount(WormDriver=false,LinearSpring=true);
			}
		}
		translate([0,0,CanvasPulleyLength()+608BallBearingHeight()*2+CanvasPulleyMountThickness()+608BallBearingHeight()/3-2])	
		{
			rotate([-90,0,180])
			{
				CanvasPulleyMount(WormDriver=false,LinearSpring=false);
			}
		}
	}
}

module DrivenCanvasPulleyAssembly()
{
	union()
	CanvasRoller(true, 3);
	{
		translate([0,0,-CanvasPulleyMountThickness()-608BallBearingHeight()/3])
		{
			rotate([90,0,0])
			{
				CanvasPulleyMount(WormDriver=false,LinearSpring=false);
			}
		}
		translate([0,0,CanvasPulleyLength()+608BallBearingHeight()*2+CanvasPulleyMountThickness()+608BallBearingHeight()/3-2])	
		{
			rotate([-90,0,180])
			{
				CanvasPulleyMount(WormDriver=false,LinearSpring=false);
			}
		}
//fix these janky numbers
		translate([-42,20.5,0])
		{
			rotate([0,0,35])
			{
				CanvasPulleyHerringboneDriver();
			}
		}
		translate([-80,CanvasPulleyEffectiveHeight(),20])
		{
			rotate([90,0,0])
			{
				CanvasPulleyMotorMount(true);
			}
		}
	}
}

module CanvasPulleyAssembly()
{
	translate([CanvasPulleySeperation()/2,-CanvasPulleyLength()/2,CanvasPulleyEffectiveHeight()])
	{
		rotate([-90,0,0])
		{
			DrivenCanvasPulleyAssembly();
			translate([-CanvasPulleySeperation(),0,0])
			{
				IdleCanvasPulleyAssembly();
			}
		}
	}
}

translate([BaseSideLength()/2,BaseSideLength()/2,0])
{
	rotate([0,0,-45])
	{
		CanvasPulleyAssembly();
	}
}
translate([0,0,-10])
{
	3dBedPlate();
}
