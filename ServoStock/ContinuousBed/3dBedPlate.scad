use <../Cabinet/CabinetTopSheet.scad>

function BaseSideLength()=getBaseSideLength();

module 3dBedPlate()
{
	linear_extrude(height=5)bedPlate();
}

3dBedPlate();