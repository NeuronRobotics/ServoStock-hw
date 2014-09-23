
use <../Axis/Parameters.scad>
use <CabinetTopSheet.scad>
use <CabinetSides.scad>
use <../ContinuousBed/CanvasPulley.scad>
use <../../../Vitamins/Vitamins/Electronics/Bowler_Board_Vitamin.scad>
use <../../../Vitamins/Vitamins/Electronics/Power_Supply_Vitamin.scad>


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