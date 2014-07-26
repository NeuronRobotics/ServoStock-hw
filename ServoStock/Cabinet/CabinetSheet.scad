function getThickness() = 18;
use <../Axis/StructuralFeet.scad>
use <../Axis/Parameters.scad>
use <../Axis/RodEndClips.scad>	
use <../Axis/Clips.scad>	


extraSideLength=140;
boardThickness = 19.05;
baseSideLength=getBaseRadius()*2+extraSideLength;

module squareWithMountHoles(sideLength=10){
	holeSize=7;
	pitch=45;
	recessFromSide = boardThickness/2;
	difference(){
		square([sideLength,sideLength],center=true);
		
		for (a = [pitch+pitch/4:pitch:sideLength-pitch]){
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
	echo("Square side length is ",baseSideLength);
	%square([sideLength-boardThickness*2,sideLength-boardThickness*2],center=true);
}

difference(){
	translate([0,extraSideLength/sqrt(2)-60,0])
		rotate([0,0,45])
			squareWithMountHoles(baseSideLength);
	for (a = [0:120:359]){
		rotate([0,0,a])
			translate([0,-getBaseRadius(),0]){
				//import (file = "FeetOutline.dxf", origin = 0);
				getStructuralFeetInterface();
				%StructuralFeet();
			}
					
	}
	translate([0,extraSideLength*2.5,0])
		square([500,getBaseRadius()*2+extraSideLength],center=true);
	
}






//getStructuralFeetInterface();