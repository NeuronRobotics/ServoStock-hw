use <../Axis/Parameters.scad>
use <CanvasPulley.scad>
use <CanvasPulleyWormDriver.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/DrillPressSpring_Vitamin.scad>

module setFrame(){
	
	translate([DrillPressSpringOuterDiameter()/2,0,PlasticWidth()])
	{
		rotate([0,0,90])
		{
			children();
		}
	}
}

module ConstantForceSpringHolder()
{
	difference()
	{
		translate([-CanvasPulleyWidth()/2,0,-CanvasPulleyEffectiveHeight()])
		{
			union()
			{
				cube([CanvasPulleyWidth(), PlasticWidth(),CanvasPulleyEffectiveHeight()]);
				translate([CanvasPulleyWidth()/2,PlasticWidth(),CanvasPulleyEffectiveHeight()])
				{
					rotate([90,0,0])
					{
						cylinder(r=CanvasPulleyWidth()/2, h=PlasticWidth());
					}
				}
				cube([CanvasPulleyWidth(),HiLoScrewHeadDiameter()*3, PlasticWidth()]);
				translate([CanvasPulleyWidth()/2,PlasticWidth(),CanvasPulleyEffectiveHeight()])
				{	
					translate([0,-PlasticWidth(),0])
					{
						rotate([-90,0,0])
						{
							difference()
							{
								cylinder(r=(DrillPressSpringOuterDiameter()+PlasticWidth())/2, h=PlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth());
								translate([0,0,PlasticWidth()])
								{
									cylinder(r=DrillPressSpringOuterDiameter()/2, h=PlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth());		
								}
								for (i = [0:72:359])
								{ 
									rotate([0,0,i])
									{
										setFrame(){
											{
												cube([DrillPressSpringOuterDiameter()/2, 2, 18]);
											}
										}
									}
								}
							}	
							difference()
							{
								cylinder(r=10, h=PlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth()+PlasticWidth()/2);
								translate([0,0,PlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth()+PlasticWidth()/2-HiLoScrewLength()])
								{
									cylinder(r=HiLoScrewDiameter(.3)/2, h=HiLoScrewLength()+1, $fn=20);	
								}	
							}	
						}			
					}
				}
			}
		}	
		translate([CanvasPulleyWidth()/4,HiLoScrewHeadDiameter()*2,-CanvasPulleyEffectiveHeight()+PlasticWidth()])
		#HiLoScrew();
		translate([-CanvasPulleyWidth()/4,HiLoScrewHeadDiameter()*2,-CanvasPulleyEffectiveHeight()+PlasticWidth()])
		#HiLoScrew();
	}
}




ConstantForceSpringHolder();


module ConstantForceSpringCap()
{
	difference()
	{
		cylinder(r=DrillPressSpringOuterDiameter()/2-1, h=PlasticWidth());
		cylinder(r=11, h=PlasticWidth()/2);
		cylinder(r=HiLoScrewDiameter(.6)/2, h=PlasticWidth());
	}
}


//translate([0,26,0])
//rotate([-90,0,0])
//ConstantForceSpringCap();



