

// SERIAL 
//config
int listeningPort = 6001;  

//variables for receiving data
int polar0;
int emg1L, emg1R, emg2L, emg2R;

//variables for osc communication
OscP5 oscP5;
NetAddress host;
float pct;


// OFF SCREEN CANVAS
PGraphics currentCanvL;
float currentCanvOffsetL;
//int currentCanvHueL;
PGraphics currentCanvR;
float currentCanvOffsetR;
//int currentCanvHueR;
PGraphics canvas1;
PGraphics canvas2;
PGraphics canvas3;
PGraphics canvas4;
PGraphics canvas5;
PGraphics canvas6;

float canvZThreshold = -70;
float canvDegsThreshold = -90;
float canvZ1;
float canvZ2;
float canvZ3;
float canvZ4;
float canvZ5;
float canvZ6;
float canvDegs = 0;
float canvDegsInc = 0.1;
float fadeBlackCanvas = 0;

// FLOW FIELD 
boolean debug = true;
FlowField flowfield;
ArrayList<Vehicle> vehicles1L;
ArrayList<Vehicle> vehicles1R;
ArrayList<Vehicle> vehicles2L;
ArrayList<Vehicle> vehicles2R;
ArrayList<Magnet> magnet;
float frCounter = 5;
float inc = 1;

ArrayList<PVector> fieldOutPoints;






//PULSE VARIABLES -- SINGLE
int pulseSensor = 0;
boolean beat = false;
int timePulse = 0;
//additional pulse variables
ArrayList<Circle> circles;
float cCount = 0;
float pastTime = 0;

//PULSE
ArrayList<Pulse> pulses;
float pHeart = 0;


color color1 = #2800ff;
//color color2 = #1e0f6f;
// END PULSE 

float fadeBlack = 10;






//EMG VARIABLES 
Table tableEmg;
int rowCountEmg;
int rowIndexEmg = 0;
int timeEmg = 0;
//emg system
TableRow rowEmg;
float emg1LeftSensor = 0;
float emg1RightSensor = 0;
float emg2LeftSensor = 0;
float emg2RightSensor = 0;
float tint;
float bright = 0;
float EMGLOWER = 20;
float EMGUPPER = 1000;

float emgAmount = 5;
boolean emgRunning = false;

float v1x;
float v1y;

float v2x;
float v2y;

PVector v1LStart;
PVector v1RStart;
PVector v2LStart;
PVector v2RStart;
  
//EMG IO

PVector ioL;
float brightIo = 0;
float ioHtInc = 10;
float ioY = 0.01;
float ioX = 0;

String allStrings = "";
ArrayList<Integer> ios;

//EMG IO2
BinaryLine emg1LBinary;
BinaryLine emg1RBinary;
BinaryLine emg2LBinary;
BinaryLine emg2RBinary;
BinaryLine pulseBinary;



//EMG IO4
NumStroke emg1LStroke;
NumStroke emg1RStroke;
NumStroke emg2LStroke;
NumStroke emg2RStroke;
NumStroke pulseStroke;





//ANIMPULSE VARIABLES 
int numFrames = 25;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];

Pulse pulse; 