void ioOp2Setup() {
  emg1LBinary = new BinaryLine(1, emg1LeftSensor);
  emg1RBinary = new BinaryLine(2, emg1RightSensor);
  emg2LBinary = new BinaryLine(3, emg1LeftSensor); // fake right now. replace!
  emg2RBinary = new BinaryLine(4, emg1RightSensor); // fake right now. replace!
  pulseBinary  = new BinaryLine(5, pulseSensor); // fake right now. replace!;
 
}

void ioOp4Setup() {
  emg1LStroke = new NumStroke(emg1LeftSensor, 0, oneThird);
  emg1RStroke = new NumStroke(emg1RightSensor, 0, oneThird);;
  emg2LStroke = new NumStroke(emg1LeftSensor, twoThird, width); // faking emg2 for now
  emg2RStroke = new NumStroke(emg1RightSensor, twoThird, width); // faking emg2 for now
  pulseStroke = new NumStroke(pulseSensor, oneThird, twoThird); // faking pulse for now
}

void initializeGlobals() {
  // CONST CANVAS SIZES
  pulseCtr = new PVector(0.44*width, 0.44*height);
  leftEmgCtr = new PVector(0.16*width, 0.44*height);
  rightEmgCtr = new PVector(0.72*width, 0.44*height);
  oneThird = 0.31*width;
  twoThird = 0.57*width;
  
  // FLOW FIELD SETUP
  flowfield = new FlowField(16);
  vehicles1L = new ArrayList<Vehicle>();
  vehicles1R = new ArrayList<Vehicle>();
  vehicles2L = new ArrayList<Vehicle>();
  vehicles2R = new ArrayList<Vehicle>();
  fieldOutPoints = new ArrayList<PVector>();
  magnet = new ArrayList<Magnet>();  
  
  
  flowfield.init();
  
  

  // Magnet Placement SETUP -- currently just one
  circles = new ArrayList<Circle>();
  
  PVector cirLoc1 = new PVector(pulseCtr.x, 1.25 * pulseCtr.y);
  circles.add(new Circle(cirLoc1));
  flowfield.update(cirLoc1);
  
  // PULSE SETUP
  pulses = new ArrayList<Pulse>();
   
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
  
  //OFF SCREEN CANVAS SETUP -- REFACTOR
  canvas1 = createGraphics(width/4, height, P3D);
  canvas1.beginDraw();
  canvas1.clear();
  //canvas1.background(255,0,0);
  canvas1.endDraw();

  canvas2 = createGraphics(width/4, height, P3D);
  canvas2.beginDraw();
  canvas2.clear();
  //canvas2.background(0,255,0);
  canvas2.endDraw();
  
  canvas3 = createGraphics(width/4, height, P3D);
  canvas3.beginDraw();
  canvas3.clear();
  //canvas3.background(0,0,255);
  canvas3.endDraw();
  
  canvas4 = createGraphics(width/4, height, P3D);
  canvas4.beginDraw();
  canvas4.clear();
  //canvas4.background(255,0,0);
  canvas4.endDraw();

  canvas5 = createGraphics(width/4, height, P3D);
  canvas5.beginDraw();
  canvas5.clear();
  //canvas5.background(0,255,0);
  canvas5.endDraw();
  
  canvas6 = createGraphics(width/4, height, P3D);
  canvas6.beginDraw();
  canvas6.clear();
  //canvas6.background(0,0,255);
  canvas6.endDraw();
  
  // IO SETUP
  ioL = new PVector();
  ioL.x = pulseCtr.x;
  ioL.y = pulseCtr.y;
  ios = new ArrayList<Integer>(); 
  
  
}