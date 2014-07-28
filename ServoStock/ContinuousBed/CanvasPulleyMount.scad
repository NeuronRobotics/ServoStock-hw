use <CanvasPulley.scad>
use <CanvasPulleyDriver.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>

function CanvasPulleyMountThickness()=5;
function CanvasPulleyEffectiveHeight()=CanvasPulleyWidth()*1.5;


module CanvasPulleyMount(motor=false,)
{
	difference()
	{
		translate([-CanvasPulleyWidth()/2,0,-CanvasPulleyEffectiveHeight()])
		{
			union()
			{
				cube([CanvasPulleyWidth(), CanvasPulleyMountThickness(),CanvasPulleyEffectiveHeight()]);
				translate([CanvasPulleyWidth()/2,CanvasPulleyMountThickness(),CanvasPulleyEffectiveHeight()])
				{
					rotate([90,0,0])
					{
						cylinder(r=CanvasPulleyWidth()/2, h=CanvasPulleyMountThickness());
					}
				}
				cube([CanvasPulleyWidth(),HiLoScrewHeadDiameter()*3, CanvasPulleyMountThickness()]);
				translate([CanvasPulleyWidth()/2,CanvasPulleyMountThickness(),CanvasPulleyEffectiveHeight()])
				{
					rotate([-90,0,0])
					{
						if(motor==true)	
						{
							union()
							{				
								cylinder(r=608BallBearingInnerDiam()/1.5, h=DriverRodRadius()*1.5, $fn=30);
								translate([0,0,DriverRodRadius()*1.5])
								{
									cylinder(r=608BallBearingInnerDiam()/2, h=608BallBearingHeight(), $fn=30);
								}
							}
						}else{
							union()
							{				
								cylinder(r=608BallBearingInnerDiam()/1.5, h=608BallBearingHeight()/3, $fn=30);
								translate([0,0,608BallBearingHeight()/3])
								{
								cylinder(r=608BallBearingInnerDiam()/2, h=608BallBearingHeight(), $fn=30);
								}
							}
						}
					}
				}
			}
		}	
		translate([CanvasPulleyWidth()/4,HiLoScrewHeadDiameter()*2,-CanvasPulleyEffectiveHeight()+CanvasPulleyMountThickness()])
		#HiLoScrew();
		translate([-CanvasPulleyWidth()/4,HiLoScrewHeadDiameter()*2,-CanvasPulleyEffectiveHeight()+CanvasPulleyMountThickness()])
		#HiLoScrew();
	}
}


//USE ORIENTATION
//CanvasPulleyMount(false);

//translate([0,50,0])
//rotate([0,0,180])
//CanvasPulleyMount(true);

//PRINT ORIENTATION
rotate([90,0,0])
CanvasPulleyMount(true);

translate([40,0,0])
rotate([90,0,0])
CanvasPulleyMount(false);





