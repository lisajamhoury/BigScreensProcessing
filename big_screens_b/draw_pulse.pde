//////////////// BEGIN PULSE  ////////////////
boolean beat = false;
int pulseExDuration;  
int targetBoundX;
int targetBoundY;

int pulseExpandUnitX;
int pulseExpandUnitY;
int pulseStartTime;
int pulseIncTimeX;
int pulseIncTimeY;
//int pulseTimeElapsed;

int pulseBoundX = 2; //starting x boundaries 
int pulseBoundY = 2; //starting y boundaries

float pulseRectHeight = 0.01 * height;  // 0.0006 * width; 
float ctrPosLocY;

boolean animate = false;


//////////////// MULTI PULSE ////////////////
boolean growing = false;
boolean drawPulse = false; // allows for pulse array to grow but not be drawn on screen
int pulseCount = 0; // add pulse every two
ArrayList<PulseMarker> multiPulses;

//size of spin pulses
//float pulseXBound;
//float pulseXBoundInc;
 
void setupMultiPulse() { 
 multiPulses = new ArrayList<PulseMarker>();
 
 pulseExDuration = 60000; //expand pulse over one minute  
 targetBoundX = columns/2; // set the target width for each half
 targetBoundY = rows/4; // set the target height for each half
 
 pulseExpandUnitX = pulseExDuration/targetBoundX; //how many millis between each x bound expansion
 pulseExpandUnitY = pulseExDuration/targetBoundY; //how many millis between each y bound expansion
 
 ctrPosLocY = PULSECTR.y;
  
}


void expandPulseBounds() {
 int pulseTimeElapsedX = millis() - pulseIncTimeX;
 int pulseTimeElapsedY = millis() - pulseIncTimeY;
 
 if (pulseTimeElapsedX > pulseExpandUnitX) {
   if (pulseBoundX <= targetBoundX+5) { // stop incrementing when all columns are in bounds. need to take into account pulse ctr shift
     pulseBoundX++;
   }
       
   pulseIncTimeX = millis();
 }
 
 if (pulseTimeElapsedY > pulseExpandUnitY) {
   if (pulseBoundY <= targetBoundY) {
     pulseBoundY++;
   }
   pulseIncTimeY = millis();
 } 
}

void noBoundExpansion() {
 pulseBoundX = 5;
 pulseBoundY= 5;
}

void drawMultiPulse(){
  //clear background 
  //fill(0);
  //rect(0, 0, width, height);
  //If pulse array is growing -- add on pulse
  if (growing == true) { 
  if (pulseSensor == 1 && beat == false) {
    beat = true;
    pulseCount++;
 
    // every two heart beat creates a circle
    if (pulseCount == 2) {
      pulseCount = 0;
      PVector pulseLoc = getPulseLocation();
      // check to make sure you have a bpm
      if (currentBpm > 0) { 
        multiPulses.add(new PulseMarker(pulseLoc));
      }
    }
  }
 
 if ( pulseSensor == 0 && beat == true ) {
   beat = false;
  }
 } //growing true
 
 //If pulse array is shrinking -- remove on pulse 
 if (growing == false) {
   if (pulseSensor == 1  && beat == false) {
     beat = true;
     if (multiPulses.size() > 0) {
        int pos = multiPulses.size() - 1;
        multiPulses.remove(pos);
    }
   }
  if ( pulseSensor == 0 && beat == true ) {
   beat = false;
  }
 } // growing false 
   
 // Draw pulse is true, otherwise, just keep count   
 if (drawPulse == true) {
   runMultiPulse();
 }

}

void runMultiPulse() {  
  if (multiPulses.size() > 0) {
    for (int i = 0; i < multiPulses.size(); i++) {
     multiPulses.get(i).run();
    }
  }
}


PVector getPulseLocation() {
 PVector newPulseLoc;
 newPulseLoc = hardXandY(pulseBoundX, pulseBoundY);
 //newPulseLoc = getCenterPulse();
 return newPulseLoc;
}


PVector getCenterPulse() {
  PVector newLoc = new PVector();

  newLoc.x = PULSECTR.x;
  newLoc.y = ctrPosLocY;
  ctrPosLocY += pulseRectHeight;
  println(ctrPosLocY);
  //int yUpOrDown = floor(random(0,2)); // get a 0 or 1
  
  return newLoc;
  
}


PVector hardXandY(int xBound, int yBound) {
 PVector newLoc = new PVector();
  
 // choose x
 int xLine = floor(random(-xBound, xBound));
 float scaleUpXLine = resolution * xLine; // get amount of width to scale by
 newLoc.x = PULSECTR.x + scaleUpXLine;
    
 // choose y
 int yLine = floor(random(-yBound, yBound));
 float scaleUpYLine = resolution * yLine; // get amount of width to scale by
 newLoc.y = PULSECTR.y + scaleUpYLine;
 
 return newLoc; 
}

PVector hardXorY(int xBound, int yBound) {
  PVector newLoc = new PVector();
  
  int xOrY = floor(random(2));
  if (xOrY == 0) {
   // choose a line  
   int xLine = floor(random(-xBound, xBound));
   float scaleUpXLine = resolution * xLine; // get amount of width to scale by
   newLoc.x = PULSECTR.x + scaleUpXLine;
   newLoc.y = random(0, height);
 }
 
 if (xOrY == 1) { 
   // choose a line 
   int yLine = floor(random(-yBound, yBound));
   float scaleUpYLine = resolution * yLine; // get amount of width to scale by
   newLoc.y = PULSECTR.y + scaleUpYLine;
   
   //float xVariant = pulseXBound1 * resolution;
   //float xOff = random(-xVariant, xVariant);
   //newX = newX + xOff;
   newLoc.x = random(0, width);
 }
 return newLoc; 
}






//////////////// END MULTI PULSE ////////////////