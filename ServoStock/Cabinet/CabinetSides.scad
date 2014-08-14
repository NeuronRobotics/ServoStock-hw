use <../Axis/Parameters.scad>
use <CabinetTopSheet.scad>
use <../ContinuousBed/CanvasPulley.scad>
use <../../../Vitamins/Vitamins/Electronics/Bowler_Board_Vitamin.scad>
use <../../../Vitamins/Vitamins/Electronics/Power_Supply_Vitamin.scad>

module innerPlateMounts(usePlateMountSlots = false){
	
	// slots for tabs
	if(usePlateMountSlots){
		translate([0,getCaseBoardThickness(),0]){
			rotate([0,0,-90])
			getTabsForInnerPlate(addHoles=true);
		}
	}
}

module longSideBase(width =getBaseSideLength(), usePlateMountSlots = true ){
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
		translate([0, getBedZHeight()+ getBedToBearingPlateHeight(),0 ]){
			innerPlateMounts(usePlateMountSlots);
		}
	}

}

module BowlerBoardAccessSlot()
{
	square([BowlerBoardSideLength(), BowlerBoardHeight()*1.5]);
}

module PowerSupplyMount()
{
	union()
	{
		difference()
		{
			square([PowerSupplyLength(),PowerSupplyHeight()]);
			translate([PowerSupplyTopBoltInset(),PowerSupplyHeight()-PowerSupplyTopBoltInset(),0])
			{
				square(PowerSupplyBoltDiameter()*3, center=true);
			}
			translate([PowerSupplyLength()-PowerSupplyTopBoltInset(),PowerSupplyHeight()-PowerSupplyTopBoltInset(),0])
			{
				square(PowerSupplyBoltDiameter()*3, center=true);
			}
			square([PowerSupplyBoltDiameter()*3,PowerSupplyBoltDiameter()*3+PowerSupplyBottomLeftBoltHeightInset()]);
			translate([PowerSupplyLength()-PowerSupplyBottomRightBoltLengthInset()-PowerSupplyBoltDiameter()*3,0,0])	
			{
				square([PowerSupplyBoltDiameter()*3+PowerSupplyBottomRightBoltLengthInset(),PowerSupplyBoltDiameter()*3]);
			}
		}
		translate([PowerSupplyTopBoltInset(),PowerSupplyHeight()-PowerSupplyTopBoltInset(),0])
		{
			circle(PowerSupplyBoltDiameter()/2, center=true);
		}
		translate([PowerSupplyLength()-PowerSupplyTopBoltInset(),PowerSupplyHeight()-PowerSupplyTopBoltInset(),0])
		{
			circle(PowerSupplyBoltDiameter()/2, center=true);
		}
		translate([PowerSupplyBottomLeftBoltLengthInset(),PowerSupplyBottomLeftBoltHeightInset(),0])
		{
			circle(PowerSupplyBoltDiameter()/2, center=true);
		}
		translate([PowerSupplyLength()-PowerSupplyBottomRightBoltLengthInset(),PowerSupplyBottomRightBoltHeightInset(),0])	
		{
			circle(PowerSupplyBoltDiameter()/2, center=true);
		}
	}
}



module longSide(width =getBaseSideLength(), usePlateMountSlots = true, mounts=false)
{
	if (mounts==true)
	{
		difference()
		{
			longSideBase(width, usePlateMountSlots);
			translate([getBaseSideLength()-BowlerBoardSideLength()*2,getBedZHeight()-getCaseBoardThickness()+BowlerBoardHeight()/2,0])
			{
				BowlerBoardAccessSlot();
			}
			translate([getBaseSideLength()-PowerSupplyLength()-getCaseBoardThickness()*2,getBedZHeight()-getCaseBoardThickness()-PowerSupplyHeight()-(CanvasPulleyEffectiveHeight()+CanvasPulleyWidth()/1.5),0])
			{
				PowerSupplyMount();
			}
		}
	}else{
		longSideBase(width, usePlateMountSlots);
	}
}

longSide(mounts=true);

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
	//%square([40*25.4,75*25.4]);
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
//	fullSheet();
