use <../effector.scad>
use <../Depricated/ExtruderEncoderKeepaway.scad>

//effector(true);

translate([-50,-50,0]){
	//encoderkeepaway();
}
translate([-35,20,0]){
	import("EncoderBearingMount.stl");
}
translate([-32,45,0]){
	import("EncoderBearingMount.stl");
}
translate([-75,0,0]){
	rotate([0,0,180]){
		import("WormBottom.stl");
	}
}
translate([-20,-10,0]){
	rotate([0,0,90]){
		import("WormTopWPI.stl");
	}
}

translate([-70,60,0]){
	rotate([90,0,0]){
		import("hexbitadapter.stl");
	}
}
	