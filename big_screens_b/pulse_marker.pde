class PulseMarker {
  PVector location;
  float x;
  float y;
  float pulseSmall = 0.0007 * width;
  float pulseLarge = 0.0030 * width;
  float rH = 0.0006 * width;
  //float initSize = random(pulseSmall, pulseLarge);
  float initSize;
  float size;
  float clr = 255;
  float opacity = 50;
  float pulseSzMultiplier = 10;
  float lerpAmount = 0.09;
  int bpm;
  int prevBeatTime;
  int timeSinceBeat = 0;
  int timeBtwBeats;
  
  
  PulseMarker(PVector iLoc) {
    location = iLoc;
    x = iLoc.x;
    y = iLoc.y;
    bpm = currentBpm;
    timeBtwBeats = ONEMINUTE/bpm; // TO DO  -- test that your fix for this bug is really working
    prevBeatTime = millis();
    initSize = map(currentBpm, 40, 200, resolution, pulseSmall); // map pulse size to bpm speed 
    size = initSize;
  }

  void run() {
    timeSinceBeat = millis() - prevBeatTime;
    
    if (timeSinceBeat > timeBtwBeats) {
      size = lerp(size, initSize * pulseSzMultiplier, lerpAmount);
      prevBeatTime = millis();
    } else {
      size = lerp(size, initSize, lerpAmount);
    }

    fill(clr, opacity);
    noStroke();
    //ellipse(x, y, size, size);
    //ellipse(x, y, size/2, size/2);
    //ellipse(x, y, size/3, size/3);
    
    rectMode(CENTER);
    
    rect(x, y, size, rH);
    rect(x, y, size/2, rH/2);
    rect(x, y, size/3, rH/3);

  }
}