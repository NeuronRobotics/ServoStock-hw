use <../../../Vitamins/Vitamins/Sensors/Encoders/Encoder_Vitamin.scad>;
$fn=50;
function solderthickness(3dPrinterTolerance=.4)=1.1+3dPrinterTolerance;

module encoderkeepaway(){
	difference(){
		translate([0,-1,solderthickness(.4)/2]){
			cube([EncoderWidth(.4)-1,EncoderHeight(.4)+EncoderChipOffset(.4),solderthickness(.4)],center=true);
		}
		translate([0,EncoderBoltInsetY(.4)-2,solderthickness(.4)/2]){
			cube([EncoderWidth(.4)-EncoderBoltInsetX(.4)*4,EncoderHeight(.4)+2,EncoderThickness(.4)],center=true);
		}
		translate([0,-EncoderBoltInsetY(.4)*2-.5,solderthickness(.4)+EncoderChipHeight(.4)]){
		Encoder(true,.4);
		}
	}
}


encoderkeepaway();