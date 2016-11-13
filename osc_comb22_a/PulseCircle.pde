
class Circle {
  PVector location;
  float initSize = random(1, 3);
  float size = initSize;
  
  Circle(PVector iLoc) {
    location = iLoc.copy();
    initSize = random(3, 5);
    size = initSize;
    
  }


  void run() {
    //pushMatrix();
    //noStroke();
    //ellipseMode(CENTER);

  
    
    //if (beat == true) {
    //  size = lerp(size, initSize * 8, 0.1);
    //} else {
    //  size = lerp(size, initSize, 0.05);
    //}

    //// Clear background of elipse 
    //fill(0);
    //ellipse(location.x, location.y, size+10, size+10); 
    
    //fill(200, 50);
    
    //for (int i = 1; i < 85; i++) {
    //float d = 10/(i);
    //ellipse(location.x, location.y, size+d, size+d);
    //}
    //popMatrix();
  }
}