class Pulse {
  float x = random(-pulseXBound, pulseXBound);
  float y = random(-pulseXBound, pulseXBound);
  //float x = random(-(frCounter) / 6, (frCounter) / 6);
  //float y = random(-(frCounter) / 6, (frCounter) / 6);
  float initSize = random(pulseSmall, pulseLarge);
  float size = initSize;
  float clr = 255;
  
  Pulse() {
    
  }

  

  void run() {
    if (beat == true) {
      size = lerp(size, initSize * 10, 0.1);
    } else {
      size = lerp(size, initSize, 0.05);
    }

    pushMatrix();
    fill(clr, 50);
    noStroke();
    ellipse(this.x, this.y, this.size, this.size);
    ellipse(this.x, this.y, this.size/2, this.size/2);
    ellipse(this.x, this.y, this.size/3, this.size/3);
    popMatrix();
  }
}