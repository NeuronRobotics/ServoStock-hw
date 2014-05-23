use <Parameters.scad>
use <../../../Vitamins/Vitamins/Structural/RodEnds/RodEnd_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/ScrewsAsBolts/Motor_Screw_As_Bolt_Vitamin.scad>

function RodEndClipLength()=RodEndBallSwivelFlangeHeight()*1.2;
function RodEndClipWidth()=MotorScrewBoltLength()*.9;
function RodEndClipHeight()=RodEndTopWidth();
function getRodEndConnectionOffsetDimention()=RodEndClipLength()/2+PlasticWidth()*2;


module RodEndSupport(supportHeight=10){
	translate([0,0,-RodEndClipHeight()/2])
	intersection(){
		union(){
			translate([RodEndClipWidth()/2,RodEndClipLength()/2,0])
				rotate([180,0,0])
					cylinder(	r2=0,
							 	r1=supportHeight, 
								h=supportHeight, 
								center=false, 
								$fn=24);
			translate([-RodEndClipWidth()/2,RodEndClipLength()/2,0])
				rotate([180,0,0])
					cylinder(	r2=0,
							 	r1=supportHeight, 
								h=supportHeight, 
								center=false, 
								$fn=24);
		}
		translate([0,0,-supportHeight])
			linear_extrude(height = supportHeight, center = false, convexity = 10)
				projection(cut = true) 
					translate([0,0,RodEndClipHeight()/2-1])
						RodEndClip();
	}
}

module RodEndClip()
{
	rotate([0,180,90])
	{
		difference()
		{
			union()
			{
				translate([0,-RodEndClipHeight()/8,0])
				{
					cube([RodEndClipLength(), RodEndClipWidth(),  RodEndClipHeight()], center=true);
				}
				translate([RodEndRodInset()*.8,-RodEndTopWidth()/8,0])
				{
					rotate([90,0,0])
					{
						cylinder(h=RodEndClipWidth(), r=MotorScrewBoltHeadDiameter()/2, center=true, $fn=30);
					}					
				}
			}
			translate([RodEndRodInset()*.8,0,0])
			{
				union()
				{
				//#RodEnd();
				RodEndSlot();
				}
			}
		}
	}
}

//RodEndClip();

module RodEndClips()
{
	translate([0,-RodEndClipLength()/2,RodEndClipHeight()/2]){
		translate([-RodEndSpacing()/2,0,0])
		{
			union()
			{
				RodEndClip();
			
				translate([RodEndSpacing(),0,0])
				{
					mirror([1,0,0])
					{
						RodEndClip();	
					}				
				}	
			}
		}
		RodEndClip();	
		translate([0,0,RodEndSpacing()])
		{
			RodEndClip();
			RodEndSupport();
		}
	}
}

RodEndClips();