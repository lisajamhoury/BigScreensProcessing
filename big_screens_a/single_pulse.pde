class SinglePulse {
  float x = PULSECTR.x;
  float y = 1.25 * PULSECTR.y; // make it lower than center screen
  float initSize = 0.1 * height;  
  float size = initSize;
  float diam = 0;
  float diamSpeed = 1;
  float pulseSzMultiplier = 4;
  float lerpAmount = 0.05;
  color baseColor = 0;
  color targetColor = 255;
  
  SinglePulse() {
  }

  void run() {
    if (beat == true) {
      size = lerp(size, initSize * pulseSzMultiplier, lerpAmount);
      size+=diamSpeed;
    } else {
      size = lerp(size, initSize, lerpAmount);
      diamSpeed *= -1;
    }
    
   fill(baseColor);
   ellipse(x, y, size, size);
   for (float d = size; d > 1; d--) {
    fill(targetColor, targetColor/d);
    ellipse(x, y, d, d);
   }
  }
}