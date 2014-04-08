function getThickness() = 18;
use <../Axis/StructuralFeet.scad>

projection(cut = false){
	translate([0,0, MotorBracketHeight()])
	{
		rotate([0,180,90])
		{
			StructuralFeet();
		}
	}
}
	

