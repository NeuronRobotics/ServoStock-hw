use <../Axis/Parameters.scad>
use <CabinetTopSheet.scad>

function getBedZHeight() = 150+getCaseBoardThickness();
//function getBedZHeight() = 0;

module innerPlateMounts(usePlateMountSlots = false){
	
	// slots for tabs
	if(usePlateMountSlots){
		translate([0,getCaseBoardThickness(),0]){
			rotate([0,0,-90])
			getTabsForInnerPlate(addHoles=true);
		}
	}
}

module longSide(width =getBaseSideLength(), usePlateMountSlots = false ){
	difference(){
		square([width,getCabinetHeight() ]);
		
		for (a = [	getCaseBoltHolePitch()/4:
					getCaseBoltHolePitch():
					getCabinetHeight()]){
			translate([getCaseBoardThickness()/2,
			           a,
			           0]){
				//bolt hole
				circle(getCaseHoleSize()/2);
				//cutout for the tabs
				translate([-getCaseBoardThickness()/2,getCaseBoltHolePitch()/4])
					square([getCaseBoardThickness(),getCaseBoltHolePitch()/2]);
			}
			translate([width-getCaseBoardThickness()/2,
			           a-getCaseBoltHolePitch()/2,
			           0]){
				//bolt hole
				circle(getCaseHoleSize()/2);
				//cutout for the tabs
				translate([-getCaseBoardThickness()/2,getCaseBoltHolePitch()/4])
					square([getCaseBoardThickness(),getCaseBoltHolePitch()/2]);
				
			}
			
		}
		
		// Top plate mount
		translate([0, getCabinetHeight()- MotorBracketHeight()-getCaseBoardThickness(),0 ]){
			innerPlateMounts(usePlateMountSlots);
		
		}

		// Inner bed plate mounts
		translate([0, getBedZHeight(),0 ]){
			innerPlateMounts(usePlateMountSlots);
		
		}
		// Inner bed plate mounts
		translate([0, getBedZHeight()+100,0 ]){
			innerPlateMounts(usePlateMountSlots);
		}
	}

}

module shortSide(left=true){
	if(left){
		intersection(){
			translate([-(getBaseSideLength()-getShortSideLength()),0,0])
			longSide(getBaseSideLength(),usePlateMountSlots = true);
			square([getShortSideLength(),getCabinetHeight()]);
		}
		
	}else{
		intersection(){
			longSide(getBaseSideLength(),usePlateMountSlots = true);
			square([getShortSideLength(),getCabinetHeight()]);
		}
	}
}
module sides(){
	translate([0,getBaseSideLength()*3+getShortSideLength()+30])
		rotate([0,0,-90]){
			longSide(getBaseSideLength(),usePlateMountSlots = true);
			
			translate([-getBaseSideLength()-10 ,
			           0,
			           0])
			           rotate([0,0,0])
			longSide(getBaseSideLength(),usePlateMountSlots = true);
			
			translate([getBaseSideLength()+10 ,
			           0,
			           0])
			shortSide(false);
			
			translate([getBaseSideLength(),
			           getCabinetHeight()+10,
			           0])
			rotate([0,0,90])
				shortSide(true);
	}
}

module fullSheet(){

	sides();
	%square([40*25.4,75*25.4]);
	topPlate();
	translate([getBaseSideLength()+10,getBaseSideLength()+10,0])
		bedPlate();//topPlate();

	translate([0,getBaseSideLength()+10,0])
		bearingPlate();

}

module tabCompare(){

	longSide(getBaseSideLength(),usePlateMountSlots = true);
	translate([ 0,
	            -getBaseSideLength(),
	            0])
	            rotate([0,0,90])
	            	longSide(getBaseSideLength(),usePlateMountSlots = true);
	translate([ 0,
	            -getBaseSideLength(),
	            0])
	            bedPlate();
	
	translate([ getShortSideLength(),
	            -getBaseSideLength(),
	            0])
	            rotate([0,0,180])
	            	shortSide(left=true);
	
    rotate([0,0,-90])
    translate([ 0,
                getBaseSideLength(),
	            0])
    	shortSide(left=false);
}   


//tabCompare();

//scale(1/6)
	fullSheet();
