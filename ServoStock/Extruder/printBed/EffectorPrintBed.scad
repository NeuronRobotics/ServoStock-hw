use <../effector.scad>
use <../Depricated/ExtruderEncoderKeepaway.scad>

effector(true);

translate([-50,-50,0]){
	#encoderkeepaway();
}
translate([10,15,0]){
	import("EncoderBearingMount.stl");
}
translate([10,40,0]){
	import("EncoderBearingMount.stl");
}
translate([-117,-10,24.5]){
	rotate([180,0,90]){
		import("WormBottom.stl");
	}
}
translate([-70,-10,-2]){
	rotate([90,0,-90]){
		import("WormTopWPI.stl");
	}
}