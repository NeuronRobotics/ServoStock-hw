use <../Axis/Parameters.scad>
use <CanvasPulleyMount.scad>
use <ConstantForceSpringHolder.scad>
use <CanvasPulley.scad>

rotate([90,0,0])
CanvasPulleyMount(WormDriver=false);

translate([80,0,0])
rotate([90,0,0])
CanvasPulleyMount(WormDriver=false);

translate([40,0,0])
rotate([90,0,0])
CanvasPulleyMount(WormDriver=false);

translate([-45,0,0])
rotate([90,0,0])
ConstantForceSpringHolder();

translate([-95,0,PlasticWidth()])
rotate([0,180,0])
ConstantForceSpringCap();

translate([0,-40,0])
ConstantForceRoller();
