void setup() {
  //size(11520, 1080, P2D);
  // size(5760, 540, P2D);
  //fullScreen(SPAN);
  size(2880, 270, P3D);
  background(0);
  smooth(4);
  //noCursor();

  setupOsc();
  setupGlobals();
  setupEmgVehicles();
}

void draw() {
 background(0);
 getSensorData();
 drawEmgVehicles();
 emgRunning = true;
 
 //emgJustFlow();
 
 emgState = 5;
 
 

}

void emgJustFlow() {
 emgState = 1;
  
}