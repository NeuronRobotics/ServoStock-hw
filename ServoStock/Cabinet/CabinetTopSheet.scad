function getThickness() = 18;
use <../Axis/StructuralFeet.scad>
use <../Axis/Parameters.scad>
use <../Axis/RodEndClips.scad>	
use <../Axis/Clips.scad>	


extraSideLength=140;

function getBaseSideLength() = getBaseRadius()*2+extraSideLength;
function getCaseBoltHolePitch() = 50;
function getCaseHoleSize() = 4.5;
function getShortSideLength() = 140;


module squareWithMountHoles(sideLength=10){
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
	}
	
	//%square([sideLength-getCaseBoardThickness()*2,sideLength-getCaseBoardThickness()*2],center=true);
}


module topPlate(){

	difference(){
		translate([0,extraSideLength/sqrt(2)-60,0])
			rotate([0,0,45])
				squareWithMountHoles(getBaseSideLength());
		for (a = [0:120:359]){
			rotate([0,0,a])
				translate([0,-getBaseRadius(),0]){
					//import (file = "FeetOutline.dxf", origin = 0);
					getStructuralFeetInterface();
					//%StructuralFeet();
				}
						
		}
		translate([0,extraSideLength*2.5,0])
			square([500,getBaseRadius()*2+extraSideLength],center=true);
		echo("Square side length is ",getBaseSideLength());
	}

}

module bearingPlate(){
	difference(){
		intersection(){
			topPlate();
			translate([0,getCaseBoardThickness()*2,0])
				rotate([0,0,45])
					square([getBaseSideLength()-getCaseBoardThickness()*2,
					        getBaseSideLength()-getCaseBoardThickness()*2],center=true);
		}
		translate([0,getPrintbedWidth()/1.5,0])
			square([getPrintbedWidth(),
			        getPrintbedWidth()*2],center=true);
		circle(getBaseRadius()-10);
	}
}


translate([0,-getBaseRadius()-10,0])
	topPlate();
translate([0,getBaseRadius(),0])
rotate([0,0,180])
	bearingPlate();
//getStructuralFeetInterface();