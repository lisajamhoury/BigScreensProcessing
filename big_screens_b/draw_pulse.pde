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
  
}


void expandPulseBounds() {
 int pulseTimeElapsedX = millis() - pulseIncTimeX;
 int pulseTimeElapsedY = millis() - pulseIncTimeY;
 
 if (pulseTimeElapsedX > pulseExpandUnitX) {
   println("increaseX");
   println(pulseBoundX);
   if (pulseBoundX <= targetBoundX+5) { // stop incrementing when all columns are in bounds. need to take into account pulse ctr shift
     pulseBoundX++;
   }
       
   pulseIncTimeX = millis();
 }
 
 if (pulseTimeElapsedY > pulseExpandUnitY) {
   println("increaseY");
   println(pulseBoundY);
   if (pulseBoundY <= targetBoundY) {
     pulseBoundY++;
   }
   pulseIncTimeY = millis();
 }
 
}


void drawMultiPulse(){
  fill(0, 10);
  rect(0, 0, width, height);  
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
 if (growing == false && pulseSensor == 1) {
   if (multiPulses.size() > 0) {
      int pos = multiPulses.size() - 1;
      multiPulses.remove(pos);
  }
 }
 if (drawPulse == true) {
   runMultiPulse();
 }

}

void runMultiPulse() {  
  pushMatrix();
  //translate(PULSECTR.x, PULSECTR.y);
  if (multiPulses.size() > 0) {
    for (int i = 0; i < multiPulses.size(); i++) {
     multiPulses.get(i).run();
    }
  }
  popMatrix();
  //pulseXBound += pulseXBoundInc;
}


PVector getPulseLocation() {
 PVector newPulseLoc;
 
 newPulseLoc = hardXandY(pulseBoundX, pulseBoundY);
 
 return newPulseLoc;
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
   //println(width/newX);
   
   newLoc.y = random(0, height);
   //float yVariant = pulseYBound1* gridUnitH;
   //float yOff = random(-yVariant, yVariant);
   //newY = newY + yOff;
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