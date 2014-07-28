function getThickness() = 18;
use <../Axis/StructuralFeet.scad>
use <../Axis/Parameters.scad>
use <../Axis/RodEndClips.scad>	
use <../Axis/Clips.scad>	


extraSideLength=140;

function getBaseSideLength() = getBaseRadius()*2+extraSideLength;
function getCaseBoltHolePitch() = 200;
function getCaseHoleSize() = 4.5;
function getShortSideLength() = 140;

function getInnerPlateTabPitch() = getBaseSideLength()/4;

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


module topPlate(useTabs = false,bedCutout = false){
	fudge = extraSideLength/sqrt(2)-60;
	
	translate([getBaseSideLength()/2 -fudge/sqrt(2) ,getBaseSideLength()/2 +fudge/sqrt(2),0])
	rotate([0,0,-45-90])
	difference(){
		translate([0,extraSideLength/sqrt(2)-60,0])
			rotate([0,0,45])
				squareWithMountHoles(getBaseSideLength(),useTabs,bedCutout);
		for (a = [0:120:359]){
			rotate([0,0,a])
				translate([0,-getBaseRadius(),0]){
					//import (file = "FeetOutline.dxf", origin = 0);
					getStructuralFeetInterface();
					//%StructuralFeet();
				}
						
		}
		if(bedCutout){
			translate([0,getPrintbedWidth()/1.5,0]){
				square([getPrintbedWidth(),
				        getPrintbedWidth()*2],center=true);
			}
			circle(getBaseRadius()-10);
		}
		translate([0,extraSideLength*2.5,0])
			square([500,getBaseRadius()*2+extraSideLength],center=true);
		echo("Square side length is ",getBaseSideLength());
	}

}

module bearingPlate(){
	topPlate(useTabs = true, bedCutout = true);
}

module bedPlate(){
		topPlate(useTabs = true);
}

%square([1158.24,2194.56]);
translate([getBaseSideLength()+10,getBaseSideLength()+10,0])
	topPlate();
bedPlate();
translate([getBaseSideLength()+10,0,0])
	topPlate();
translate([0,getBaseSideLength()+10,0])
	bearingPlate();