void setup() {
  //size(11520, 1080, P3D);
  //size(5760, 540, P3D);
  //fullScreen(P3D);
  size(2880, 270, P3D);
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
    runControls();
    //println(emgState);
    
    if (debugFlowField == true) {
      debugFlowField();
    }
    //if (debugFrameRate == true) {
    //  debugFrameRate();
    //}

  }