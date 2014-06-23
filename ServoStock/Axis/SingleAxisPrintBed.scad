use <Parameters.scad>
use <BearingCap.scad>	
use <Clips.scad>	
use <StructuralBearingMount2.scad>
use <Pulley.scad>
use <Slider.scad>
use <IdlerBearingPlug.scad>
use <IdlerBearingClip.scad>
use <Rod.scad>
use <StructuralFeet.scad>


<<<<<<< HEAD
//translate([60,-90,0]){
	//rotate([0,0,90]){
		//translate([0,13,0])
			//DeltaFreeArm();
		//DeltaFreeArm();
	//}
//}
=======
translate([60,-85,0]){
	rotate([0,0,90]){
		translate([0,13,0])
			DeltaFreeArm();
		DeltaFreeArm();
	}
}
>>>>>>> branch 'master' of https://github.com/Technocopia/ServoStock-hw.git
//rotating the module, as it would be rotated for printing
<<<<<<< HEAD
translate([0,0,0])
{
	rotate([0,0,0])
	{
		StructuralFeet();
	}
}
translate([15,50,0])
	rotate([0,0,90]){
		StructuralBearingMount(3);
	}
=======
translate([0,15,0])
StructuralFeet();

translate([0,50,0])
	StructuralBearingMount(3);

>>>>>>> branch 'master' of https://github.com/Technocopia/ServoStock-hw.git
translate([-40,70,0]){
	servo_pulley(true,true);
}

translate([-55,-15,0]){
	rotate([0,0,90])
		Slider(true, 1);
}
translate([0,20,0]){
	IdlerBearingPlug();
	IdlerBearingClip();
}

translate([-90,-90,-1.1]){
	%cube([180,180,1]);
}
