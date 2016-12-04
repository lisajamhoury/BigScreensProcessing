void setup() {
  //size(11520, 1080, P3D);
  //size(5760, 540, P3D);
  size(5000, 469, P3D); // my display
  //fullScreen(P3D);
  //size(2880, 270, P3D);
  //size(1920, 180, P3D); //Aaron's projector 
  //size(1440, 135, P3D);
  background(0);
  smooth(4);
  //noCursor();

  setupOsc();
  setupGlobals();
  setupProcessData();
  
  setupDrawSensors(); // collected in draw emg
}

void draw() {
  background(0);
  getSensorData();
  processControls();
  runControls();
  
  //println(sloMo, inKeyChar);
  //debug bpm
  //println(currentBpm);
  
  
  if (debugFlowField == true) {
    debugFlowField();
  }
  //if (debugFrameRate == true) {
  //  debugFrameRate();
  //}

}