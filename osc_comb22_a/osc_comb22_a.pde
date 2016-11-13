import java.util.Iterator;
import oscP5.*;
import netP5.*;

void setup() {
  //size(11520, 1080, P2D);
  size(5760, 540, P2D);
  //fullScreen(SPAN);
  //size(2880, 270, P3D);
  
  oscP5 = new OscP5(this, listeningPort);
  
  background(0);
  smooth();
  noiseSeed(2); 
  
  initializeGlobals();
  ioOp2Setup();
  ioOp4Setup();
  
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  // parse incoming data
  if (theOscMessage.checkAddrPattern("/polar")) {
    polar0 = theOscMessage.get(0).intValue();
  } else if (theOscMessage.checkAddrPattern("/emg1")) {
    emg1L = theOscMessage.get(0).intValue();
    emg1R = theOscMessage.get(1).intValue();
  } else if (theOscMessage.checkAddrPattern("/emg2")) {
    emg2L = theOscMessage.get(0).intValue();
    emg2R = theOscMessage.get(1).intValue();
  }
  
  //print the data
  //println("polar: " + polar0);
  //println("emg1: " + emg1L + ", " + emg1R);
  //println("emg1: " + emg2L + ", " + emg2R);
}


void draw() { 
   background(0);
  getSensorData();
  
  // Start pulse
  if (key == '1') {
    if (pulseStarted == false) {
      pulseStarted = true;
    }
   pulse();
  }
  
  // Stop displaying pulse
  if (key == '2') {
   pulse();
   fill(0,fadeBlack);
   rect(0,0,width,height);
   fadeBlack++;
  }
  
  // Begin Flow EMG Lines
  if (key == '3') {
   //pulse();
   //runPulse = false;
  
   //emgFlowCanvas();
   drawFlowLinesEMGSingleCanv();
   emgRunning = true;
   runEmgVehicles(vehicles1L, v1LStart, "left");
   runEmgVehicles(vehicles1R, v1RStart, "left");
   runEmgVehicles(vehicles2L, v2LStart, "right");
   runEmgVehicles(vehicles2R, v2RStart, "right");
   
  }
  
  // Move canvases backward
  if (key == '4') {
   pulse();
   runPulse = false; 
   background(0);
    emgFlowCanvas();
    emgRunning = true;
    //runEmgVehicles();
    
    if (canvZ1 > canvZThreshold) {
      canvZ1-=0.0015*height;
      canvZ2+=0.0005*height;
      canvZ3+=0.0005*height;
      canvZ6-=0;
      canvZ5-=0.0005*height;
      canvZ4-=0.0005*height;
    }

  }
  
  // Rotate canvases
  if (key == '5') {
   pulse();
   runPulse = false;
   background(0);
   emgFlowCanvas();
   emgRunning = true;
   //runEmgVehicles();
   if (canvDegs > canvDegsThreshold) {
     canvDegs -= canvDegsInc;
   }
   fadeBlack = 10; // Find a better place for this
  }
  
  // Go Black
  if (key == '6') {
   pulse();
   runPulse = false;
   //background(0);
   emgFlowCanvas();
   emgRunning = true;
   //runEmgVehicles();
   
   fill(0,fadeBlack);
   rect(0,0,width,height);
   fadeBlack++;
   
  }
  
  // Run zero/one view
  if (key == '7') {
   pulse();
   runPulse = false;
   //ioOp4();
   ioOp1();
  }
  
  //Rotate back;
  if (key =='8') {
   pulse();
   runPulse = false;
   background(0);
   emgFlowCanvas();
   emgRunning = true;
   //runEmgVehicles();
   
   if (canvDegs < 0) {
   canvDegs += canvDegsInc;
   }
   
  }
  
  //Move canvases forward
  if (key == '9') {
    pulse();
    runPulse = false;
    background(0);
    emgFlowCanvas();
    emgRunning = true;
    //runEmgVehicles();
    
    if (canvZ1 < 0) {
      canvZ1+=0.0015*height;
      canvZ2-=0.0005*height;
      canvZ3-=0.0005*height;
      canvZ6-=0;
      canvZ5+=0.0005*height;
      canvZ4+=0.0005*height;
    }
  }
  
  if (key == '0') {
    canvas1.beginDraw();
    canvas1.colorMode(RGB);
    //canvas1.fill(0,fadeBlackCanvas);
    canvas1.fill(255);
    canvas1.rect(0,0,width/4,height);
    canvas1.endDraw();
  
    canvas2.beginDraw();
    canvas2.fill(0,fadeBlackCanvas);
    canvas2.rect(0,0,width, height);
    canvas2.endDraw();
    
    canvas3.beginDraw();
    canvas3.fill(0,fadeBlackCanvas);
    canvas3.rect(0,0,width, height);
    canvas3.endDraw();
    
    canvas4.beginDraw();
    canvas4.fill(0,fadeBlackCanvas);
    canvas4.rect(0,0,width, height);
    canvas4.endDraw();
  
    canvas5.beginDraw();
    canvas5.fill(0,fadeBlackCanvas);
    canvas5.rect(0,0,width, height);  
    canvas5.endDraw();
    
    canvas6.beginDraw();
    canvas6.fill(0,fadeBlackCanvas);
    canvas6.rect(0,0,width, height);
    canvas6.endDraw();
    
    fadeBlackCanvas++;
  }
  
  if (key == 'q') {
    pulse();
    runPulse = true;
    growing = false;
  }
  
  
  if (emgRunning == true) {
   drawFlowLinesEMG();
  }

  
  //ioOp1();
  //ioOp2();
  //ioOp3();
  //ioOp4();
  
  //animPulse();


  // TIMING TURN BACK ON LATER 
  //if (millis() > pulseStart && millis() < end ) {
  //  //singlePulse();
  //}
  
  //if (millis() > emgStart && millis() < justPulse) { 
  //  drawEMG();
  //  emgRunning = true;
  //} else {
  //  emgRunning = false;
  //}
  
  //if (millis() > end) {
  //  fill(0, 0, 0, 10);
  //  rect(0, 0, width, height);
  //}
  

  if (debug) {
    debug();
  }

  // Move timeline faster or slower
  if (frameCount % 20 == 0 ) {
    frCounter+=10;
  }

  //if (frCounter > width-50) {
  //  frCounter =0;
  //}
  
  //FRAMERATE BOX
  colorMode(RGB);
  fill(255,0,0);
  rect(0, 0, 100, 100);
  fill(255);
  text(floor(frameRate), 10, 40);
  text(floor(vehicles1L.size()), 10, 60);
  text(floor(vehicles1R.size()), 10, 80);
  text(floor(vehicles2L.size()), 10, 100);
  text(floor(vehicles2R.size()), 10, 120);
  
}


void getSensorData() { 
 emg1LeftSensor = emg1L;
 emg1RightSensor = emg1R;
 emg2LeftSensor = emg1L;
 emg2RightSensor = emg1R;
 pulseSensor = polar0;
}


void debug() {
   flowfield.display();

  Iterator<Magnet> it = magnet.iterator();
  while (it.hasNext()) {
    Magnet m = it.next();
    m.display();
  } 
}