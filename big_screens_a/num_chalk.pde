class NumChalk {
 PVector pos;
 float data;
 float lowerBound;
 float upperBound;
 float inc = 0.003 * height;
 float tSz = 0.05 * height;
 
  NumChalk(float iData, float iLBound, float iUBound) {
    data = iData;
    lowerBound = iLBound;
    upperBound = iUBound;
    
    float randX = random(lowerBound, upperBound);
    float randY = random(0, height);
    pos = new PVector(randX, randY); 
    
  }
  
  float getNewColumn() {
    float newX = random(lowerBound, upperBound);
    return newX;
  }
    
  void update(float newData) {
    data = newData;
    pos.y = pos.y + inc;
    if (pos.y > height) {
      pos.y = 0;
      pos.x = getNewColumn();
    }
  }
  
  void run() {
    colorMode(RGB);
    
    String sens = str(floor(data)); 
    float fillT  = map(data, EMGLOWER, EMGUPPER, 150, 255);
    
    pushMatrix();
    translate(pos.x,pos.y,0);
    fill(fillT);
    textSize(tSz);
    text(sens, 0, 0);
    popMatrix();
    
  }
  
  
}