//Pulse functions

void setupDrawFunctions() {
  setupSinglePulse();
  setupSpinPulse();
  setupEmgSlowLines();
  setupIoOp2();
  ioOp4Setup();
}

//////////////// SINGLE PULSE ////////////////  
boolean beat = false;
SinglePulse singlePulse;

void setupSinglePulse() {
  noStroke();
  singlePulse = new SinglePulse();
  
  
}

void drawSinglePulse() {
  background(0);
  if (pulse == true && beat == false) {
    beat = true;   
  } 
  
  if (pulse == false && beat == true) {
   beat = false; 
  }
  
  singlePulse.run();
}
//////////////// END SINGLE PULSE ////////////////


//////////////// SPIN PULSE ////////////////
boolean growing = true;
boolean drawPulse = false; // allows for pulse array to grow but not be drawn on screen
int pulseCount = 0; // add pulse every two
ArrayList<SpinPulse> spinPulses;

//size of spin pulses
float pulseXBound;
float pulseXBoundInc;
 
void setupSpinPulse() {
  pulseXBound = 0.01 * width;
  pulseXBoundInc = 0.00005 * width;
  
  spinPulses = new ArrayList<SpinPulse>();
}

void drawSpinPulse(){
  fill(0, 10);
  rect(0, 0, width, height);  
  //If pulse array is growing -- add on pulse
  if (growing == true) { 
  if (pulseSensor == 1 && beat == false) {
    beat = true;
    pulseCount++;
 
    // every two heart beat creates a circle
    if (pulseCount == 2) {
      pulseCount = 0;
      spinPulses.add(new SpinPulse());
    }
  }
 
 if ( pulseSensor == 0 && beat == true ) {
   beat = false;
  }
 } //growing true
 
 //If pulse array is shrinking -- remove on pulse 
 if (growing == false && pulseSensor == 1) {
   if (spinPulses.size() > 0) {
      int pos = spinPulses.size() - 1;
      spinPulses.remove(pos);
  }
 }
 if (drawPulse == true) {
   runSpinPulse();
 }
}

void runSpinPulse() {  
  pushMatrix();
  translate(PULSECTR.x, PULSECTR.y);
  rotate(frameCount * 0.01); // better way to rotate?
  for (int i = 0; i < spinPulses.size(); i++) {
   spinPulses.get(i).run();
  }
  popMatrix();
  pulseXBound += pulseXBoundInc;
}

//////////////// END SPIN PULSE ////////////////



//////////////// EMG SLOW LINES ////////////////
import java.util.Iterator;

FlowField flowfield;
ArrayList<Magnet> magnet;

boolean emgRunning = true;
OffScreenCanvas canvSlowLines;

PVector v1LStart;
PVector v1RStart;
PVector v2LStart;
PVector v2RStart;

float minSpeed = 0.00000030;
float maxSpeed = 4*minSpeed;
float force = 0.0000001;

void setupEmgSlowLines() {
  noiseSeed(7);
  
  flowfield = new FlowField(16);
  magnet = new ArrayList<Magnet>(); 
  flowfield.init();
  canvSlowLines = new OffScreenCanvas();
  
  PVector magnetPos = new PVector(PULSECTR.x, 1.25 * PULSECTR.y);
  flowfield.update(magnetPos);
 
  //EMG START POSITIONS 
  float v1Lx = 0;
  float v1Ly = 0.5 * height;
  float v1Rx = 0;
  float v1Ry = 0.73 * height;
  float v2Lx = width-1;
  float v2Ly = 0.2 * height;
  float v2Rx = width-1;
  float v2Ry = 0.35 * height;
  
  v1LStart = new PVector(v1Lx, v1Ly);
  v1RStart = new PVector(v1Rx, v1Ry);
  v2LStart = new PVector(v2Lx, v2Ly);
  v2RStart = new PVector(v2Rx, v2Ry);
  
  
}

void drawEmgSlowLines() {
  emgRunning = true;
  canvSlowLines.addVehicles();
  canvSlowLines.runVehicles();
  canvSlowLines.drawCanvas();
}
//////////////// END EMG SLOW LINES ////////////////

//////////////// EMG LOGIC BACKGROUND  ////////////////

void drawEmgLogicBackground() {
 String emg1SensorLogic; 
 String emg2SensorLogic;
 
 emg1SensorLogic = emgLogic(emg1LeftSensor, emg1RightSensor);
 emg2SensorLogic = emgLogic(emg2LeftSensor, emg2RightSensor);
 
 PVector emg1Start = new PVector(0,0);
 PVector emg2Start = new PVector(TWOTHIRD, 0);
 
 flashEmgBackground(emg1SensorLogic, emg1Start, ONETHIRD, height);
 flashEmgBackground(emg1SensorLogic, emg2Start, width-TWOTHIRD, height);
  
}

void flashEmgBackground(String sensorLogic, PVector startCorner, float rWidth, float rHeight) {
  
 if (sensorLogic == "high") {
   pulseBackground(255, startCorner, rWidth, rHeight);
   
 } else if (sensorLogic == "one high") {
  pulseBackground(100, startCorner, rWidth, rHeight);
   
 } else if (sensorLogic == "low") {
   fill(0);
   rect(startCorner.x, startCorner.y, rWidth, rHeight);
 } else if (sensorLogic == "close") {
 }
}

void pulseBackground(float iLight, PVector startCorner, float rWidth, float rHeight) {
  float light = iLight;
  float dark = 0;
  float hueValue = light;
  float lerpAsc = 0.9;
  float lerpDec = 0.9;
  //String state = "ascending";
  
  hueValue = lerp(hueValue, dark, lerpAsc);
  
  //state = "descending";
  hueValue = lerp(hueValue, light, lerpDec);
 
  fill(iLight, hueValue);
  rect(startCorner.x, startCorner.y, rWidth, rHeight);
   
}



//////////////// EMG LOGIC  ////////////////

String emgLogic(float leftSensor, float rightSensor) {
  String status = "neutral";
  color clr = color(255,255,255);
  
  if (leftSensor > 900 && rightSensor > 900) {
    status = "high";
    clr = color(255,0,0);
    // red
    //bright = 255;
  } else if ((leftSensor > 900 && rightSensor < 500) ||  (rightSensor > 900 && leftSensor  < 500)) {
    status = "one high";
    // green
    //bright = 200;
    clr = color(0,255,0);
  } else if (leftSensor < 300 && rightSensor < 300) {
    status = "low";
    // blue 
    //bright = 20;
    clr = color(0,0,255);
  } else if (abs(leftSensor - rightSensor) <=100) {
    status = "close";
    //white
    //bright = 100;
    clr = color(255,255,255);
  } 
 
 return status;
}

//////////////// END EMG LOGIC  ////////////////


//////////////// IO OPTIONS  ////////////////

// Option 1 //
String allStrings = "";

void ioOp1() {
  background(0);
  colorMode(RGB);
  fill(255);
  String lSens = binary(floor(emg1LeftSensor));
  String rSens = str(floor(emg1RightSensor));
  int firstOne = lSens.indexOf("1");
  String noZeros = lSens.substring(firstOne);
  allStrings = noZeros+allStrings;
  text(allStrings, PULSECTR.x, PULSECTR.y);
}
// Option 2 //
//EMG IO2
BinaryLine emg1LBinary;
BinaryLine emg1RBinary;
BinaryLine emg2LBinary;
BinaryLine emg2RBinary;
BinaryLine pulseBinary;



void setupIoOp2() {
  emg1LBinary = new BinaryLine(1, emg1LeftSensor);
  emg1RBinary = new BinaryLine(2, emg1RightSensor);
  emg2LBinary = new BinaryLine(3, emg2LeftSensor); 
  emg2RBinary = new BinaryLine(4, emg2RightSensor); 
  pulseBinary  = new BinaryLine(5, pulseSensor); 
 
}

void ioOp2() {
  emg1LBinary.run();
  emg1LBinary.update(emg1LeftSensor);
  emg1RBinary.run();
  emg1RBinary.update(emg1RightSensor);
  
  emg2LBinary.run();
  emg2LBinary.update(emg2LeftSensor);
  emg2RBinary.run();
  emg2RBinary.update(emg2RightSensor);
  
  pulseBinary.run();
  pulseBinary.update(pulseSensor);
 
}

// Option 3 //
//void ioOp3() {
//  colorMode(RGB);
//  fill(255);
//  String lSens = binary(floor(emg1LeftSensor));
//  String rSens = str(floor(emg1RightSensor));
  
//  float lW = textWidth(lSens);
//  float rW = textWidth(rSens); 
//  //text(lSens, pulseCtr.x, pulseCtr.y);
//  float rectW = map(emg1LeftSensor, 20, 1000, 1,10);
//  float rectH = map(emg1LeftSensor, 20, 1000, 1,10);
//  fill(brightIo);
//  rect(ioL.x, ioL.y, rectW, rectH);
//  rect(pulseCtr.x-rW, pulseCtr.y, rW, 10);
  
//  ioL.x += rectW;
//  if (ioL.x > width) {
//    ioL.x = pulseCtr.x;
//    ioL.y += ioHtInc;
//  }
  

//  ioY++;
//  if (ioY > height) {
//    ioY = 0;
//    ioX +=10;
//  }
//}

// Option 4 //
//EMG IO4
NumChalk emg1LStroke;
NumChalk emg1RStroke;
NumChalk emg2LStroke;
NumChalk emg2RStroke;
NumChalk pulseStroke;

void ioOp4Setup() {
  emg1LStroke = new NumChalk(emg1LeftSensor, 0, ONETHIRD);
  emg1RStroke = new NumChalk(emg1RightSensor, 0, ONETHIRD);;
  emg2LStroke = new NumChalk(emg2LeftSensor, TWOTHIRD, width); // faking emg2 for now
  emg2RStroke = new NumChalk(emg2RightSensor, TWOTHIRD, width); // faking emg2 for now
  pulseStroke = new NumChalk(pulseSensor, ONETHIRD, TWOTHIRD); // faking pulse for now
}

void ioOp4() {
  emg1LStroke.run();
  emg1LStroke.update(emg1LeftSensor);
  emg1RStroke.run();
  emg1RStroke.update(emg1RightSensor);

  emg2LStroke.run();
  emg2LStroke.update(emg2LeftSensor); 
  emg2RStroke.run();
  emg2RStroke.update(emg2RightSensor); 
  
  pulseStroke.run();
  pulseStroke.update(pulseSensor); 
}