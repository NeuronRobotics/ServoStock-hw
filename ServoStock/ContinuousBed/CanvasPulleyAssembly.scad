use <../Axis/Parameters.scad>
use <../Cabinet/CabinetTopSheet.scad>
use <CanvasPulley.scad>
use <CanvasPulleyMount.scad>
use <CanvasPulleyHerringboneDriver.scad>
use <CanvasPulleyMotorMount.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Threaded_Library/HerringBoneGear_Modified.scad>



module 3dBedPlate()
{
	linear_extrude(height=5)bedPlate();
}

module IdleCanvasPulleyAssembly()
{
	union()
	{
		CanvasRoller(false);
		translate([0,0,-PlasticWidth()-608BallBearingHeight()/3])
		{
			rotate([90,0,0])
			{
				CanvasPulleyMount(WormDriver=false,LinearSpring=true);
			}
		}
		translate([0,0,CanvasPulleyLength()+608BallBearingHeight()*2+PlasticWidth()+608BallBearingHeight()/3-2])	
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
		translate([0,0,-PlasticWidth()-608BallBearingHeight()/3])
		{
			rotate([90,0,0])
			{
				CanvasPulleyMount(WormDriver=false,LinearSpring=false);
			}
		}
		translate([0,0,CanvasPulleyLength()+608BallBearingHeight()*2+PlasticWidth()+608BallBearingHeight()/3-2])	
		{
			rotate([-90,0,180])
			{
				CanvasPulleyMount(WormDriver=false,LinearSpring=false);
			}
		}
		rotate(a=CanvasPulleyGearOffsetAngle(), v=[0,0,-(CanvasPulleyGearRadius()+CanvasPulleyDriverRadius())])
		{	
			translate([-(CanvasPulleyGearRadius()+CanvasPulleyDriverRadius()),0,0])
			{
				rotate([0,0,20])
				{
					CanvasPulleyHerringboneDriver();
				}
			}
		}
		translate([-CanvasPulleyMotorMountOffset(),CanvasPulleyEffectiveHeight(),HerringBoneGearThickness()])
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

translate([getBaseSideLength()/2,getBaseSideLength()/2,0])
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
