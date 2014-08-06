use <../Axis/Parameters.scad>
use <CanvasPulley.scad>
use <CanvasPulleyWormDriver.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/ConstantForceSpring_Vitamin.scad>

module CanvasPulleyMount(WormDriver=false,LinearSpring=false)
{
	//difference()
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
								if (LinearSpring==true)
								{	
									translate([0,0,-PlasticWidth()])
									{
										difference()
										{
											cylinder(r=CanvasPulleyWidth()/1.5, h=PlasticWidth()+608BallBearingHeight()*4/3);
											translate([0,0,PlasticWidth()])
											{
												cylinder(r=CanvasPulleyWidth()/1.8, h=PlasticWidth()+608BallBearingHeight()*4/3);		
											}
											translate([-ConstantForceSpringHookLength()*.75,-CanvasPulleyWidth()/1.5+ConstantForceSpringHookDiameter()/2,PlasticWidth()+608BallBearingHeight()*1/3+.3])
											{
												rotate([180,180,90])
												{
													#ConstantForceSpringHook();
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
CanvasPulleyMount(false);

//translate([0,50,0])
//rotate([0,0,180])
//CanvasPulleyMount(true);

//PRINT ORIENTATION
//rotate([90,0,0])
//CanvasPulleyMount(WormDriver=true);
//
//translate([40,0,0])
//rotate([90,0,0])
//CanvasPulleyMount(WormDriver=false);
//
//translate([-40,0,0])
//rotate([90,0,0])
//CanvasPulleyMount(WormDriver=false,LinearSpring=true);






