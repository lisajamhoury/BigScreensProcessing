class PulseMarker {
  PVector location;
  //float x;
  //float y;
  float pulseSmall = 0.0007 * width;
  float pulseLarge = 0.0030 * width;
  float rH = pulseRectHeight;
  
  //float initSize = random(pulseSmall, pulseLarge);
  float initSize;
  float size;
  float clr;
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
  
  PulseMarker(PVector iLoc) {
    location = iLoc;
    bpm = currentBpm;
    timeBtwBeats = ONEMINUTE/bpm; // TO DO  -- test that your fix for this bug is really working, bpm hitting 0
    prevBeatTime = millis();
    initSize = map(currentBpm, 40, 200, resolution, pulseSmall); // map pulse size to bpm speed 
    
    size = initSize;
    acceleration = new PVector(0,0);
    velocityX = map(currentBpm, 40, 200, 0.1, .5); // slower is slower 
    velocity = new PVector(velocityX, 0);
    clr = map(currentBpm, 40, 200, 255, 10); // reverse mapping, slower is brighter
  }
  
  
  void animate() {
    location.add(velocity);
  }

  void run() {
    if (animate == true) animate();
 
    timeSinceBeat = millis() - prevBeatTime;
    
    if (timeSinceBeat > timeBtwBeats) {
      size = lerp(size, initSize * pulseSzMultiplier, lerpAmount);
      prevBeatTime = millis();
    } else {
      size = lerp(size, initSize, lerpAmount);
    }

    //fill(clr, opacity);
    fill(clr);
    noStroke();
    //ellipse(location.x, location.y, size, size);
    //ellipse(location.x, location.y, size/2, size/2);
    //ellipse(location.x, location.y, size/3, size/3);
    rectMode(CENTER);
    //make them big
    //size = 200;
    //rH = 10;
    rect(location.x, location.y, size, rH);
    rect(location.x, location.y, size/2, rH/2);
    rect(location.x, location.y, size/3, rH/3);
    rectMode(CORNER);

  }
}