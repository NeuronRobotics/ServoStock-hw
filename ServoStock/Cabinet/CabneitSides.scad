use <../Axis/Parameters.scad>
use <CabinetTopSheet.scad>

function getBedZHeight() = 110+getCaseBoardThickness();



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
		// Inner bed plate mounts
		translate([0, getBedZHeight(),0 ]){
			for (a = [	getInnerPlateTabPitch()+getInnerPlateTabPitch()/4:
						getInnerPlateTabPitch():
						getBaseSideLength()-getInnerPlateTabPitch()]){
				translate([a-getInnerPlateTabPitch()/2+getInnerPlateTabPitch()/6,getCaseBoardThickness()/2,0])
					circle(getCaseHoleSize()/2);
				
				
			}
			// slots for tabs
			if(usePlateMountSlots){
				translate([getBaseSideLength()/2+getCaseBoardThickness(),0,0]){
					rotate([0,0,90])
						getTabsForInnerPlate();
				}
				
			}
		
		}
		// Inner bed plate mounts
		translate([0, getBedZHeight()*2+getCaseBoardThickness(),0 ]){
			for (a = [	getInnerPlateTabPitch()+getInnerPlateTabPitch()/4:
						getInnerPlateTabPitch():
						getBaseSideLength()-getInnerPlateTabPitch()]){
				translate([a-getInnerPlateTabPitch()/2+getInnerPlateTabPitch()/6,getCaseBoardThickness()/2,0])
					circle(getCaseHoleSize()/2);
				
				
			}
			// slots for tabs
			if(usePlateMountSlots){
				translate([getBaseSideLength()/2+getCaseBoardThickness(),0,0]){
					rotate([0,0,90])
						getTabsForInnerPlate();
				}
				
			}
		
		}
	}

}

module shortSide(left=true){
	union(){
		longSide(getShortSideLength());
		//Eliminating the tabs and holes on the front
		if(left){
			square([getCaseBoardThickness()+5,getCabinetHeight() ]);
		}else{
			translate([getShortSideLength()-getCaseBoardThickness()-5,0,0])
				square([getCaseBoardThickness()+5,getCabinetHeight() ]);
		}
		
	}
}

longSide(getBaseSideLength(),usePlateMountSlots = true);

translate([-getBaseSideLength()-10 ,
           ,
           0])
           rotate([0,0,0])
longSide(getBaseSideLength(),usePlateMountSlots = true);

translate([getBaseSideLength()+10 ,
           0,
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