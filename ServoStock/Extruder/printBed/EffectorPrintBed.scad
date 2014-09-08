use <../effector.scad>
use <../Depricated/ExtruderEncoderKeepaway.scad>

effector(true);

translate([-25,-60,0]){
	#encoderkeepaway();
}
translate([10,20,0]){
	import("EncoderBearingMount.stl");
}
translate([10,50,0]){
	import("EncoderBearingMount.stl");
}
translate([-120,-5,24.5]){
	rotate([180,0,90]){
		import("WormBottom.stl");
	}
}
translate([-60,-10,-2]){
	rotate([90,0,-90]){
		import("WormTopWPI.stl");
	}
}