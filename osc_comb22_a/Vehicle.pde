  class Vehicle {
  PVector position;
  PVector acceleration;
  PVector velocity;
  float r;
  float maxspeed;
  float maxforce;
  float lifespan;
  float vbright; 
  //PGraphics canv;
  //float offset;
  //float hue;
  color clr;
  ArrayList<PVector> prevPositions;

  
  PVector prevPos;
  
  Vehicle(color iClr, float iBright, float x, float y, float ms, float mf) {
    position = new PVector(x,y);
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    r = 4;
    maxspeed = ms;
    maxforce = mf;
    lifespan = 5;
    //canv = iCanv;
    //offset = iOffset;
    //hue = iHue;
    vbright = iBright;
    clr = iClr;
  
    prevPositions = new ArrayList<PVector>();  
    prevPos = position.copy();  
    
  }

  void run() {
    update();
    borders();
    display();
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(position);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    //v1Start = position;
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 0.1;
    
    prevPos = position.copy();
    prevPositions.add(prevPos);
  }

  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
      
  void display() {
    float theta = velocity.heading() + PI/2;
    //colorMode(HSB);
    //canv.stroke(hue, 0, bright, 100);
    //stroke(0, 0, vbright, 100);
    colorMode(RGB);
    stroke(clr);
    strokeWeight(0.5);
    
    beginShape();
     for (int i=0; i<prevPositions.size(); i++) {
      PVector point = prevPositions.get(i); 
      vertex(point.x, point.y);
      //line(pos.x, pos.y, prevPos.x, prevPos.y);
     }
   endShape();
    
    
    //pushMatrix();
    //translate(position.x,position.y);
    //rotate(theta);
    //ellipse(0,0,lineSz*protoArea,lineSz*protoArea);
    //popMatrix();
  }

 
  boolean isDead() {
    //if (position.x < -r) return true;
    //if (position.y < -r) return true;
    //if (position.x > width+r) return true;
    //if (position.y > height+r) return true;
    
    
    if(lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}