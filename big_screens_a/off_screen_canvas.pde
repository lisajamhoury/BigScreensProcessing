class OffScreenCanvas {
  PGraphics canvas;
  ArrayList<SlowVehicle> vehicles1L;
  ArrayList<SlowVehicle> vehicles1R;
  ArrayList<SlowVehicle> vehicles2L;
  ArrayList<SlowVehicle> vehicles2R;
  
  boolean debug = true;

  OffScreenCanvas() {
    canvas = createGraphics(width, height, P3D);
    canvas.beginDraw();
    canvas.clear();
    //canvas.background(255,0,0);
    canvas.endDraw();
    vehicles1L = new ArrayList<SlowVehicle>();
    vehicles1R = new ArrayList<SlowVehicle>();
    vehicles2L = new ArrayList<SlowVehicle>();
    vehicles2R = new ArrayList<SlowVehicle>();
  }
  
  void addVehicles() {
    float bright1L = map(emg1LeftSensor, 20, 1000, 10, 255);
    float bright1R = map(emg1RightSensor, 20, 1000, 10, 255);
    float bright2L = map(emg2LeftSensor, 20, 1000, 10, 255);
    float bright2R = map(emg2RightSensor, 20, 1000, 10, 255);
    
    float speed1L = getVSpeed(emg1LeftSensor); 
    float speed1R = getVSpeed(emg1RightSensor);
    float speed2L = getVSpeed(emg2LeftSensor); 
    float speed2R = getVSpeed(emg2RightSensor);
    
    vehicles1L.add(new SlowVehicle(bright1L, v1LStart.x, v1LStart.y, speed1L, random(AREA*force)));
    vehicles1R.add(new SlowVehicle(bright1R, v1RStart.x, v1RStart.y, speed1R, random(AREA*force)));
    vehicles2L.add(new SlowVehicle(bright2L, v2LStart.x, v2LStart.y, speed2L, random(AREA*force)));
    vehicles2R.add(new SlowVehicle(bright2R, v2RStart.x, v2RStart.y, speed2R, random(AREA*force)));

  }
  
 float getVSpeed(float sensorVal) {
   float speed;
      
    if (sensorVal > 850) {
      println("speed");
      speed = AREA * maxSpeed;
    } else if (sensorVal < 50) {
      println("slow");
      speed = AREA * minSpeed;
    } else {
     speed = random(AREA*minSpeed, AREA*maxSpeed); 
    }

   return speed;
 }
  
  
  
  void drawCanvas() {
    image(canvas,0,0);
    

  }
  
  void runVehicles() {
   runVehicleInterator(vehicles1L, emg1LeftSensor, v1LStart, "left");
   runVehicleInterator(vehicles1R, emg1RightSensor, v1RStart, "left");
   runVehicleInterator(vehicles2L, emg2LeftSensor, v2LStart, "right");
   runVehicleInterator(vehicles2R, emg2RightSensor, v2RStart, "right");
  }
  
  void runVehicleInterator(ArrayList<SlowVehicle> vehicles, float sensor, PVector startPos, String side) {
   canvas.beginDraw();
   if (emgRunning == true) {
    Iterator<SlowVehicle> it = vehicles.iterator();
    while (it.hasNext()) {
      SlowVehicle v = it.next();
      v.follow(flowfield);
      v.run(canvas, sensor);
      if (v.isDead()) {
        if (side == "left") {
         if (v.position.x > PULSECTR.x) {
          PVector reStart = new PVector(0, random(height));
          startPos.set(reStart);
         } else {
          int arraySz = vehicles.size();
          int pos = arraySz*8/10;
          PVector newStart = vehicles.get(pos).position;
          startPos.set(newStart);
         }
        }
        
        if (side == "right") {
         if (v.position.x < 0.55 * width) {
          PVector reStart = new PVector(width-1, random(height));
          startPos.set(reStart);
         } else {
          int arraySz = vehicles.size();
          int pos = arraySz*8/10;
          PVector newStart = vehicles.get(pos).position;
          startPos.set(newStart);
         }
        }
            
        //startPos = v.position.copy(); 
        //startPos.set(v.position);
        it.remove();
      }
    }
  }
  
  if (debug == true) {
    //FRAMERATE BOX
    canvas.colorMode(RGB);
    canvas.fill(255,0,0);
    canvas.rect(0, 0, 100, 100);
    canvas.fill(255);
    canvas.text(floor(frameRate), 10, 40);
    canvas.text(floor(vehicles1L.size()), 10, 60);
    canvas.text(floor(vehicles1R.size()), 10, 80);
    canvas.text(floor(vehicles2L.size()), 10, 100);
    canvas.text(floor(vehicles2R.size()), 10, 120); 
  }
  canvas.endDraw();
}  
    
}