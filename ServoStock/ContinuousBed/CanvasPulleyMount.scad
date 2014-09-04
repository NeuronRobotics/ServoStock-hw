use <../Axis/Parameters.scad>
use <CanvasPulley.scad>
use <CanvasPulleyWormDriver.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/DrillPressSpring_Vitamin.scad>

module CanvasPulleyMount(WormDriver=false,LinearSpring=false)
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
					rotate([-90,0,0])
					{
						if(WormDriver==true)	
						{
							union()
							{				
								cylinder(r=608BallBearingInnerDiam()/1.5, h=WormDriverRodRadius()*1.5, $fn=30);
								translate([0,0,WormDriverRodRadius()*1.5])
								{
									cylinder(r1=608BallBearingInnerDiam(3dPrinterTolerance=0)/2,r2=608BallBearingInnerDiam(3dPrinterTolerance=.4)/2, h=608BallBearingHeight(), $fn=30);
								}
							}
						}else{
							union()
							{				
								cylinder(r=608BallBearingInnerDiam()/1.5, h=608BallBearingHeight()/3, $fn=30);
								translate([0,0,608BallBearingHeight()/3])
								{
								cylinder(r1=608BallBearingInnerDiam(3dPrinterTolerance=0)/2,r2=608BallBearingInnerDiam(3dPrinterTolerance=.4)/2, h=608BallBearingHeight(), $fn=30);
								}
								if (LinearSpring==true)
								{	
									translate([0,0,-PlasticWidth()])
									{
										difference()
										{
											cylinder(r=(DrillPressSpringOuterDiameter()+PlasticWidth())/2, h=PlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth());
											translate([0,0,PlasticWidth()])
											{
												cylinder(r=DrillPressSpringOuterDiameter()/2, h=PlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth());		
											}
											translate([-DrillPressSpringHookLength()*.75,-DrillPressSpringOuterDiameter()/2-.5,PlasticWidth()+608BallBearingHeight()*4/3+.1])
											{
												rotate([180,180,90])
												{
													#DrillPressSpringHook();
												}
											}
										}
									}
								}else{}
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


//USE ORIENTATION
//CanvasPulleyMount(false);
//
//translate([0,50,0])
//rotate([0,0,180])
//CanvasPulleyMount(true);

//PRINT BED
rotate([90,0,0])
CanvasPulleyMount(WormDriver=true);

translate([80,0,0])
rotate([90,0,0])
CanvasPulleyMount(WormDriver=false);

translate([40,0,0])
rotate([90,0,0])
CanvasPulleyMount(WormDriver=false);

translate([-45,0,0])
rotate([90,0,0])
CanvasPulleyMount(WormDriver=false,LinearSpring=true);






