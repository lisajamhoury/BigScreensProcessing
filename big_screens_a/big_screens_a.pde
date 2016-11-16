void setup() {
  //size(11520, 1080, P2D);
  // size(5760, 540, P2D);
  //fullScreen(SPAN);
  size(2880, 270, P3D);
  background(0);
  smooth();
  //noCursor();

  setupOsc();
  setupGlobals();
  setupDrawFunctions();
}


void draw() {
  getSensorData();
  //background(0);


  if (key == '1') {
    drawSinglePulse();
  }

  if (key == '2') {
    drawSpinPulse();
    drawPulse = true;
  }

  if (key == '3') {
    background(0);
    drawEmgLogicBackground();
    //ioOp4();
    drawEmgSlowLines();
  }
  
  if (key =='4') {
   ioOp1(); 
  }
  
  if (key =='5') {
   ioOp2(); 
  }  
  
  //if (key =='6') {
  // ioOp3(); 
  //}
  
    
  if (key =='7') {
   ioOp4(); 
  }
}