use <CanvasPulley.scad>
use <CanvasPulleyMount.scad>
use <CanvasPulleyHerringboneDriver.scad>
use <CanvasPulleyMotorMount.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>

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
	translate([0,0,CanvasPulleyEffectiveHeight()])
	{
		rotate([-90,0,0])
		{
			DrivenCanvasPulleyAssembly();
			translate([-100,0,0])
			{
				IdleCanvasPulleyAssembly();
			}
		}
	}
}

CanvasPulleyAssembly();

