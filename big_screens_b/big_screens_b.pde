void setup() {
  //size(11520, 1080, P3D);
  //size(5760, 540, P3D);
  //fullScreen(SPAN);
  size(2880, 270, P3D);
  //size(1440, 135, P3D);
  background(0);
  smooth(4);
  //noCursor();

  setupOsc();
  setupGlobals();
  setupProcessData();
  setupDrawSensors();
   
}

void draw() {
 getSensorData();
 
 drawPulse = true;
 if (currentBpm > 10) {
   if (!growing) {
     //begin timer
     pulseStartTime = millis();
     pulseIncTimeX = pulseStartTime;
     pulseIncTimeY = pulseStartTime;
     println("beginnig");
     println(pulseStartTime);
   }
   growing = true;
   expandPulseBounds();
   
   
 }
 drawMultiPulse();
 
 // TO DO -- ADD LABELS TO THESE
 if (key == '1') {
  background(0);
  drawEmgVehicles();
  emgRunning = true;
  emgState = 1;
 }
 if (key == '2') {
   background(0);
   drawEmgVehicles();
   emgRunning = true;
   emgState = 2;
 }
 if (key == '3') {
   background(0);
   drawEmgVehicles();
   emgRunning = true;
   emgState = 3;
 }
 if (key == '4') {
   background(0);
   drawEmgVehicles();
   emgRunning = true;
   emgState = 4;
 }
 if (key == '5') {
   background(0);
   drawEmgVehicles();
   emgRunning = true;
   emgState = 5;
 }
 
 

}