//size of big screens screen
int bigScreenWidth = 11520;
int bigScreenHeight = 1080;
int bigScreenArea = bigScreenWidth*bigScreenHeight;

//scaling for prototyping
//between 0.0 and 1.0
float protoScaling = 0.25;

//dimensions of the prototype
float protoWidth = bigScreenWidth * protoScaling;
float protoHeight = bigScreenHeight * protoScaling;
float protoArea = protoWidth * protoHeight;


//scaling for vehicle offset
float vehicleOffsetX = 0.1;
float vehicleOffsetY = 0.1;

//scaling for maximum speed of vehicle
//float minSpeed = 0.00000030;
//float maxSpeed = 4*minSpeed;
float minSpeed = 0.00000030;
float maxSpeed = 4*minSpeed;
float force = 0.0000001;

//scaling for size of pulse 
float pulseSz = 0.00004;
float lineSz = 0.0000000803;
float lineStk = 0.00000004;

//scaling for size of pulses in array
float pulseXBound = 0.01 * protoWidth;
float pulseXBoundInc = 0.00005 * protoWidth;
float pulseSmall = 0.0020 * protoWidth;
float pulseLarge = 0.0030 * protoWidth;