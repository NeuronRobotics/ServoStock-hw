include <../Axis/Parameters.scad>
use <../../../Vitamins/Vitamins/Structural/RodEnds/RodEnd_Vitamin.scad>
use <../../../Vitamins/Vitamins/Electronics/Hot_Ends/PrintrBotJHeadHotEnd_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/Standard_Extruder_Spacing_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/Filament_Vitamin.scad>
use <ExtruderMKII.scad>


// Distance between ball joint mounting faces.
separation = RodEndSpacing()-RodEndBallSwivelFlangeHeight(.1);  

offset = separation/3;  
// Hotend mounting screws, standard would be 25mm.
mount_radius = StandardExtruderSpacing()/2; 
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;
cone_h = 14;
m3_radius=2.4/2;
m3_nut_radius=6.3/2;
m3_wide_radius=m3_radius+.5;


module mount(){
				translate([-cone_h /2,0,0])
				difference() {
		    		intersection() {
		      			cube([separation, 40, height], center=true);
		      			translate([0, -4, 0]) rotate([0, 90, 0]){
							cylinder(r=10, h=separation, center=true);
						}
		      			rotate([0, 90, 0]){
							cylinder(r1=cone_r2, r2=cone_r1, h=cone_h, center=true, $fn=24);
						}
		    		}
		    		rotate([0, 90, 0])
		      			cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
		    		rotate([90, 0, 90])
						translate([0,0,-6])
		      				cylinder(r=m3_nut_radius, h=6, center=true, $fn=6);
				}
}

module flatConnector(verticalRot =0){
	rotate([0, 0, 0]) 
		translate([0,offset*.75, 0]){
	  		cube([RodEndSpacing()*.85, offset*.3, height], center=true);
			
		}
	for (s = [-1, 0]) {
			
		  translate([separation*s+(separation/2), offset, 0]){
				 rotate([0,180*s,0])
					rotate([0,0,0])
						mount();
		  }
    }
}

module verticalConnector(){
	rotate([0,90,0]){
		translate([-separation/2,0,height])
			flatConnector(90);
	}
}


module effector() {
  difference() {
    union() {
      cylinder(r=offset-3, h=height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
			
			if(a==180){
				translate([0, offset/2, 0])
					%cube([separation, offset, height], center=true);
				flatConnector();
			}else{
				translate([0, offset/2, separation/2])
					rotate([0,90,0])
						%cube([separation, offset, height], center=true);
    	  		verticalConnector();
			}
      }
    }
    translate([0, 0, push_fit_height-height*2])
		rotate([0,-90,0])
      	HotEnd(true,.4);

    for (a = [0:60:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
      	cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }
  }
}

translate([0, 0, height/2]) effector();
%rotate([0,0,90])color("red")Extruder();