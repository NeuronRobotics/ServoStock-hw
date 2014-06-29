use <Parameters.scad>
use <../../../Vitamins/Vitamins/Kinematics/Belts/CanvasAsBelt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>

//print these with low infill setting.


function CylinderWidth()=HiLoScrewLength()*1.3;
function CylinderHeight()=getBaseRadius();
function SlitWidth() = CanvasWidth()*2;


module CanvasSlit()
{
	translate([-CylinderWidth()*.2,-SlitWidth()/2,-1])
	{
		cube([CylinderWidth()*.7, SlitWidth(), CylinderHeight()+2]);
	}
}

//CanvasSlit();


module ScrewHole()
{
	rotate([0,0,-120])
	{
		translate([-CylinderWidth()/2+HiLoScrewHeadHeight()*1.5,CylinderWidth()/8,0])
		{
			rotate([0,-90,0])
			{
				union()
				{
					#HiLoScrew();
					cylinder(r=HiLoScrewHeadDiameter()/2, h=HiLoScrewHeadDiameter()*2);	
				}
			}
		}
	}
}



module CanvasRoller()
{
	difference()
	{
		cylinder(r=CylinderWidth()/2, h=CylinderHeight(), $fn=40);
		translate([-CylinderWidth()*.2,0,-1])
		{
			cylinder(r=CylinderWidth()/10, h=CylinderHeight()+2, $fn=40);
		}
		CanvasSlit();
		translate([0,0,CylinderHeight()/3])
		{
			ScrewHole();
		}
		translate([0,0,CylinderHeight()*2/3])
		{
			ScrewHole();
		}
	}
}

CanvasRoller();