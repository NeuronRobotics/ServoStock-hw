use <../../../Vitamins/Vitamins/Structural/SteelRod/8mm_Rod_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/LinearBearings/LM8UU_Linear_Bearing_Vitamin.scad>
use <../../../Vitamins/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../Vitamins/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../Vitamins/Vitamins/Fasteners/ScrewsAsBolts/High_Low_Screw_As_Bolt_Vitamin.scad>

function mm(i) = i*25.4; 

//Build dimensions (x,y,z)-- x, y and z of printable area, NOT of overall device

//z-rod length, diameter-- dependent on which rods you buy
//(bearing diameter is dependent on rod diameter)


function RodEndSpacing() = 108.5;// this is a magic number

//These are the values to use in the kinematics
function getFreeRodLength() = 203.82;
function getBaseRadius() = 140;
function getEffectorRadius() = 25;

// these are the parameters for the Case
rodLength = 500;

function MotorBracketHeight()= StandardServoLength()+StandardServoTolerance()*4+PlasticWidth()*2;
function getBedToBearingPlateHeight() = 125+getCaseBoardThickness();
function getBedZHeight() = 150+getCaseBoardThickness();
function getCaseBoardThickness() = 19.05;//3/4in
function getPrintbedWidth() = 200;

function getCaseHoleSize() = 4.5;
function getShortSideLength() = 180;
//function getCabinetHeight() = 800;// rod length minus feet height and board thickness

function getCabinetHeight() = getBedZHeight() + getBedToBearingPlateHeight() +rodLength;// rod length minus feet height and board thickness
function getCaseBoltHolePitch() =  getCabinetHeight()/4;
function extraSideLength()=140;
function getBaseSideLength() = getBaseRadius()*2+extraSideLength();
function getInnerPlateTabPitch() = getBaseSideLength()/4;



function ZrodSpacing()=RodEndSpacing()-LM8UULinearBearingDiam()*2-PlasticWidth()*4;
echo(ZrodSpacing());

//parametric of which hotend is being used (printerbot or bucha nozzle)

//stepper vs servo

//3 parameters (1 for each link) horizontal vs vertical

//paper is a parametric vitamin

//distance between link arms will be calculable based on radius of toolplate

//tolerances
//function LaserCutTolerance() = .02;
function 3dPrinterTolerance() = .4;



//the equation used for plastic width, it can of course be changed
function PlasticWidth()= (8mmRodDiameter()/2);
function SideWidth() = (8mmRodDiameter()+PlasticWidth());
echo(PlasticWidth());

//flashforge printable height
function FlashforgePrintableHeight()= 145;

//canvas pulley parameters
function CanvasPulleyLength()=FlashforgePrintableHeight();
//CanvasPulleyLength should be(getBaseRadius()-60)*2, except that this is larger than the flashforge printable height. Therefore change the flashforge variable to this when we have a printer that can print a taller part.

function CanvasPulleyWidth()=HiLoBoltLength()*1.3;
function CanvasPulleySeperation()=100; //fairly arbitrary seperation between active and idler pullies
function HerringboneMotorMountLength()=StandardServoLength()+HiLoBoltHeadDiameter()*2; //length of the motor mount when the herringbone gear is used

function CanvasPulleyMountHerringboneDistance()=(PlasticWidth()+608BallBearingHeight()/3+608BallBearingHeight())*2+CanvasPulleyLength()-HiLoBoltHeadDiameter()*4;

//canvas pulley herringbone gear parameters
function CanvasGearPitch()=700;
function CanvasPulleyTeeth()=16;
function CanvasPulleyGearRadius()=(CanvasPulleyTeeth()*CanvasGearPitch()/180)/2;
function CanvasDriverTeeth()= 8;
function CanvasPulleyDriverRadius()=(CanvasDriverTeeth()*CanvasGearPitch()/180)/2;
function CanvasPulleyGearOffsetAngle()=25;
function CanvasPulleyMotorMountOffset()=sin(90-CanvasPulleyGearOffsetAngle())*(CanvasPulleyGearRadius()+CanvasPulleyDriverRadius());



