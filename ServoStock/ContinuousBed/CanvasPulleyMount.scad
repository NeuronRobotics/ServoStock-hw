use <../Axis/Parameters.scad>
use <CanvasPulley.scad>
use <CanvasPulleyWormDriver.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/DrillPressSpring_Vitamin.scad>
use <../../../Vitamins/Vitamins/Sensors/Encoders/Encoder_Vitamin.scad>

function ShortCanvasPulleyMountHeight() = CanvasPulleyWidth()*1.2;

//module CanvasPulleyMount(WormDriver=false,LinearSpring=false)
//{
//	difference()
//	{
//		translate([-CanvasPulleyWidth()/2,0,-CanvasPulleyEffectiveHeight()])
//		{
//			union()
//			{
//				cube([CanvasPulleyWidth(), PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()]);
//				translate([CanvasPulleyWidth()/2,PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()])
//				{
//					rotate([90,0,0])
//					{
//						cylinder(r=CanvasPulleyWidth()/2, h=PrinterBedPlasticWidth());
//					}
//				}
//				cube([CanvasPulleyWidth(),HiLoScrewHeadDiameter()*3, PrinterBedPlasticWidth()]);
//				translate([CanvasPulleyWidth()/2,PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()])
//				{
//					rotate([-90,0,0])
//					{
//						if(WormDriver==true)	
//						{
//							union()
//							{				
//								cylinder(r=608BallBearingInnerDiam()/1.5, h=WormDriverRodRadius()*1.5, $fn=30);
//								translate([0,0,WormDriverRodRadius()*1.5])
//								{
//									cylinder(r1=608BallBearingInnerDiam(3dPrinterTolerance=0)/2,r2=608BallBearingInnerDiam(3dPrinterTolerance=.4)/2, h=608BallBearingHeight(), $fn=30);
//								}
//							}
//						}else{
//							union()
//							{				
//								cylinder(r=608BallBearingInnerDiam()/1.5, h=608BallBearingHeight()/3, $fn=30);
//								translate([0,0,608BallBearingHeight()/3])
//								{
//								cylinder(r1=608BallBearingInnerDiam(3dPrinterTolerance=.4)/2,r2=608BallBearingInnerDiam(3dPrinterTolerance=.7)/2, h=608BallBearingHeight(), $fn=30);
//								}
//								if (LinearSpring==true)
//								{	
//									translate([0,0,-PrinterBedPlasticWidth()])
//									{
//										difference()
//										{
//											cylinder(r=(DrillPressSpringOuterDiameter()+PrinterBedPlasticWidth())/2, h=PrinterBedPlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth());
//											translate([0,0,PrinterBedPlasticWidth()])
//											{
//												cylinder(r=DrillPressSpringOuterDiameter()/2, h=PrinterBedPlasticWidth()+608BallBearingHeight()*4/3+DrillPressSpringWidth());		
//											}
//											translate([-DrillPressSpringHookLength()*.75,-DrillPressSpringOuterDiameter()/2-.5,PrinterBedPlasticWidth()+608BallBearingHeight()*4/3+.1])
//											{
//												rotate([180,180,90])
//												{
//													#DrillPressSpringHook();
//												}
//											}
//										}
//									}
//								}else{}
//							}
//						}
//					}
//				}
//			}
//		}	
//		translate([CanvasPulleyWidth()/4,HiLoScrewHeadDiameter()*2,-CanvasPulleyEffectiveHeight()+PrinterBedPlasticWidth()])
//		#HiLoScrew();
//		translate([-CanvasPulleyWidth()/4,HiLoScrewHeadDiameter()*2,-CanvasPulleyEffectiveHeight()+PrinterBedPlasticWidth()])
//		#HiLoScrew();
//	}
//}

module ShortCanvasPulleyMount()
{
	difference()
	{
		translate([-CanvasPulleyWidth()/2,0,-ShortCanvasPulleyMountHeight()])
		{
			union()
			{
				cube([CanvasPulleyWidth(), PrinterBedPlasticWidth(),ShortCanvasPulleyMountHeight()]);
				translate([CanvasPulleyWidth()/2,PrinterBedPlasticWidth(),ShortCanvasPulleyMountHeight()])
				{
					rotate([90,0,0])
					{
						cylinder(r=CanvasPulleyWidth()/2, h=PrinterBedPlasticWidth());
					}
				}
				cube([CanvasPulleyWidth(),HiLoScrewHeadDiameter()*3, PrinterBedPlasticWidth()]);
				translate([CanvasPulleyWidth()/2,PrinterBedPlasticWidth(),ShortCanvasPulleyMountHeight()])
				{
					rotate([-90,0,0])
					{
						union()
						{				
							cylinder(r=608BallBearingInnerDiam()/1.5, h=608BallBearingHeight()/3, $fn=30);
							translate([0,0,608BallBearingHeight()/3])
							{
							cylinder(r1=608BallBearingInnerDiam(3dPrinterTolerance=.4)/2,r2=608BallBearingInnerDiam(3dPrinterTolerance=.7)/2, h=608BallBearingHeight(), $fn=30);
							}
						}
					}
				}
			}
		}
		translate([CanvasPulleyWidth()/4,HiLoScrewHeadDiameter()*2,-ShortCanvasPulleyMountHeight()+PrinterBedPlasticWidth()])
		#HiLoScrew();
		translate([-CanvasPulleyWidth()/4,HiLoScrewHeadDiameter()*2,-ShortCanvasPulleyMountHeight()+PrinterBedPlasticWidth()])
		#HiLoScrew();
	}
}


//ShortCanvasPulleyMount();

module CanvasPulleyKickback()
{
	difference()
	{
		union()
		{
			cube([CanvasPulleyWidth()+CanvasPulleyEffectiveHeight(),HiLoScrewHeadDiameter()*3, PrinterBedPlasticWidth()]);
			difference()
			{
				translate([CanvasPulleyWidth(),0,0])
				{
					cube([CanvasPulleyEffectiveHeight(), PrinterBedPlasticWidth(), CanvasPulleyEffectiveHeight()]);
				}
				translate([CanvasPulleyEffectiveHeight()/2-5,-1,CanvasPulleyEffectiveHeight()*sqrt(2)/2+CanvasPulleyEffectiveHeight()/2])
				{
					rotate([0,45,0])
					{
						cube([CanvasPulleyEffectiveHeight()*2, PrinterBedPlasticWidth()+2, CanvasPulleyEffectiveHeight()]);
					}
				}
			}
		}
		translate([CanvasPulleyWidth()/2,HiLoScrewHeadDiameter()*2,PrinterBedPlasticWidth()])
		HiLoScrew();
		translate([CanvasPulleyWidth()/2+CanvasPulleyEffectiveHeight(),HiLoScrewHeadDiameter()*2,PrinterBedPlasticWidth()])
		HiLoScrew();
	}
}

module CanvasPulleyMount(Right=true)
{
	translate([-CanvasPulleyWidth()/2,0,-CanvasPulleyEffectiveHeight()])
	{
		union()
		{
			cube([CanvasPulleyWidth(), PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()]);
			translate([CanvasPulleyWidth()/2,PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()])
			{
				rotate([90,0,0])
				{
					cylinder(r=CanvasPulleyWidth()/2, h=PrinterBedPlasticWidth());
				}
			}
			if(Right==true)
			{
				CanvasPulleyKickback();
			}else{
				translate([CanvasPulleyWidth(),0,0])
				{
					mirror([1,0,0])
					{
						CanvasPulleyKickback();
					}
				}
			}
			translate([CanvasPulleyWidth()/2,PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()])
			{
				rotate([-90,0,0])
				{
					union()
					{				
						cylinder(r=608BallBearingInnerDiam()/1.5, h=608BallBearingHeight()/3, $fn=30);
						translate([0,0,608BallBearingHeight()/3])
						{
						cylinder(r1=608BallBearingInnerDiam(3dPrinterTolerance=.4)/2,r2=608BallBearingInnerDiam(3dPrinterTolerance=.7)/2, h=608BallBearingHeight(), $fn=30);
						}
					}
				}
			}
		}
	}
}


module CanvasPulleyMountWithEncoder()
{
difference()
{
	translate([-CanvasPulleyWidth()/2,0,-CanvasPulleyEffectiveHeight()])
		{
			union()
			{
				cube([CanvasPulleyWidth(), PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()]);
				translate([CanvasPulleyWidth()/2,PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()])
				{
					rotate([90,0,0])
					{
						cylinder(r=CanvasPulleyWidth()/2, h=PrinterBedPlasticWidth());
					}
				}
				translate([CanvasPulleyWidth(),0,0])
				{
					mirror([1,0,0])
					{
						CanvasPulleyKickback();
					}
				}
				translate([CanvasPulleyWidth()-PrinterBedPlasticWidth()/2,0,0])
				{
					cube([PrinterBedPlasticWidth(),PrinterBedPlasticWidth(), CanvasPulleyEffectiveHeight()]);
				}
				translate([CanvasPulleyWidth()/2,PrinterBedPlasticWidth(),CanvasPulleyEffectiveHeight()])
				{
					rotate([-90,0,0])
					{
						difference()
						{			
							translate([0,0,-PrinterBedPlasticWidth()])
							{	
								cylinder(r=608BallBearingDiam()/2+PrinterBedPlasticWidth(), h=608BallBearingHeight()+PrinterBedPlasticWidth(), $fn=30);
							}	
							cylinder(r=608BallBearingDiam()/2,h=608BallBearingHeight()+1, $fn=30);
						}
					}
				}
			}
		}
		rotate([90,180,0])
		{
			Encoder(true);
		}
		translate([0,PrinterBedPlasticWidth()+1,0])
		{
			rotate([90,0,0])
			{
				cylinder(r=608BallBearingInnerDiam()/2,h=PrinterBedPlasticWidth()+2);
			}
		}
	}
}

translate([0,50,0])
%CanvasPulleyMount(false);
CanvasPulleyMountWithEncoder();




////USE ORIENTATION
////CanvasPulleyMount(false);
////
////translate([0,50,0])
////rotate([0,0,180])
////CanvasPulleyMount(true);
//
////PRINT BED
//rotate([90,0,0])
//CanvasPulleyMount(WormDriver=false);
//
//translate([80,0,0])
//rotate([90,0,0])
//CanvasPulleyMount(WormDriver=false);
//
//translate([40,0,0])
//rotate([90,0,0])
//CanvasPulleyMount(WormDriver=false);
//
//translate([-45,0,0])
//rotate([90,0,0])
//CanvasPulleyMount(WormDriver=false,LinearSpring=true);






