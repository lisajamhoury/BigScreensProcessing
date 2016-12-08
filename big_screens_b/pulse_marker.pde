class PulseMarker {
  PVector location;
  float pulseSmall = 0.0007 * width;
  float pulseLarge = 0.0030 * width;
  float rH = pulseRectHeight;
  float initSize;
  float size;
  float clr;
  float permClr;
  float opacity = 50;
  float pulseSzMultiplier = 10;
  float lerpAmount = 0.09;
  int bpm;
  int prevBeatTime;
  int timeSinceBeat = 0;
  int timeBtwBeats;
  PVector acceleration;
  PVector velocity;
  float velocityX;
  boolean fadeComplete = true;
  boolean drawMarker = true;
  
  PulseMarker(PVector iLoc) {
    location = iLoc;
    bpm = currentBpm;
    timeBtwBeats = ONEMINUTE/bpm;
    prevBeatTime = millis();
    initSize = map(currentBpm, LOWBPM, HIGHBPM, pulseSmall, resolution); // map pulse size to bpm speed 
    size = initSize;
    acceleration = new PVector(0,0);
    //velocityX = map(currentBpm, LOWBPM, HIGHBPM, 0.1, .5); // slower is slower 
    //velocity = new PVector(velocityX, 0);
    clr = map(currentBpm, LOWBPM, HIGHBPM, 80, 255); // reverse mapping, slower is brighter
    permClr = clr;
  }
  
  void fadeColorDown() {
   if (clr >= 0) {
     fadeComplete = false;
     clr-=1;
    } else {
     fadeComplete = true;
     drawMarker = false;
    }
  }
  
  void fadeColorUp() {
    if (clr < permClr) {
      if (drawMarker == false) {
        drawMarker = true;
      }
     fadeComplete = false;
      clr += 1;
    } else {
     fadeComplete = true;
      
    }
  }
  
  boolean getFadeStatus() {
   return fadeComplete;
  }
  
  void animate() {
    location.add(velocity);
  }

  void run() {
    if (drawMarker == true) {
      if (animate == true) animate();
   
      timeSinceBeat = millis() - prevBeatTime;
      
      if (timeSinceBeat > timeBtwBeats) {
        size = lerp(size, initSize * pulseSzMultiplier, lerpAmount);
        prevBeatTime = millis();
      } else {
        size = lerp(size, initSize, lerpAmount);
      }
  
      fill(clr);
      noStroke();
  
      rectMode(CENTER);
      rect(location.x, location.y, size, rH);
      rect(location.x, location.y, size/2, rH/2);
      rect(location.x, location.y, size/3, rH/3);
      rectMode(CORNER);
    }

  }
}