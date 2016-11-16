class SpinPulse {
  float x = random(-pulseXBound, pulseXBound);
  float y = random(-pulseXBound, pulseXBound);
  float pulseSmall = 0.0015 * width;
  float pulseLarge = 0.0040 * width;
  float initSize = random(pulseSmall, pulseLarge);
  float size = initSize;
  float clr = 255;
  float opacity = 50;
  float pulseSzMultiplier = 4;
  float lerpAmount = 0.05;
  
  SpinPulse() {
    
  }

  void run() {
    if (beat == true) {
      size = lerp(size, initSize * pulseSzMultiplier, lerpAmount);
    } else {
      size = lerp(size, initSize, lerpAmount);
    }

    pushMatrix();
    fill(clr, opacity);
    noStroke();
    ellipse(x, y, size, size);
    ellipse(x, y, size/2, size/2);
    ellipse(x, y, size/3, size/3);
    popMatrix();
  }
}