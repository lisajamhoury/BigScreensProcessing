void setup() {
  size(1920, 1080, P3D);
  //surface.setLocation(0,0);
  //fullScreen(P3D);
  
  background(0);
  smooth(4);
  noCursor();
  
  setupOsc();
  setupGlobals();
  setupProcessData();
  
  setupDrawSensors(); // collected in draw emg
}

void draw() {
  background(0);
  getSensorData();
  runControls();
  
  //if (debugFlowField == true) {
  //  debugFlowField();
  //}
  //if (debugFrameRate == true) {
  //  debugFrameRate();
  //}

}