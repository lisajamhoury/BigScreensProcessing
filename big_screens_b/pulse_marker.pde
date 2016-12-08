class PulseMarker {
  PVector location;
  float pulseSmall = 0.0007 * width;
  float pulseLarge = 0.0030 * width;
  float pulseInc = pulseSmall/10;
  float rH = pulseRectHeight;
  float initSize;
  float size;
  float lerpSize;
  float clr;
  float permClr;
  float opacity = 50;
  float pulseSzMultiplier = 10;
  float lerpAmount = 0.01;
  int bpm;
  int prevBeatTime;
  int timeSinceBeat = 0;
  int timeBtwBeats;
  PVector acceleration;
  PVector velocity;
  float velocityX;
  boolean fadeComplete = true;
  boolean drawMarker = true;
  boolean newPulse = true;
  boolean beatCtr = false;
  float lerpTint = 0;

  PulseMarker(PVector iLoc) {
    location = iLoc;
    bpm = currentBpm;
    timeBtwBeats = ONEMINUTE/bpm;
    prevBeatTime = millis();
    initSize = map(currentBpm, LOWBPM, HIGHBPM, resolution, pulseSmall); // reverse mapping, slower is larger
    size = initSize;
    lerpSize = size;
    acceleration = new PVector(0, 0);
    //velocityX = map(currentBpm, LOWBPM, HIGHBPM, 0.1, .5); // slower is slower 
    //velocity = new PVector(velocityX, 0);
    clr = map(currentBpm, LOWBPM, HIGHBPM, 255, 100); // reverse mapping, slower is brighter
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
    if (newPulse == true) {
       drawPulseCircle();
    } else { 
      drawCross();
    } 
  }
  
  float diam = 0;
  float diamSpeed = 0.5;
  
  //void drawPulseCircleDiam() {
  //  imageMode(CENTER);
  //  image(circleImg, location.x, location.y, diam, diam);
   
  //  diam+=diamSpeed;
  //  for (float d = diam; d > 1; d--) {
  //  //fill(255, 255/d);
  //    tint(255, 255/d);
  //    image(circleImg, location.x, location.y, d, d);
  //    ellipse(width/2, height/2, d, d);
  //  }
    
  //  if(diam > size) {
  //    diamSpeed *= -1;
  //    beatCtr = true;
  //  }
    
  //  if (diam < 1 && beatCtr == true) {
  //    newPulse= false;
  //  }
    
  //}

 
  
 void drawPulseCircleDiam() {
    imageMode(CENTER);
    image(circleImg, location.x, location.y, diam, diam);
   
    diam+=diamSpeed;
    for (float d = diam; d > 1; d--) {
    //fill(255, 255/d);
      tint(255, 255/d);
      image(circleImg, location.x, location.y, d, d);
      ellipse(width/2, height/2, d, d);
    }
    
    if(diam > size) {
      diamSpeed *= -1;
      beatCtr = true;
    }
    
    if (diam < 1 && beatCtr == true) {
      newPulse= false;
    }
    
  }
  
  void drawPulseCircle() {
    if (beat == true && beatCtr == false) {
      beatCtr = true;
      lerpSize = lerp(0, initSize * 10, 0.05);
      lerpTint = lerp(0,255, 0.05);
    } 
    
    else {
      lerpSize = lerp(lerpSize, 0, 0.05);
      lerpTint = lerp(255, 0, 0.05);
    }
    
    imageMode(CENTER);
    tint(255, lerpTint);
    image(circleImg, location.x, location.y, lerpSize, lerpSize);
    
    if (lerpSize < 1 && beatCtr == true) {
      newPulse = false;
      initSize = lerpSize;
      size = lerpSize;
    }
    
    //if (beatCtr == true) {
    // newPulse = false; 
   //}//
  }
  

  void drawCross() {
    initSize +=pulseInc;
    size+=pulseInc;
    if (drawMarker == true) {
      if (animate == true) animate();

      timeSinceBeat = millis() - prevBeatTime;

      if (timeSinceBeat > timeBtwBeats) {

        size = lerp(size, initSize * pulseSzMultiplier, lerpAmount);
        prevBeatTime = millis();
      } else {
        size = lerp(size, initSize, lerpAmount);
      }


      fill(255, 255, 255, clr);
      noStroke();
      rectMode(CENTER);
      rect(location.x, location.y, size, rH);
      rect(location.x, location.y, rH, size);
      rectMode(CORNER);
    }
  }
}