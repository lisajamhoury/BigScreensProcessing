class BinaryLine {
  PVector pos;
  float data;
  float ioUnit = 0.002*width;
  int numInputs = 5;
  float prevStrLength = 0;
  
  BinaryLine(int iOrder, float iData) {
    data = iData;
    
    float inputSize = numInputs*ioUnit;
    float yOffset = (height - inputSize) / 2;
    float posY = yOffset + iOrder * ioUnit;
    
    pos = new PVector(0, posY); 
  }
  
  
  void update(float newData) {
    data = newData;
    pos.x = pos.x + prevStrLength;
    
    if (pos.x > width) {
      pos.x = 0;
    }
  }
  
  void run() {  
    //println(pos.x);
    colorMode(RGB);
    fill(255);
    String binaryStr = binary(floor(data));
    int firstOne = binaryStr.indexOf("1");
    if (firstOne < 0) {
      return;
    }
    String strNoZeros = binaryStr.substring(firstOne);
    pushMatrix();
    translate(pos.x,pos.y,0);
    for (int i = 0; i < strNoZeros.length(); i++){
      translate(ioUnit,0,0);
      if (strNoZeros.charAt(i) == '1') {
        fill(255);
        ellipse(0, 0, ioUnit, ioUnit);
      } else {
        fill(0);
        ellipse(0, 0, ioUnit,ioUnit);
     }
    }
    popMatrix();
    prevStrLength = strNoZeros.length()*ioUnit;
  }
  
  
  

  
}