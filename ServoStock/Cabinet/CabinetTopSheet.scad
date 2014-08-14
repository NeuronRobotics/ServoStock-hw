function getThickness() = 18;
use <../Axis/StructuralFeet.scad>
use <../Axis/Parameters.scad>
use <../Axis/RodEndClips.scad>	
use <../Axis/Clips.scad>	
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/ScrewsAsBolts/Motor_Screw_As_Bolt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Kinematics/Belts/CanvasAsBelt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Threaded_Library/HerringBoneGear_Modified.scad>
use <../../../Vitamins/Vitamins/Electronics/Bowler_Board_Vitamin.scad>

function CuttingToolDiam()=(1/8)*25.4; //diameter of cutting tool, maximum width of any hole



module placeTabsMounts(){
	for (a = [	getCaseBoardThickness()*2:
		getInnerPlateTabPitch():
		getBaseSideLength()-getCaseBoardThickness()*2]){
		translate([0,a,0])
			child();

	}
}

module getTabsForInnerPlate(addHoles=false){
	placeTabsMounts(){
		square([getCaseBoardThickness(),getInnerPlateTabPitch()/4]);
	}
	if(addHoles){
		placeTabsMounts(){
			translate([getCaseBoardThickness()/2,
			           getInnerPlateTabPitch()*2/3,
			           0])
			           circle(getCaseHoleSize()/2);
		}
	}
}


module squareWithMountHoles(sideLength=10, useTabs = false,bedCutout = false){
	holeSize=getCaseHoleSize();
	pitch=50;
	recessFromSide = getCaseBoardThickness()/2;
	difference(){
		square([sideLength,sideLength],center=true);
		
		for (a = [getCaseBoltHolePitch()+getCaseBoltHolePitch()/4:getCaseBoltHolePitch():sideLength-getCaseBoltHolePitch()]){
			translate([a-sideLength/2,sideLength/2-recessFromSide,0])
				circle(holeSize/2);
			translate([a-sideLength/2,-sideLength/2+recessFromSide,0])
				circle(holeSize/2);
			translate([sideLength/2-recessFromSide,a-sideLength/2,0])
				circle(holeSize/2);
			translate([-sideLength/2+recessFromSide,a-sideLength/2,0])
				circle(holeSize/2);
		}
		if(useTabs){
			difference(){
				square([sideLength+1,sideLength+1],center=true);
				square([sideLength-getCaseBoardThickness()*2,sideLength-getCaseBoardThickness()*2],center=true);
			}
		}

	}
	translate([-sideLength/2,-sideLength/2,0]){
		//%circle(5);
		getTabsForInnerPlate();
	
		rotate([0,0,90])
			translate([0,-sideLength,0]){
					getTabsForInnerPlate();
		}
		rotate([0,0,-90])
			translate([-(sideLength),0,0])
				getTabsForInnerPlate();
		rotate([0,0,180])
			translate([-(sideLength),-(sideLength),0])
				getTabsForInnerPlate();
	}
	//%square([sideLength-getCaseBoardThickness()*2,sideLength-getCaseBoardThickness()*2],center=true);
}


module topPlate(useTabs = true,bedCutout = false, axisMounts=true){
	fudge = extraSideLength()/sqrt(2)-60;
	
	translate([getBaseSideLength()/2 -fudge/sqrt(2) ,getBaseSideLength()/2 +fudge/sqrt(2),0])
	rotate([0,0,-45-90])
	difference(){
		translate([0,extraSideLength()/sqrt(2)-60,0])
			rotate([0,0,45])
				difference(){
					squareWithMountHoles(getBaseSideLength(),useTabs,bedCutout);
					rotate([0,0,45])
						translate([getBaseSideLength()/2+getShortSideLength()/sqrt(2),0,0])
							square([getBaseSideLength(),getBaseSideLength()],center=true);
				}
		if(axisMounts){
			for (a = [0:120:359]){
				rotate([0,0,a])
					translate([0,-getBaseRadius(),0]){
						//import (file = "FeetOutline.dxf", origin = 0);
						getStructuralFeetInterface();
						//%StructuralFeet();
					}
							
			}
		}
		if(bedCutout){
			translate([0,getPrintbedWidth()/1.5,0]){
				square([getPrintbedWidth(),
				        getPrintbedWidth()*2],center=true);
			}
			circle(getBaseRadius()-10);
		}
		
		echo("Square side length is ",getBaseSideLength());
	}

}

module bearingPlate(){
	topPlate( bedCutout = true);
}


module CanvasPulleyMount(wormgear=false)
{
	if(wormgear==false)
	{
		circle(HiLoScrewDiameter()/2);
		translate([0,CanvasPulleyWidth()/2,0])
		{
			circle(HiLoScrewDiameter()/2);
		}
		translate([CanvasPulleyMountHerringboneDistance(),0,0])
		{
			circle(HiLoScrewDiameter()/2);
		}
		translate([CanvasPulleyMountHerringboneDistance(),CanvasPulleyWidth()/2,0])
		{
			circle(HiLoScrewDiameter()/2);
		}
	}
	else
	{
	//put wormgear mount here if necessary
	}
}

module MotorMount()
{
	rotate([0,0,90])
	{
		union()
		{
			circle(HiLoScrewDiameter()/2);
			translate([HerringboneMotorMountLength()-HiLoScrewHeadDiameter()*2,0,0])
			{
				circle(HiLoScrewDiameter()/2);
			}
		}
	}
}

module CanvasHoles()
{
	translate([getBaseSideLength()/2,getBaseSideLength()/2,0])
	{
		rotate([0,0,45])
		{
			translate([-CanvasPulleyLength()/2,-getPrintbedWidth()/2,0])
			{
				square([CanvasPulleyLength(), CuttingToolDiam()]);
				translate([0,getPrintbedWidth(),0])
				{
					square([CanvasPulleyLength(), CuttingToolDiam()]);
				}
			}
		}
	}
}

module BowlerBoardMount()
{
	union()
	{
		difference()
		{
			square([BowlerBoardSideLength(),BowlerBoardSideLength()]);
			translate([BowlerBoardInset(),BowlerBoardInset(),0])
			{
				square(MotorScrewBoltDiameter()*3, center=true);
			}
			translate([BowlerBoardHoleDist()+BowlerBoardInset(),BowlerBoardInset(),0])
			{
				square(MotorScrewBoltDiameter()*3, center=true);
			}
			translate([BowlerBoardHoleDist()+BowlerBoardInset(),BowlerBoardHoleDist()+BowlerBoardInset(),0])
			{
				square(MotorScrewBoltDiameter()*3, center=true);
			}
			translate([BowlerBoardInset(),BowlerBoardHoleDist()+BowlerBoardInset(),0])	
			{
				square(MotorScrewBoltDiameter()*3, center=true);
			}
		}
		translate([BowlerBoardInset(),BowlerBoardInset(),0])
		{
			circle(MotorScrewBoltDiameter()/2);
		}
		translate([BowlerBoardHoleDist()+BowlerBoardInset(),BowlerBoardInset(),0])
		{
			circle(MotorScrewBoltDiameter()/2);
		}
		translate([BowlerBoardHoleDist()+BowlerBoardInset(),BowlerBoardHoleDist()+BowlerBoardInset(),0])
		{
			circle(MotorScrewBoltDiameter()/2);
		}
		translate([BowlerBoardInset(),BowlerBoardHoleDist()+BowlerBoardInset(),0])	
		{
			circle(MotorScrewBoltDiameter()/2);
		}
	}
}


	// Maggie, this is the module to edit to add your auto-feed bed mounts
module bedPlate(){
	difference()
	{
		topPlate(axisMounts=false);
		CanvasHoles();
		translate([getCaseBoardThickness()*.95,getBaseSideLength()-BowlerBoardSideLength()-getCaseBoardThickness()-getInnerPlateTabPitch()/2,0])
		{
			BowlerBoardMount();			
		}
		translate([getBaseSideLength()/2+PlasticWidth()*2,getBaseSideLength()/2,0])
		{
			rotate([0,0,45])
			{
				translate([-CanvasPulleyMountHerringboneDistance()/2,-CanvasPulleySeperation()/2,0])
				{
					CanvasPulleyMount();
					translate([0,CanvasPulleySeperation(),0])
					{
						CanvasPulleyMount();
					}		
					translate([HerringBoneGearThickness()+StandardServoOutcrop()+PlasticWidth(),CanvasPulleyMotorMountOffset()-HiLoScrewHeadHeight()*4,0]) 
					{
						MotorMount();
					}
				}
			}
		}
	}
}

bedPlate();




//
//%square([1158.24,2194.56]);
//translate([getBaseSideLength()+10,getBaseSideLength()+10,0])
//	topPlate();
//bedPlate();
//translate([getBaseSideLength()+10,0,0])
//	topPlate();
//translate([0,getBaseSideLength()+10,0])
//	bearingPlate();
