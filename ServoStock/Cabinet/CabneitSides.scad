use <../Axis/Parameters.scad>
use <CabinetTopSheet.scad>



module longSide(width =getBaseSideLength() ){
	difference(){
		square([width,getCabinetHeight() ]);
		
		for (a = [	getCaseBoltHolePitch()/4:
					getCaseBoltHolePitch():
					getCabinetHeight()]){
			translate([getCaseBoardThickness()/2,
			           a,
			           0]){
				circle(getCaseHoleSize()/2);
				translate([-getCaseBoardThickness()/2,getCaseBoltHolePitch()/4])
					square([getCaseBoardThickness(),getCaseBoltHolePitch()/2]);
			}
			translate([width-getCaseBoardThickness()/2,
			           a-getCaseBoltHolePitch()/2,
			           0]){
				circle(getCaseHoleSize()/2);
				translate([-getCaseBoardThickness()/2,getCaseBoltHolePitch()/4])
					square([getCaseBoardThickness(),getCaseBoltHolePitch()/2]);
			}
			
		}
	}

}

module shortSide(left=true){
	union(){
		longSide(getShortSideLength());
		if(left){
			square([getCaseBoardThickness()+5,getCabinetHeight() ]);
		}else{
			translate([getShortSideLength()-getCaseBoardThickness()-5,0,0])
				square([getCaseBoardThickness()+5,getCabinetHeight() ]);
		}
		
	}
}

longSide(getBaseSideLength());

translate([-getBaseSideLength()-10 ,
           0,
           0])
longSide(getBaseSideLength());

translate([getBaseSideLength()+10 ,
           ,
           0])
rotate([0,0,0])
shortSide(false);

translate([-getBaseSideLength()-getShortSideLength()-20 ,
           ,
           0])
rotate([0,0,0])
shortSide(true);

translate([getBaseSideLength()/2 -getCaseBoardThickness()*1.5 ,-getBaseSideLength()/2 +getCaseBoardThickness()*1.5,0])
	rotate([0,0,-45-90])
		%bearingPlate();