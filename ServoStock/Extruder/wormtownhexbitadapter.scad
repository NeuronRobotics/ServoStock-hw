//this is an adapter for the small circular servo horn to a hex bit driver.
$fn=100;
use <../../../Vitamins/Vitamins/Fasteners/Screws/MotorScrew_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/Hexbit_Vitamin.scad>

function cyldiam()=20;
function cylheight()=MSheadheight()+1;
function shaftdiam()=11;
function shaftheight()=12.5;

module hexbitadapter(3dPrinterTolerance){
	difference(){
		union(){
			cylinder(r=cyldiam()/2-3dPrinterTolerance/2,h=cylheight());
			cylinder(r=shaftdiam()/2-3dPrinterTolerance,h=shaftheight());
		}
		hexbit(.4,7.2/2,25);
		for(i=[0:3]){
			rotate(i*360/4,[0,0,1]){
				translate([7,0,-MSthreadheight()+MSheadheight()-1]){// 7 is the radius of the servo horn holes. parameterize later. 
					MotorScrew(.4);
				}
				translate([7,0,cylheight()]){
					cylinder(r=MSheaddiam()/2, h=shaftheight()+1);
				}
			}
		}
	}
}



hexbitadapter(.4);