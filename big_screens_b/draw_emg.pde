
// Collect setup functions for draw functions here 
void setupDrawSensors() {
  setupEmgVehicles();
  setupMultiPulse();
}


//////////////// EMG VEHICLES ////////////////
import java.util.Iterator;

//DEBUG
boolean debugFrameRate = false;
boolean debugFlowField = false;

FlowField flowfield;
ArrayList<Magnet> magnet;
boolean emgRunning = true;

ArrayList<PVector> fieldOutPointsLeft;
ArrayList<PVector> fieldOutPointsRight;

ArrayList<Vehicle> vehicles1L;
ArrayList<Vehicle> vehicles1R;
ArrayList<Vehicle> vehicles2L;
ArrayList<Vehicle> vehicles2R;
PVector v1LStart;
PVector v1RStart;
PVector v2LStart;
PVector v2RStart;

float minSpeed =  0.00000007; //0.00000030;
float maxSpeed = 4*minSpeed;
float force = 0.0000001;

// to control which part of emg sketch is drawn
int emgState = 0;

void setupEmgVehicles() {
  noiseSeed(7); // 7 ok, but a bit too noisy on right

  flowfield = new FlowField(resolution); // resolution declared globally
  magnet = new ArrayList<Magnet>(); 
  fieldOutPointsLeft = new ArrayList<PVector>();
  fieldOutPointsRight = new ArrayList<PVector>();

  flowfield.init();

  PVector magnetPos = new PVector(PULSECTR.x, 1.25 * PULSECTR.y);
  flowfield.update(magnetPos);

  vehicles1L = new ArrayList<Vehicle>();
  vehicles1R = new ArrayList<Vehicle>();
  vehicles2L = new ArrayList<Vehicle>();
  vehicles2R = new ArrayList<Vehicle>();

  //EMG START POSITIONS 
  float v1Lx = 0;
  float v1Ly = 0.5 * height;
  float v1Rx = 0;
  float v1Ry = 0.73 * height;
  float v2Lx = width-1;
  float v2Ly = 0.2 * height;
  float v2Rx = width-1;
  float v2Ry = 0.35 * height;

  v1LStart = new PVector(v1Lx, v1Ly);
  v1RStart = new PVector(v1Rx, v1Ry);
  v2LStart = new PVector(v2Lx, v2Ly);
  v2RStart = new PVector(v2Rx, v2Ry);
}

void drawEmgVehicles() {
  emgRunning = true;
  addEmgVehicles();
  runEmgVehicles();
  if (debugFrameRate == true) {
    debugFrameRate();
  }

  if (debugFlowField == true) {
    debugFlowField();
  }
}

void drawBigTriangle() {
  String emg1Logic = emgLogic(emg1LeftSensor, emg1RightSensor);
  String emg2Logic = emgLogic(emg2LeftSensor, emg2RightSensor);
  println("triangle");
  println(emg1Logic, emg2Logic);
  // draw white triange if 
  if (emg1Logic == "high" && emg2Logic == "high") {
    println("BOTH HIGH!!!!!!!");
    fill(255);  
    beginShape();
    vertex(0, height);
    vertex(width, 0);
    vertex(width, height);
    endShape();
  }
}

void addEmgVehicles() {
  float bright1L = map(emg1LeftSensor, 20, 1000, 10, 255);
  float bright1R = map(emg1RightSensor, 20, 1000, 10, 255);
  float bright2L = map(emg2LeftSensor, 20, 1000, 10, 25);
  float bright2R = map(emg2RightSensor, 20, 1000, 10, 255);

  String emg1Logic = emgLogic(emg1LeftSensor, emg1RightSensor);
  String emg2Logic = emgLogic(emg2LeftSensor, emg2RightSensor);

  if (emgState == 5) {
    makeCrazyLinesLogic(emg1Logic, v1LStart, v1RStart, fieldOutPointsLeft);
    makeCrazyLinesLogic(emg2Logic, v2LStart, v2RStart, fieldOutPointsRight);
  }

  //if (emgState == 6) {
  //  //makeBigTriangle();
  //  println("herer");
  //  v1LStart.x = 0.016455347;
  //  v1LStart.y = 207.82713;
  //  //v1LStart.x = 0.001;
  //  //v1LStart.y = height - 0.01;
  //  //int lastPos = vehicles1L.size()-1;
  //  //Vehicle myVehicle = vehicles1L.get(lastPos);
  //  //myVehicle.position.x.set(0.001);


  //}

  vehicles1L.add(new Vehicle(emg1Logic, bright1L, v1LStart.x, v1LStart.y, random(AREA*minSpeed, AREA*maxSpeed), random(AREA*force)));
  vehicles1R.add(new Vehicle(emg1Logic, bright1R, v1RStart.x, v1RStart.y, random(AREA*minSpeed, AREA*maxSpeed), random(AREA*force)));
  vehicles2L.add(new Vehicle(emg2Logic, bright2L, v2LStart.x, v2LStart.y, random(AREA*minSpeed, AREA*maxSpeed), random(AREA*force)));
  vehicles2R.add(new Vehicle(emg2Logic, bright2R, v2RStart.x, v2RStart.y, random(AREA*minSpeed, AREA*maxSpeed), random(AREA*force)));
}

void runEmgVehicles() {
  runVehiclesIterator(vehicles1L, v1LStart, "left");
  runVehiclesIterator(vehicles1R, v1RStart, "left");
  runVehiclesIterator(vehicles2L, v2LStart, "right");
  runVehiclesIterator(vehicles2R, v2RStart, "right");
}

void runVehiclesIterator(ArrayList<Vehicle> vehicles, PVector startPos, String side) {
  if (emgRunning == true) {
    Iterator<Vehicle> it = vehicles.iterator();
    while (it.hasNext()) {
      Vehicle v = it.next();
      v.follow(flowfield);
      v.run();
      if (v.isDead()) {
        if (side == "left") {
          if (v.position.x > PULSECTR.x) {
            PVector reStart = new PVector(0, random(height));
            startPos.set(reStart);
          } else {
            startPos.set(v.position);
          }
        }

        if (side == "right") {
          if (v.position.x < 0.55 * width) {
            PVector reStart = new PVector(width-1, random(height));
            startPos.set(reStart);
          } else {
            startPos.set(v.position);
          }
        }

        //startPos = v.position.copy(); 
        //startPos.set(v.position);
        it.remove();
      }
    }
  }
}


void makeCrazyLinesLogic(String logic, PVector startPosL, PVector startPosR, ArrayList<PVector> fieldPtsArray) {
  int noOutPoints = fieldPtsArray.size();
  int noPoint = int(random(noOutPoints));
  PVector newStart = fieldPtsArray.get(noPoint);

  if (logic == "high") {
    startPosL.x = newStart.x;
    startPosL.y = height;
    startPosR.x = newStart.x;
    startPosR.y = height;
  } else if (logic == "left high") {  
    startPosL.x = newStart.x;
    startPosL.y = height;
  } else if (logic == "right high") {
    startPosR.x = newStart.x;
    startPosR.y = height;
  } else if (logic == "low") {
    float yOff = 0.1 * height;
    startPosL.y = height/2 + random(-yOff, yOff);
    startPosR.y = height/2 + random(-yOff, yOff);
  }
}


void debugFrameRate() {
  //FRAMERATE BOX
  colorMode(RGB);
  fill(255, 0, 0);
  rect(0, 0, 100, 100);
  fill(255);
  text(floor(frameRate), 10, 40);
  text(floor(vehicles1L.size()), 10, 60);
  text(floor(vehicles1R.size()), 10, 80);
  text(floor(vehicles2L.size()), 10, 100);
  text(floor(vehicles2R.size()), 10, 120);
}

void debugFlowField() {
  flowfield.display();

  Iterator<Magnet> it = magnet.iterator();
  while (it.hasNext()) {
    Magnet m = it.next();
    m.display();
  }
}


//////////////// END EMG VEHICLES ////////////////