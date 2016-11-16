 class SlowVehicle {
  PVector position;
  PVector acceleration;
  PVector velocity;
  float r;
  float maxspeed;
  float maxforce;
  float lifespan;
  float vBright; 
  PGraphics canv;
  float lineSz = 0.0000008 * AREA;
  float lineStk = 0.0000004 * AREA;
  float sensorVal;

  
  PVector prevPos;
  
  SlowVehicle(float iBright, float x, float y, float ms, float mf) {
    position = new PVector(x,y);
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    r = 4;
    maxspeed = ms;
    maxforce = mf;
    lifespan = 45;
    //canv = iCanv;
    //offset = iOffset;
    //hue = iHue;
    vBright = iBright;
    prevPos = position.copy();  
  }

  void run(PGraphics iCanv, float iSensor) {
    canv = iCanv;
    sensorVal = iSensor;
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
    vBright = map(sensorVal, 20, 1000, 10, 250);
    maxspeed = getVSpeed(sensorVal);
   
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 0.1;

  }
  
  
  float getVSpeed(float sensorVal) {
   float speed;   
    if (sensorVal > 850) {
      speed = AREA * maxSpeed;
    } else if (sensorVal < 50) {
      speed = AREA * minSpeed;
    } else {
     speed = random(AREA*minSpeed, AREA*maxSpeed); 
    }
   return speed;
 }
    

  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
      
  void display() {
    float theta = velocity.heading() + PI/2;
    canv.colorMode(HSB);
    canv.stroke(0, 0, vBright);
    canv.strokeWeight(lineStk);
    canv.pushMatrix();
    //canv.translate(position.x-offset,position.y);
    canv.translate(position.x,position.y);
    canv.rotate(theta);
    canv.ellipse(0,0,lineSz,lineSz);
    canv.popMatrix();
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