include <../Axis/Parameters.scad>
use <../../../Vitamins/Vitamins/Structural/RodEnds/RodEnd_Vitamin.scad>
use <../../../Vitamins/Vitamins/Electronics/Hot_Ends/PrintrBotJHeadHotEnd_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/Standard_Extruder_Spacing_Vitamin.scad>
use <../../../Vitamins/Vitamins/Tools/Filament_Vitamin.scad>
use <ExtruderMKII.scad>



separation = RodEndSpacing()-RodEndBallSwivelFlangeHeight(.1);  // Distance between ball joint mounting faces.
offset = separation/2.5;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = StandardExtruderSpacing()/2;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;
m3_radius=2.4/2;
m3_nut_radius=6.3/2;
m3_wide_radius=m3_radius+.5;

module effector() {
  difference() {
    union() {
      cylinder(r=offset-3, h=height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
		rotate([0, 0, 30]) translate([offset-2, 0, 0])
		  cube([RodEndSpacing()/4, RodEndSpacing()/3.7, height], center=true);
		for (s = [-1, 1]) scale([s, 1, 1]) {
			  translate([0, offset, 0]) difference() {
			    intersection() {
			      cube([separation, 40, height], center=true);
			      translate([0, -4, 0]) rotate([0, 90, 0])
				cylinder(r=10, h=separation, center=true);
			      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
				cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
			    }
			    rotate([0, 90, 0])
			      cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
			    rotate([90, 0, 90])
			      cylinder(r=m3_nut_radius, h=separation-24, center=true, $fn=6);
			  }
	      }
      }
    }
    translate([0, 0, push_fit_height-height*2])
		rotate([0,-90,0])
      	HotEnd(true,.4);
    translate([0, 0, -6]) # import("m5_internal.stl");
    for (a = [0:60:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
      	#cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }
  }
}

translate([0, 0, height/2]) effector();
%rotate([0,0,90])Extruder();