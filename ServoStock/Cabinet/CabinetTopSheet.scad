use <../Axis/StructuralFeet.scad>
use <../Axis/Parameters.scad>
use <../Axis/RodEndClips.scad>	
use <../Axis/Clips.scad>	
use <../ContinuousBed/CanvasPulley.scad>
use <../../../Vitamins/Vitamins/Fasteners/Screws/High_Low_Screw_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/ScrewsAsBolts/Motor_Screw_As_Bolt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Kinematics/Belts/CanvasAsBelt_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/DrillPressSpring_Vitamin.scad>
use <../../../Vitamins/Threaded_Library/HerringBoneGear_Modified.scad>
use <../../../Vitamins/Vitamins/Electronics/Bowler_Board_Vitamin.scad>

function CuttingToolDiam()=(1/8)*25.4; //diameter of cutting tool, maximum width of any hole

scaleFactor = .01;
tabWidth = getInnerPlateTabPitch()/4;

module placeTabsMounts(){
	
	for (a = [	 getInnerPlateTabPitch()/2 :
		getInnerPlateTabPitch():
		getBaseSideLength()]){
		translate([0,a,0])
			children();

	}
}

module tabForInnerPlate(){
	square([getCaseBoardThickness()+.1,tabWidth]);
}

module getTabsForInnerPlate(addHoles=false){
	
	startOffset = getCaseBoardThickness()/2;
	
	placeTabsMounts(){
		if(addHoles){
			translate([-scaleFactor*startOffset,-scaleFactor*getInnerPlateTabPitch()/8])
			scale((1+scaleFactor))
			 tabForInnerPlate();
		}else{
			tabForInnerPlate();
		}
	}
	if(addHoles){
		placeTabsMounts(){
			translate([startOffset,
			           getInnerPlateTabPitch()*2/3,
			           0])
			           circle(getCaseHoleSize()/2, $fn=100);
		}
	}
}

module teeSlot(){
	nutWidth = getCaseHoleSize()*1.75;
	placeTabsMounts(){
		translate([getCaseBoardThickness(),
		           getInnerPlateTabPitch()*2/3-getCaseHoleSize()/2,
		           0]){
			square([getCaseHoleSize()*3 ,getCaseHoleSize() ]);
			translate([getCaseHoleSize(),-(nutWidth-getCaseHoleSize())/2,0])
				square([getCaseHoleSize() ,nutWidth ]);
		}
	}
}

module placeAllSlotElements(sideLength=10){
	translate([-sideLength/2,-sideLength/2,0]){
		children();
	
		rotate([0,0,90])
			translate([0,-sideLength,0]){
			children();
		}
		rotate([0,0,-90])
			translate([-(sideLength),0,0])
				children();
		rotate([0,0,180])
			translate([-(sideLength),-(sideLength),0])
				children();
	}
}

module squareWithMountHoles(sideLength=10, useTabs = false,bedCutout = false){
	holeSize=getCaseHoleSize();
	pitch=50;
	recessFromSide = getCaseBoardThickness()/2;
	useTeeSlots=true;
	difference(){
		square([sideLength,sideLength],center=true);
		
		for (a = [getCaseBoltHolePitch()+getCaseBoltHolePitch()/4:getCaseBoltHolePitch():sideLength-getCaseBoltHolePitch()]){
			translate([a-sideLength/2,sideLength/2-recessFromSide,0])
				circle(holeSize/2, $fn=100);
			translate([a-sideLength/2,-sideLength/2+recessFromSide,0])
				circle(holeSize/2, $fn=100);
			translate([sideLength/2-recessFromSide,a-sideLength/2,0])
				circle(holeSize/2, $fn=100);
			translate([-sideLength/2+recessFromSide,a-sideLength/2,0])
				circle(holeSize/2, $fn=100);
		}
		if(useTabs){
			difference(){
				square([sideLength+1,sideLength+1],center=true);
				square([sideLength-getCaseBoardThickness()*2,sideLength-getCaseBoardThickness()*2],center=true);
			}
		}
		if(! forceNoTSlots()){
			// This checks to see if the case hole is less then 4 times the board thickness
			if(getCaseBoardThickness()<(getCaseHoleSize()*4)){
				placeAllSlotElements(sideLength){
					teeSlot();
				}
			}
		}

	}
	placeAllSlotElements(sideLength){
		getTabsForInnerPlate();
	}
	
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
			circle(getBaseRadius()-10, $fn=100);
		}
		
		echo("Square side length is ",getBaseSideLength());
	}

}

module bearingPlate(){
	topPlate( bedCutout = true);
}


module CanvasPulleyMount(driven=true, wormgear=false)
{
	if(driven==true)
	{
		if(wormgear==false)
		{
			circle(HiLoScrewDiameter()/2, $fn=100);
			translate([0,CanvasPulleyWidth()/2,0])
			{
				circle(HiLoScrewDiameter()/2, $fn=100);
			}
			translate([CanvasPulleyMountHerringboneDistance(),0,0])
			{
				circle(HiLoScrewDiameter()/2, $fn=100);
			}
			translate([CanvasPulleyMountHerringboneDistance(),CanvasPulleyWidth()/2,0])
			{
				circle(HiLoScrewDiameter()/2, $fn=100);
			}
		}
		else
		{
		//put wormgear mount here if necessary
		}
	}
	else
	{
		circle(HiLoScrewDiameter()/2, $fn=100);
		translate([0,CanvasPulleyWidth()/2,0])
		{
			circle(HiLoScrewDiameter()/2, $fn=100);
		}
		translate([CanvasPulleyMountNonDrivenDistance(),0,0])
		{
			circle(HiLoScrewDiameter()/2, $fn=100);
		}
		translate([CanvasPulleyMountNonDrivenDistance(),CanvasPulleyWidth()/2,0])
		{
			circle(HiLoScrewDiameter()/2, $fn=100);
		}
	}
}


module MotorMount()
{
	rotate([0,0,90])
	{
		union()
		{
			circle(HiLoScrewDiameter()/2, $fn=100);
			translate([HerringboneMotorMountLength()-HiLoScrewHeadDiameter()*2,0,0])
			{
				circle(HiLoScrewDiameter()/2, $fn=100);
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
				translate([0,getPrintbedWidth()*1.4,0])
				{
					#square([CanvasPulleyLength(), CuttingToolDiam()]);
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
			square([BowlerBoardDepth(),BowlerBoardLength()]);
			translate([BowlerBoardInset(),BowlerBoardInset(),0])
			{
				square(MotorScrewBoltDiameter()*3, center=true);
			}
			translate([BowlerBoardInset(),BowlerBoardLength()-BowlerBoardInset(),0])
			{
				square(MotorScrewBoltDiameter()*3, center=true);
			}
			translate([BowlerBoardDepth()-BowlerBoardInset(),BowlerBoardLength()-BowlerBoardInset(),0])
			{
				square(MotorScrewBoltDiameter()*3, center=true);
			}
			translate([BowlerBoardDepth()-BowlerBoardInset(),BowlerBoardInset(),0])	
			{
				square(MotorScrewBoltDiameter()*3, center=true);
			}
		}
	translate([BowlerBoardInset(),BowlerBoardInset(),0])
			{
				circle(MotorScrewBoltDiameter()/2, $fn=100);
			}
			translate([BowlerBoardInset(),BowlerBoardLength()-BowlerBoardInset(),0])
			{
				circle(MotorScrewBoltDiameter()/2, $fn=100);
			}
			translate([BowlerBoardDepth()-BowlerBoardInset(),BowlerBoardLength()-BowlerBoardInset(),0])
			{
				circle(MotorScrewBoltDiameter()/2, $fn=100);
			}
			translate([BowlerBoardDepth()-BowlerBoardInset(),BowlerBoardInset(),0])	
			{
				circle(MotorScrewBoltDiameter()/2, $fn=100);
			}
	}
}

//BowlerBoardMount();

	// Maggie, this is the module to edit to add your auto-feed bed mounts
module bedPlate(){
	difference()
	{
		topPlate(axisMounts=false);
		CanvasHoles();
		translate([getCaseBoardThickness(),getBaseSideLength()-getCaseBoardThickness()-getInnerPlateTabPitch()*5/2-BowlerBoardLength(),0])
		{
			BowlerBoardMount();			
		}
		translate([getBaseSideLength()/2+PlasticWidth()*2,getBaseSideLength()/2,0])
		{
			rotate([0,0,45])
			{
				translate([-CanvasPulleyMountHerringboneDistance()/2,-CanvasPulleySeperation()/2,0])
				{
					CanvasPulleyMount(driven=true);
					translate([-DrillPressSpringWidth()+2,CanvasPulleySeperation(),0])
					{
						CanvasPulleyMount(driven=false);
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
