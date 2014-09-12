use <../Axis/Parameters.scad>
use <../../../Vitamins/Vitamins/Kinematics/Belts/CanvasAsBelt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/ScrewsAsBolts/High_Low_Screw_As_Bolt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/ConstantForceSpring_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Sensors/Encoders/EncoderMagnet_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/DrillPressSpring_Vitamin.scad>
use <../../../Vitamins/Threaded_Library/WormDrive-NoThroat_ModifiedGear.scad>
use <../../../Vitamins/Threaded_Library/HerringBoneGear_Modified.scad>


//print these with low infill setting.

function CanvasPulleySlitWidth()=CanvasWidth()*2;
function CanvasPulleyClearance()=2;
function CanvasPulleyEffectiveHeight()=CanvasPulleyWidth()*1.5+CanvasPulleyClearance();

echo ("Canvas Pulley Effective Height: ", CanvasPulleyEffectiveHeight());
echo ("Canvas Pulley Print Height: ", CanvasPulleyLength()); 

function MotorCanvasPulleyLength()=CanvasPulleyLength()+608BallBearingHeight()*2-2;

function SpringCanvasPulleyLength()=MotorCanvasPulleyLength()+DrillPressSpringWidth()-2;

//this slop factor is because of tolerancing issues with print, if everything is just slightly out of tolerance, it can add up fast, however if the holders are just a little too far apart, there are no consequences. So the goal is to place the mounts at a distance that they will always be slightly farther apart than neccessary
function SlopFactor()=6;


function CanvasPulleyMountHerringboneDistance()=MotorCanvasPulleyLength()+(PlasticWidth()+608BallBearingHeight()/3)*2-HiLoBoltHeadDiameter()*4+SlopFactor();

function CanvasPulleyMountNonDrivenDistance()=SpringCanvasPulleyLength()+(PlasticWidth()+608BallBearingHeight()/3)*2-HiLoBoltHeadDiameter()*4+SlopFactor();

module CanvasSlit()
{
	translate([-CanvasPulleyWidth()*.2,-CanvasPulleySlitWidth()/2,-1])
	{
		cube([CanvasPulleyWidth()*.7, CanvasPulleySlitWidth(), CanvasPulleyLength()+2]);
	}
}

//CanvasSlit();


module BoltHole()
{
	rotate([0,0,-120])
	{
		translate([-CanvasPulleyWidth()/2+HiLoBoltHeadHeight()*1.5,CanvasPulleyWidth()/8,0])
		{
			rotate([0,-90,0])
			{
				union()
				{
					HiLoBolt(.4, CanvasPulleyWidth()/4);
					cylinder(r=HiLoBoltHeadDiameter()/2, h=HiLoBoltHeadDiameter()*2);	
				}
			}
		}
	}
}




module BaseCanvasRoller()
{
	difference()
	{
		cylinder(r=CanvasPulleyWidth()/2, h=CanvasPulleyLength(), $fn=40);
		translate([-CanvasPulleyWidth()*.2,0,-1])
		{
			cylinder(r=CanvasPulleyWidth()/10, h=CanvasPulleyLength()+2, $fn=40);
		}
		CanvasSlit();
		translate([0,0,CanvasPulleyLength()*1/10])
		{
			BoltHole();
		}
		translate([0,0,CanvasPulleyLength()*3.5/10])
		{
			BoltHole();
		}
		translate([0,0,CanvasPulleyLength()*6.5/10])
		{
			BoltHole();
		}
		translate([0,0,CanvasPulleyLength()*9/10])
		{
			BoltHole();
		}
	}
}


module BottomBearingMount()
{
	difference()
	{
		cylinder(r=CanvasPulleyWidth()/2, h=608BallBearingHeight()-1);
		translate([0,0,-0.5])				
		608BallBearing(.3);				
	}
}

module TopBearingMount()
{
	difference()
	{
		translate([0,0,CanvasPulleyLength()])
		{
			BottomBearingMount();
		}		
	}
}
	
module BottomBearingDraft()
{
	translate([0,0,608BallBearingHeight()-3]) //-3 is to offset it a bit so that the bearing won't just work its way into the draft
	{
		cylinder(r1=608BallBearingDiam()/2, r2=1, h=17);
	}
}

//the idea of this is to make a slot to make it easier to access the screw holes under the roller, however it's pretty unwieldy and probably not the best idea
//module BoltDropInSlot()
//{
//	rotate([90,0,0])
//	{
//		translate([-CanvasPulleyWidth()/4,CanvasPulleyLength()+608BallBearingHeight()-1.5,-CanvasPulleyEffectiveHeight()])
//		{
//			cylinder(r=HiLoBoltHeadDiameter()/2, h=CanvasPulleyLength()/2);
//		}
//	}
//}

module TopBearingRoller()
{
	difference()
	{
		union()
		{
			BaseCanvasRoller();
			TopBearingMount();
		}
//		BoltDropInSlot();
	}
}

module TopAndBottomBearingRoller()
{
	difference()
	{
		union()
		{
			translate([0,0,608BallBearingHeight()-1])
			{
				union()
				{
					BaseCanvasRoller();
					TopBearingMount();
				}
			}
			BottomBearingMount();
		}
		BottomBearingDraft();
	}
}

module BottomBearingRoller()
{
	difference()
	{
		union()
		{
			translate([0,0,608BallBearingHeight()-1])
			{
				BaseCanvasRoller();				
			}
			BottomBearingMount();
		}
		BottomBearingDraft();
	}
}

module ConstantForceSpringSlot()
{
	union()
	{
		cube([CanvasPulleyWidth(),CanvasPulleySlitWidth(),18]);
		translate([8,0,18/2])
		{
			rotate([0,0,50])
			{
				BoltHole();
			}
		}
	}
}

module ConstantForceRoller()

{
	difference()
	{
		BaseCanvasRoller();
		translate([-CanvasPulleyWidth()/2,-CanvasPulleySlitWidth()/2,CanvasPulleyLength()/6-18/2])
		{
			ConstantForceSpringSlot();
		}
		translate([-CanvasPulleyWidth()/2,-CanvasPulleySlitWidth()/2,CanvasPulleyLength()*5/6-18/2])
		{
			ConstantForceSpringSlot();
		}
	}
}

ConstantForceRoller();

module FrictionReductionRoller()
{
	difference()
	{
		union()
		{
			translate([0,0,608BallBearingHeight()-1])
			{
				union()
				{
					cylinder(r=CanvasPulleyWidth()/2, h=CanvasPulleyLength(), $fn=40);
					TopBearingMount();
				}
			}
			BottomBearingMount();
		}
		BottomBearingDraft();
	}
}

translate([0,50,0])
FrictionReductionRoller();






module CanvasRoller(motor=false, type=1)
{
	if(motor==true)
	{
		if(type==1) //directly attached to motor
		{
			difference()
			{
				TopBearingRoller();
				rotate([0,0,45])
				{
					StandardServoMotor(false, 1, true, .4, 10);
				}
			}
		}
		else
		{
			if(type==2)
			{
				union()
				{
					TopAndBottomBearingRoller();
					difference()
					{
						CanvasPulleyGear();
						translate([0,0,-1])
						{
							cylinder(r=CanvasPulleyWidth()/2-1, h=WormDriveGearThickness()+2, $fn=40);
						}
					}						
				}
			}
			else
			{
				union()
				{
					BottomBearingRoller();
					translate([0,0,CanvasPulleyLength()+608BallBearingDiam()/3-2])
					{
						cylinder(r=CanvasPulleyWidth()/2, h=608BallBearingHeight()/3);
						translate([0,0,608BallBearingHeight()/3])
						{
							cylinder(r=608BallBearingInnerDiam()/1.5, h=608BallBearingHeight()/3);
							translate([0,0,608BallBearingHeight()/3])
							{
								difference()
								{
									cylinder(r1=608BallBearingInnerDiam(3dPrinterTolerance=.3)/2,r2=608BallBearingInnerDiam(3dPrinterTolerance=.6)/2, h=608BallBearingHeight(), $fn=30);
									translate([0,0,608BallBearingHeight()-MagnetLength()])
									{
										MagnetDraft(.4);
									}
								}
							}
						}
					}
					difference()
					{
						double_helix_gear (teeth=CanvasPulleyTeeth());
						translate([0,0,-1])
						{
							cylinder(r=CanvasPulleyWidth()/2-1, h=HerringBoneGearThickness()+2, $fn=40);
						}
					}						
				}
			}
		}
	}
	else
	{
		difference()
		{
			union()
			{
				BottomBearingRoller();
				translate([0,0,CanvasPulleyLength()+DrillPressSpringWidth()-1])
				{
					cylinder(r=CanvasPulleyWidth()/2, h=DrillPressSpringWidth());
				}
				translate([0,0,DrillPressSpringWidth()-1+608BallBearingHeight()-.5])
				{
					TopBearingMount();
				}
			}
			translate([0,0,CanvasPulleyLength()+DrillPressSpringWidth()])
			{
				cube([DrillPressSpringThickness(), CanvasPulleyWidth()/2,DrillPressSpringWidth()+608BallBearingHeight()+1]);
				
			}
		}			
	}
}



translate([0,-50,0])
CanvasRoller(true, 3);

//if you want to check if we are within the printable area for the flashforge
//#cube([5,5,FlashforgePrintableHeight()]);


////if you ever need to check if the pulley is longer than the flashforge can print
//#cube([20,20, FlashforgePrintableHeight()]);



////////probably none of these things are needed any more, but keeping them for now



//just checking how things mesh
	//use <CanvasPulleyWormDriver.scad>
	//translate([-32,25,4])
	//rotate([0,90,0])
	//#CanvasPulleyWormDriver();
//
//just checking the size of the mounts
//	use <CanvasPulleyMount.scad>
//	translate([0,0,-PlasticWidth()-608BallBearingHeight()/3])
//	rotate([90,0,0])
//	CanvasPulleyMount(WormDriver=false,LinearSpring=false);

//	translate([0,0,CanvasPulleyLength()+608BallBearingHeight()*2+PlasticWidth()+608BallBearingHeight()/3-2])
//	rotate([-90,0,180])
//	CanvasPulleyMount(WormDriver=false,LinearSpring=false);

//checking the fit of the herringbone driver
//	use <CanvasPulleyHerringboneDriver.scad>
//	translate([-42,20.5,0])
//	rotate([0,0,35])
//	CanvasPulleyHerringboneDriver();

//how high up must the servo be
	
//	translate([-80,31.7,0])
//	rotate([0,0,-90])
//	StandardServoMotor();
//
//	function SizingCubeHeight()=12;
//	function SizingCubeLength()=100;
//
//	translate([-SizingCubeLength(),CanvasPulleyEffectiveHeight()-SizingCubeHeight(),0])
//	#cube([SizingCubeLength(),SizingCubeHeight(),10]);

//checking the motor mount
//	use <CanvasPulleyMotorMount.scad>
//	translate([-80,CanvasPulleyEffectiveHeight(),20])
//	rotate([90,0,0])
//	CanvasPulleyMotorMount(true);






///note: you sould be able to use pitch radius to find a less janky way of aligning the gears






//CanvasRoller(false);
////just checking the size of the for the idler roller
//	use <CanvasPulleyMount.scad>
//	translate([0,0,-PlasticWidth()-608BallBearingHeight()/3])
//	rotate([90,0,0])
//	CanvasPulleyMount(WormDriver=false,LinearSpring=true);
//
//	translate([0,0,CanvasPulleyLength()+608BallBearingHeight()*2+PlasticWidth()+608BallBearingHeight()/3-2])
//	rotate([-90,0,180])
//	CanvasPulleyMount(WormDriver=false,LinearSpring=false);
////
	