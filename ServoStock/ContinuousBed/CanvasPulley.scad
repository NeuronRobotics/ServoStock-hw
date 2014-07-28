use <../Axis/Parameters.scad>
use <../../../Vitamins/Vitamins/Kinematics/Belts/CanvasAsBelt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/ScrewsAsBolts/High_Low_Screw_As_Bolt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Libraries/Threaded_Library/WormDrive-NoThroat_ModifiedGear.scad>

//print these with low infill setting.


function CanvasPulleyWidth()=HiLoBoltLength()*1.3;
function CanvasPulleyLength()=getBaseRadius();
function SlitWidth() = CanvasWidth()*2;


module CanvasSlit()
{
	translate([-CanvasPulleyWidth()*.2,-SlitWidth()/2,-1])
	{
		cube([CanvasPulleyWidth()*.7, SlitWidth(), CanvasPulleyLength()+2]);
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

module TopBearingRoller()
{
	union()
	{
		BaseCanvasRoller();
		TopBearingMount();
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
							cylinder(r=CanvasPulleyWidth()/2-1, h=gearThickness()+2, $fn=40);
						}
					}						
				}
			}
			else
			{
			//type 3 stuff (helix gear?)
			}
		}
	}
	else
	{
		//this is eventually going to need to become the idler roller, which must have a spring attached--is there a good way to attach the spring or is it just wrapped around?
		TopAndBottomBearingRoller();
	}
}
	

CanvasRoller(true, 2);


//just checking how things mesh
use <CanvasPulleyDriver.scad>
translate([-32,25,4])
rotate([0,90,0])
#CanvasPulleyDriver();

//just checking the size of the mounts
use <CanvasPulleyMount.scad>
translate([0,0,-14])
rotate([90,0,0])
#CanvasPulleyMount(true);

translate([0,0,CanvasPulleyLength()+20])
rotate([-90,0,180])
#CanvasPulleyMount(false);




















