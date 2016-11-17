class PulseMarker {
  PVector location;
  float x;
  float y;
  float pulseSmall = 0.0007 * width;
  float pulseLarge = 0.0030 * width;
  float initSize = random(pulseSmall, pulseLarge);
  float size = initSize;
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
    timeBtwBeats = ONEMINUTE/bpm;
    prevBeatTime = millis();
    
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
    ellipse(x, y, size, size);
    ellipse(x, y, size/2, size/2);
    ellipse(x, y, size/3, size/3);
  }
}