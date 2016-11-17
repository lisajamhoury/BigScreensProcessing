//////////////// BEGIN PULSE  ////////////////
boolean beat = false;

//////////////// MULTI PULSE ////////////////
boolean growing = false;
boolean drawPulse = false; // allows for pulse array to grow but not be drawn on screen
int pulseCount = 0; // add pulse every two
ArrayList<PulseMarker> multiPulses;

//size of spin pulses
//float pulseXBound;
//float pulseXBoundInc;
 
void setupMultiPulse() {
  //pulseXBound = 0.01 * width;
  //pulseXBoundInc = 0.00005 * width;
  
  multiPulses = new ArrayList<PulseMarker>();
}

PVector getPulseLocation() {
 PVector newPulseLoc;
 float newX = PULSECTR.x; 
 float newY = PULSECTR.y;
 
 int xOrY = floor(random(2));

 int pulseXBound1 = 6; // variable this over time
 int pulseYBound1 = 6; // variable this over time
 
  if (xOrY == 0) {
   // choose a line 
   int xLine = floor(random(-pulseXBound1, pulseXBound1));
   float scaleUpXLine = resolution * xLine; // get amount of width to scale by
   newX = PULSECTR.x + scaleUpXLine;
   //println(width/newX);
   
   newY = random(0, height);
   //float yVariant = pulseYBound1* gridUnitH;
   //float yOff = random(-yVariant, yVariant);
   //newY = newY + yOff;
 }
 
 if (xOrY == 1) { 
   // choose a line 
   int yLine = floor(random(-pulseYBound1, pulseYBound1));
   float scaleUpYLine = resolution * yLine; // get amount of width to scale by
   newY = PULSECTR.y + scaleUpYLine;
   
   //float xVariant = pulseXBound1 * resolution;
   //float xOff = random(-xVariant, xVariant);
   //newX = newX + xOff;
   newX = random(0, width);
 }

 newPulseLoc = new PVector(newX, newY);
 return newPulseLoc;
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
      multiPulses.add(new PulseMarker(pulseLoc));
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

//////////////// END MULTI PULSE ////////////////