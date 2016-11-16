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
  setupDrawSensors();
   
}

void draw() {
 //background(0);  // what to do about background? 
 getSensorData();

 if (key == '6') { 
   drawPulse = true;
   growing = true;
   drawMultiPulse();
 }

 
 //TURN ON FOR EMG
 //background(0);
 //drawEmgVehicles();
 //emgRunning = true;
 
 // TO DO -- ADD LABELS TO THESE
 if (key == '1') emgState = 1;
 if (key == '2') emgState = 2;
 if (key == '3') emgState = 3;
 if (key == '4') emgState = 4;
 if (key == '5') emgState = 5; 

}