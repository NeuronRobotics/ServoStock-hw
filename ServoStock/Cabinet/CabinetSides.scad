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
				circle(getCaseHoleSize()/2, $fn=100);
				//cutout for the tabs
				translate([-getCaseBoardThickness()/2,getCaseBoltHolePitch()/4])
					square([getCaseBoardThickness()+.1,getCaseBoltHolePitch()/2]);
			}
			translate([width-getCaseBoardThickness()/2,
			           a-getCaseBoltHolePitch()/2,
			           0]){
				//bolt hole
				circle(getCaseHoleSize()/2, $fn=100);
				//cutout for the tabs
				translate([-getCaseBoardThickness()/2,getCaseBoltHolePitch()/4])
					square([getCaseBoardThickness()+.1,getCaseBoltHolePitch()/2]);
				
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
	square([BowlerBoardLength(), BowlerBoardHeight()*1.5]);
}

module PowerSupplyBoltHole()
{
	circle(PowerSupplyBoltDiameter()/2, center=true, $fn=100);
}

module PowerSupplyFrontMount()
{
	union()
	{
		difference()
		{
			square([PowerSupplyLength(),PowerSupplyHeight()]);
			translate([PowerSupplyFrontTopBoltInset(),PowerSupplyHeight()-PowerSupplyFrontTopBoltInset(),0])
			{
				square(PowerSupplyBoltDiameter()*3, center=true);
			}
			translate([PowerSupplyLength()-PowerSupplyFrontTopBoltInset(),PowerSupplyHeight()-PowerSupplyFrontTopBoltInset(),0])
			{
				square(PowerSupplyBoltDiameter()*3, center=true);
			}
			square([PowerSupplyBoltDiameter()*3,PowerSupplyBoltDiameter()*3+PowerSupplyFrontBottomLeftBoltHeightInset()]);
			translate([PowerSupplyLength()-PowerSupplyFrontBottomRightBoltLengthInset()-PowerSupplyBoltDiameter()*3,0,0])	
			{
				square([PowerSupplyBoltDiameter()*3+PowerSupplyFrontBottomRightBoltLengthInset(),PowerSupplyBoltDiameter()*3]);
			}
		}
		translate([PowerSupplyFrontTopBoltInset(),PowerSupplyHeight()-PowerSupplyFrontTopBoltInset(),0])
		{
			PowerSupplyBoltHole();
		}
		translate([PowerSupplyLength()-PowerSupplyFrontTopBoltInset(),PowerSupplyHeight()-PowerSupplyFrontTopBoltInset(),0])
		{
			PowerSupplyBoltHole();
		}
		translate([PowerSupplyFrontBottomLeftBoltLengthInset(),PowerSupplyFrontBottomLeftBoltHeightInset(),0])
		{
			PowerSupplyBoltHole();
		}
		translate([PowerSupplyLength()-PowerSupplyFrontBottomRightBoltLengthInset(),PowerSupplyFrontBottomRightBoltHeightInset(),0])	
		{
			PowerSupplyBoltHole();
		}
////////gets rid of bottom two mounts, which are awkward and inconvient to cut out, remove this to get them back
		translate([PowerSupplyLength()/2,0,0])
		{
			square([PowerSupplyLength(), PowerSupplyHeight()]);
		}		
	}
}

module PowerSupplySideMount()
{
	union()
	{
		translate([PowerSupplySideRightBoltLengthInset(),PowerSupplySideBoltHeightInset(),0])
		{
			PowerSupplyBoltHole();
		}
		translate([PowerSupplySideRightBoltLengthInset(),PowerSupplyLength()-PowerSupplySideBoltHeightInset(),0])
		{
			PowerSupplyBoltHole();
		}
		translate([PowerSupplyDepth()-PowerSupplySideLeftBoltLengthInset(),PowerSupplySideBoltHeightInset(),0])
		{
			PowerSupplyBoltHole();
		}
		translate([PowerSupplyDepth()-PowerSupplySideLeftBoltLengthInset(),PowerSupplyLength()-PowerSupplySideBoltHeightInset(),0])
		{
			PowerSupplyBoltHole();
		}	
	}
}

//if you want to get a visual of where the mount holes are compared to the side of the power supply
//PowerSupplySideMount();
//%square([PowerSupplyDepth(),PowerSupplyLength()]);



module longSide(width =getBaseSideLength(), usePlateMountSlots = true, mounts=1)
{
	if (mounts==1)
	{
		difference()
		{
			longSideBase(width, usePlateMountSlots);
			translate([getBaseSideLength()-getCaseBoardThickness()-getInnerPlateTabPitch()*5/2-BowlerBoardLength(),getBedZHeight()-getCaseBoardThickness(),0])
			{
				BowlerBoardAccessSlot();
			}
			translate([getBaseSideLength()-getCaseBoardThickness(),getBedZHeight()-getCaseBoardThickness()/2,0])
			{
				mirror([1,0,0])
				{
					rotate([0,0,-90])
					{
						PowerSupplyFrontMount();
					}
				}
			}
		}
	}else{
	if (mounts==2)
	{
		difference()
		{
			longSideBase(width, usePlateMountSlots);
			translate([getCaseBoardThickness(),getBedZHeight()-getCaseBoardThickness()/2-PowerSupplyLength(),0])
			{
				PowerSupplySideMount();					
			}
		}
	}else{
		longSideBase(width, usePlateMountSlots);
	}
}
}

//longSide(mounts=2);

module shortSide(left=true){
	if(left){
		intersection(){
			translate([-(getBaseSideLength()-getShortSideLength()),0,0])
			longSide(getBaseSideLength(),usePlateMountSlots = true, mounts=3);
			square([getShortSideLength(),getCabinetHeight()]);
		}
		
	}else{
		intersection(){
			longSide(getBaseSideLength(),usePlateMountSlots = true, mounts=3);
			square([getShortSideLength(),getCabinetHeight()]);
		}
	}
}
module sides(){
	translate([0,getBaseSideLength()*3+getShortSideLength()+30])
		rotate([0,0,-90]){
			longSide(getBaseSideLength(),usePlateMountSlots = true, mounts=1);
			
			translate([-getBaseSideLength()-10 ,
			           0,
			           0])
			           rotate([0,0,0])
			longSide(getBaseSideLength(),usePlateMountSlots = true, mounts=2);
			
			translate([getBaseSideLength()+10 ,
			           0,
			           0])
			shortSide(false);
			
			translate([(getBaseSideLength()+getShortSideLength()+20),
			           0,
			           0])
				shortSide(true);
	}
}

module fullSheet(){

	sides();
	translate([0,0,-1]){
		%square([40*25.4,75*25.4]);
	}
	yOffset=80;
	translate([140,getBaseSideLength()*sqrt(2)+yOffset,0])
		rotate([0,0,45+180])
			topPlate();
	
	translate([(40*25)-130,0+yOffset,0])
		rotate([0,0,45])
			bedPlate();//topPlate();

	translate([210,60+yOffset,0])
		rotate([0,0,45-90])
			bearingPlate();

}

module tabCompare(){

	longSide(getBaseSideLength(),usePlateMountSlots = true, mounts=2);
	translate([ 0,
	            -getBaseSideLength(),
	            0])
	            rotate([0,0,90])
	            	longSide(getBaseSideLength(),usePlateMountSlots = true, mounts=1);
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
