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

module ConstantForceSpringHolderFacer()
{
	translate([0,-1,0])
	{
		rotate([0,-78,0])
		{
			cube([CanvasPulleyEffectiveHeight()*1.5,PrinterBedPlasticWidth()+2,CanvasPulleyEffectiveHeight()]);
		}
	}
}


module ConstantForceSpringHolder()
{
	difference()
	{
		translate([-DrillPressSpringOuterDiameter()/2,0,-CanvasPulleyEffectiveHeight()])
		{
			union()
			{
				difference()
				{
					translate([-DrillPressSpringOuterDiameter()/4,0,0])
					{
						cube([DrillPressSpringOuterDiameter()*1.5, PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()]);
					}
					translate([-DrillPressSpringOuterDiameter()/4,0,0])
					{
						ConstantForceSpringHolderFacer();
					}
					translate([DrillPressSpringOuterDiameter()*1.5-DrillPressSpringOuterDiameter()/4,0,0])
					{
						mirror([1,0,0])
						{
							ConstantForceSpringHolderFacer();
						}
					}
				}
				translate([-DrillPressSpringOuterDiameter()*.5/2, 0, 0])
				{
					cube([DrillPressSpringOuterDiameter()*1.5,PlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth(), PrinterBedPlasticWidth()]);
				}
				translate([0,PlasticWidth(),CanvasPulleyEffectiveHeight()])
				{	
					translate([DrillPressSpringOuterDiameter()/2,-PlasticWidth(),0])
					{
						rotate([-90,0,0])
						{
							difference()
							{
								cylinder(r=(DrillPressSpringOuterDiameter()+PlasticWidth())/2, h=PrinterBedPlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth());
								translate([0,0,PrinterBedPlasticWidth()])
								{
									cylinder(r=DrillPressSpringOuterDiameter()/2, h=PlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth());		
								}
								for (i = [0:72:359])
								{ 
									translate([0,0,PrinterBedPlasticWidth()-PlasticWidth()])
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
		translate([DrillPressSpringOuterDiameter()*1.5/2.5,(PrinterBedPlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth())/2,-CanvasPulleyEffectiveHeight()+PrinterBedPlasticWidth()])
		#HiLoScrew();
		translate([-DrillPressSpringOuterDiameter()*1.5/2.5,(PrinterBedPlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth())/2,-CanvasPulleyEffectiveHeight()+PrinterBedPlasticWidth()])
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



