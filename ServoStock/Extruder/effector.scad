include <../Axis/Parameters.scad>
use <../../../Vitamins/Vitamins/Structural/RodEnds/RodEnd_Vitamin.scad>
use <../../../Vitamins/Vitamins/Electronics/Hot_Ends/PrintrBotJHeadHotEnd_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/Standard_Extruder_Spacing_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/Filament_Vitamin.scad>
use <ExtruderMKII.scad>


// Distance between ball joint mounting faces.
separation = RodEndSpacing()-RodEndBallSwivelFlangeHeight(.1);

heightOfPilar = RodEndSpacing();

offset = getEffectorRadius();  
// Hotend mounting screws, standard would be 25mm.
mount_radius = StandardExtruderSpacing()/2; 
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 12;
cone_r1 = 2.5;
cone_r2 = 21;
cone_h = cone_r2;
m3_radius=(3.8+.3)/2;
m3_nut_radius=(7.5/2);
m3_wide_radius=m3_radius+.5;

translate([0, 0, height/2])
	effector(true);


//rotate([0,0,90])translate([0,0,height/2])
//	Extruder();


module verticalConnector(){
	rotate([0,90,0]){
		translate([-separation/2,0,height])
			difference(){
				flatConnector(90);

			}
	}
}

module effector(useVertical=false) {
	echo("Separation = ",separation);
	echo("Offset = ",offset);
	startAngle = 77;
  difference() {
	union() translate([0,0,-.1]){
		cylinder(r=offset-6, h=height, center=true, $fn=60);
		translate([offset/3,-5,0])
			cube([offset*1.5,offset*.7, height], center=true);

	  	cube([m3_wide_radius*6,mount_radius*2, height], center=true);
		rotate([0,0,30])
			translate([0,offset/3,0])
	  			cube([m3_wide_radius*6,mount_radius*1.5, height], center=true);
      for (a = [startAngle:120:359]) rotate([0, 0, a]) {
			
			if(a==197){
				translate([0, offset/2, 0]){
					//%cube([separation, offset, height], center=true);
				}
				flatConnector();
			}else{
				if(useVertical){
    	  			verticalConnector();
					translate([0, offset/2, heightOfPilar/2]){
						rotate([0,90,0]){
							//%cube([heightOfPilar, offset, height], center=true);
						}
					}
				}	
				else
					flatConnector();
			}
      }
    	for (a = [0:180:359]) rotate([0, 0, a]) {
      		translate([0, mount_radius, 0])
				cylinder(r=m3_wide_radius*3, h=height, center=true, $fn=12);
    	}
    	//cross bracing
		translate([offset/3,offset-3,RodEndSpacing()/2])
		rotate([0,0,-25])
    	union(){
    		rotate([0,45,0])
    				cylinder(r=height/3,h=RodEndSpacing()-20,center=true);
    		rotate([0,-45,0])
					cylinder(r=height/3,h=RodEndSpacing()-20,center=true);
    	}
    }
	for (a = [startAngle:120:359]) rotate([0, 90, a]) {
		
		translate([0+.1,
		           offset,
		           cone_h/2+2+height])
			cube([height,m3_nut_radius*2, m3_nut_radius*2], center=true);
	}
	translate([0,0,-height/2-1])
		cylinder(r=RodEndSpacing(),h=1,center=false);
    translate([0, 0, push_fit_height-height*2])
		rotate([0,-90,0])
			HotEnd(true,.4);
		for (a = [0:180:359]) rotate([0, 0, a]) {
      		translate([0, mount_radius, 0])

				cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
				
    	}

  }
}

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
						translate([0,0,-cone_h+6])
		      				cylinder(r=m3_nut_radius, h=cone_h, center=true, $fn=6);
				}
}

module myMount(vert=0,verticalRot =0){
	
	  translate([vert*-1+(vert/2), offset, 0]){
			if(verticalRot==0)
			 	rotate([0,180*-1,0])
					mount();
			else{
				rotate([-1*90,verticalRot,0])
					translate([height/2,0,0])
						mount();
			}
	  }
	  
	  translate([(separation/2), offset, 0]){
			if(verticalRot==0)
			 	rotate([0,0,0])
					mount();
			else{
				rotate([0,verticalRot,0])
					translate([height/2,0,0])
						mount();
			}
	  }
  
}

module flatConnector(verticalRot =0){
	pillarOffset = 12;
	if(verticalRot==0){
		//horozontal rod
		rotate([0, 0, 0]) 
			translate([0,offset-height-1, 0]){
	  			cube([RodEndSpacing()-cone_h*2, height*1.2, height], center=true);
			
		}
		
		myMount(separation,verticalRot);
	}else{
			// vertical rod
		
			rotate([0, 0, 0]) 
				translate([0,offset, height-2]){
	  				cube([RodEndSpacing()*.86, height, height], center=true);
				}
			rotate([0, -90, 0]) 
				translate([0,offset,(-RodEndSpacing()/2)-(height*.185)]){
					intersection(){
						//Upright pilar section
						translate([pillarOffset,0,0])
							cylinder(	r1=18, 
									r2=6, 
									h=RodEndSpacing()+(RodEndBallSwivelFlangeHeight(.1))-10, 
									center=false,
									$fn=24);
						
							difference(){
								union(){
									translate([pillarOffset,0,0]){
										for (a = [0:60:120])rotate([0,0,a]){
											translate([0,-height/2,0])
														cube([height*4, height, RodEndSpacing()+height], center=false);
										}
									}
									cube([height*6, height*6, height], center=false);
								}
								translate([height*2,0,height*.5])
									rotate([0, -90, 0])
										cylinder(r=m3_nut_radius+.1, h=cone_h*3, center=true, $fn=24);
							}
							
						
							
						
					}
					translate([1,-height/2,height])
						cube([height-1, height, RodEndSpacing()-10], center=false);
				}
			
			myMount(heightOfPilar+RodEndBallSwivelFlangeHeight(.1),verticalRot);
	}

}







