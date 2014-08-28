use <Parameters.scad>
	
use <Clips.scad>	
use <StructuralBearingMount2.scad>
use <Pulley.scad>
use <Slider.scad>
use <IdlerBearingPlug.scad>
use <IdlerBearingClip.scad>
use <Rod.scad>
use <StructuralFeet.scad>

translate([6,-85,0]){
	rotate([0,0,90]){
		translate([0,13,0])
			DeltaFreeArm();
		DeltaFreeArm();
	}
}

//rotating the module, as it would be rotated for printing
translate([50,15,0])
	StructuralFeet();

translate([70,50,0])
	StructuralBearingMount(3);

translate([-35,70,0]){
	servo_pulley(true,true);
}

translate([-30,-15,0]){
	rotate([0,0,90])
		Slider(true, 1);
}
translate([-50,40,0]){
	IdlerBearingPlug();
	IdlerBearingClip();
}

translate([-90,-90,-1.1]){
	%cube([180,180,1]);
}
