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
m3_nut_radius=(7.75/2)+.25;
m3_wide_radius=m3_radius+.5;
bracelen=RodEndSpacing()-30;
hotEndOffset=-15;
pillarOffset = 12;

translate([0, 0, height/2])
	effector(true);

translate([0,hotEndOffset, 0]){
	rotate([0,0,90]){
		translate([0,0,0]){
			//Extruder();
		}
	}
}

module verticalConnector(){

	flatConnector(90);

			
	
}

module braceRod(){
	translate([0,0,bracelen/2]){
		cylinder(r1=height/3,r2=0,h=bracelen/4,center=false);
	}
	translate([0,0,bracelen/2]){
		cylinder(r1=height/3,r2=0,h=bracelen/4,center=false);
	}
	translate([0,0,-20])
	cylinder(r=height/3,h=bracelen+40,center=true);
}

module effector(useVertical=false) {
	echo("Separation = ",separation);
	echo("Offset = ",offset);
	startAngle = 60;
	boltLength=1.2*25.4;

	difference() {
		union() translate([0,0,-.1]){
			translate([0, hotEndOffset, 0])
					cylinder(r=offset*1.2, h=height, center=true, $fn=60);
			translate([0,-offset,0])
				cube([separation*.7,offset*.5, height], center=true);
			translate([offset/3+2,-5,0])
				cube([offset*1.5,offset*.7, height], center=true);
			translate([0, hotEndOffset, 0])
				cube([m3_wide_radius*6,mount_radius*2, height], center=true);
			rotate([0,0,7])
				translate([0,offset/2,0])
					cube([m3_wide_radius*6,mount_radius*2.3, height], center=true);
			for (a = [startAngle:120:359]) rotate([0, 0, a]) {
				
				if(a==120+startAngle){
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
			translate([0, hotEndOffset, 0])
			for (a = [0:180:359]) rotate([0, 0, a]) {
				translate([0, mount_radius, 0])
					cylinder(r=m3_wide_radius*3, h=height, center=true, $fn=12);
			}
			//cross bracing
			rotate([0,0,-startAngle/1.7])
				translate([offset/3-6,offset-6,RodEndSpacing()/2])

					union(){
						rotate([0,30,0])
							braceRod();
						rotate([0,-30,0])
							braceRod();
					}
		}
		for (a = [startAngle:120:359]) rotate([0, 90, a]) {
			

			translate([0,
								   offset,
								   0])
			cylinder(r=m3_radius, h=RodEndSpacing(), center=true);
			if( a== startAngle || a == 240+startAngle){
				translate([0,
						   offset,
						   -boltLength+RodEndBallSwivelFlangeHeight(.1)-1.5])

				cylinder(r=m3_radius*2.5, h=boltLength, center=false);
				translate([0,
						   offset,
						   cone_h/2+5+height]){
							translate([2.2,0,0])
								cube([height,6.7, m3_nut_radius], center=true);
			      			//cylinder(r=m3_nut_radius, h=cone_h, center=true, $fn=6);
				}
			}else{
				translate([2.2,offset,-(separation/2-20)])
					cube([height,6.7, m3_nut_radius], center=true);
				translate([2.2,offset,separation/2-21])
					cube([height,6.7, m3_nut_radius], center=true);
			}
		}
		translate([0,0,-height/2])
		rotate([0,180,0])
			cylinder(r=RodEndSpacing(),h=20,center=false);
		//Hot End Hole
		translate([0, hotEndOffset, -height/2-.1])
			cylinder(r1=HotEndDiam()/1.2 ,r2=HotEndDiam()/2 ,h=height+1)	;	
		translate([0, hotEndOffset, 0])
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
							cylinder(r1=cone_r2*1.75, r2=cone_r1, h=cone_h, center=true, $fn=24);
						}
		    		}
		    		rotate([0, 90, 0])
		    			cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
//		    		rotate([90, 30, 90])
//						translate([0,0,-cone_h+6])
//		      				cylinder(r=m3_nut_radius, h=cone_h, center=true, $fn=6);
				}
}

module myMount(vert=0,verticalRot =0){
	
	  translate([vert*-1+(vert/2), offset, 0]){
			if(verticalRot==0)
			 	rotate([0,180*-1,0])
					mount();
			else{
				rotate([-1*90,verticalRot,0])
					translate([height/2,0,0]){
						difference(){
							mount();
				    		rotate([90, 30, 90])
								translate([0,0,-cone_h+6])
									cylinder(r=m3_nut_radius, h=cone_h, center=true, $fn=6);
						}
				}
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

module verticalSupport(verticalRot =0,backwards=false ){
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
							for (a = [-20:45:90])rotate([0,0,a]){
								translate([0,-height/4,0])
											cube([height*4, height/2, RodEndSpacing()+height], center=false);
							}
						}
						translate([10,0,0])
						rotate([0,0,-45/2])
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
}

module flatConnector(verticalRot =0){


	if(verticalRot==0){
		//horozontal rod
		rotate([0, 0, 0]) 
			translate([0,offset-height+4, 0]){
				cube([RodEndSpacing()-cone_h*2, height*.75, height], center=true);
			
		}
		myMount(separation,verticalRot);
		//additional asymetric upright mount
		translate([-RodEndBallSwivelFlangeHeight(.1)/2, offset, heightOfPilar])
			rotate([90,0,0]){
				difference(){
					mount();
		    		rotate([90, 30, 90])
						translate([0,0,-cone_h+6])
							cylinder(r=m3_nut_radius, h=cone_h, center=true, $fn=6);
				}
				translate([-19, -11.9, 0])
					rotate([90,0,0])
						intersection(){
							cylinder(r1=height+3,r2=3, h=height*1.4, center=false);
							translate([5,0, 0])
							cube([height+3,height,height*3],center=true);
						}
				translate([-offset-2, -RodEndSpacing()-height/2,0])
				cube([height,RodEndSpacing(),height*2],center=false);
			}
		//additional asymetric upright support
		translate([3,11,0])
			rotate([-100,90,0])
				translate([-separation/2,0,height]){
					translate([0,offset, height-2]){
						cube([RodEndSpacing()*.86, height, height], center=true);
					}
					verticalSupport(90,true);
		}
	}else{
			// vertical rod
		rotate([0,90,0]){
			translate([-separation/2,0,height]){
				
				verticalSupport(verticalRot);
				myMount(heightOfPilar+RodEndBallSwivelFlangeHeight(.1),verticalRot);
			}
		}
	}

}







