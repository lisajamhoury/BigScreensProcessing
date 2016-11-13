////////////////////////// PULSE FUNCTIONS ////////////////////////// 
void pulse(){
  
  if (growing == true) { 
  if (pulseSensor == 1 && beat == false) {
    beat = true;
    timePulse = millis();   
    cCount++;
 
    // every two heart beat creates a circle
    if (cCount == 2) {
      cCount = 0;
      pulses.add(new Pulse());
    }
  }
 
 if ( pulseSensor == 0 && beat == true ) {
   beat = false;
   timePulse = millis();
   
  }
 } //growing true
 
 
 if (growing == false && pulseSensor == 1) {
   if (pulses.size() > 0) {
      int pos = pulses.size() - 1;
      pulses.remove(pos);
  }

    timePulse = millis();
 }
 if (runPulse == true) {
   runPulse();
 }
}

void runPulse() {  
  // Clear center background only behind pulse  
  //fill(0,10);
  //rect(oneThird, 0, twoThird, height);
  fill(0, 10);
  rect(0, 0, width, height);  
  
  pushMatrix();
  translate(pulseCtr.x, pulseCtr.y);
  rotate(frameCount * 0.01);
  for (int i = 0; i < pulses.size(); i++) {
   pulses.get(i).run();
  }
  popMatrix();
  pulseXBound += pulseXBoundInc;


}

////////////////////////// EMG FUNCTIONS //////////////////////////

float bright1L;
float bright1R;
float bright2L;
float bright2R;

void drawFlowLinesEMGSingleCanv() {
  bright1L = map(emg1LeftSensor, 20, 1000, 10, 255);
  bright1R = map(emg1RightSensor, 20, 1000, 10, 255);
  bright2L = map(emg2LeftSensor, 20, 1000, 10, 250);
  bright2R = map(emg2RightSensor, 20, 1000, 10, 250);
  
  color emg1LogicClr = emgLogicClr(emg1LeftSensor, emg1RightSensor);
  color emg2LogicClr = emgLogicClr(emg2LeftSensor, emg2RightSensor);
  
  String emg1Logic = emgLogic(emg1LeftSensor, emg1RightSensor);
  String emg2Logic = emgLogic(emg2LeftSensor, emg2RightSensor);
  
  //if (emg1Logic == "high") {
  //  v1LStart.y = 0;
  //  v1RStart.y = 0;
  //}
  
  //if (emg1Logic == "low") {
  //  v1LStart.y = height/2;
  //  v1RStart.y = height/2;
  //} 
  
  //if (emg2Logic == "high") {
  //  v2LStart.y = height + 1;
  //  v2RStart.y = height + 1;
  //}
  
  //if (emg2Logic == "low") {
  //  v2LStart.y = height/2;
  //  v2RStart.y = height/2;
  //}
  
  //println(v2Start)
  //for (int i = 0; i < 10; i++) {
  vehicles1L.add(new Vehicle(emg1LogicClr, bright1L, v1LStart.x, v1LStart.y, random(protoArea*minSpeed, protoArea*maxSpeed), random(protoArea*force)));
  vehicles1R.add(new Vehicle(emg1LogicClr, bright1R, v1RStart.x, v1RStart.y, random(protoArea*minSpeed, protoArea*maxSpeed), random(protoArea*force)));
  vehicles2L.add(new Vehicle(emg2LogicClr, bright2L, v2LStart.x, v2LStart.y, random(protoArea*minSpeed, protoArea*maxSpeed), random(protoArea*force)));
  vehicles2R.add(new Vehicle(emg2LogicClr, bright2L, v2RStart.x, v2RStart.y, random(protoArea*minSpeed, protoArea*maxSpeed), random(protoArea*force)));
  //}

   
}



String emgLogic(float leftSensor, float rightSensor) {
  String status = "neutral";
  color clr = color(255,255,255);
  
  if (leftSensor > 900 && rightSensor > 900) {
    status = "high";
    clr = color(255,0,0);
    // red
    bright = 255;
  } else if ((leftSensor > 900 && rightSensor < 500) ||  (rightSensor > 900 && leftSensor  < 500)) {
    status = "one high";
    // green
    bright = 200;
    clr = color(0,255,0);
  } else if (leftSensor < 300 && rightSensor < 300) {
    status = "low";
    // blue 
    bright = 20;
    clr = color(0,0,255);
  } else if (abs(leftSensor - rightSensor) <=100) {
    status = "close";
    //white
    bright = 100;
    clr = color(255,255,255);
  } 
 
 return status;
}


color emgLogicClr(float leftSensor, float rightSensor) {
  String status = "neutral";
  color clr = color(255,255,255);
  
  if (leftSensor > 900 && rightSensor > 900) {
    status = "high";
    clr = color(255,0,0);
    // red
    bright = 255;
  } else if ((leftSensor > 900 && rightSensor < 500) ||  (rightSensor > 900 && leftSensor  < 500)) {
    status = "one high";
    // green
    bright = 200;
    clr = color(0,255,0);
  } else if (leftSensor < 300 && rightSensor < 300) {
    status = "low";
    // blue 
    bright = 20;
    clr = color(0,0,255);
  } else if (abs(leftSensor - rightSensor) <=100) {
    status = "close";
    //white
    bright = 100;
    clr = color(255,255,255);
  } 
 
 return clr;
}


void runEmgVehicles(ArrayList<Vehicle> vehicles, PVector startPos, String side) {
   if (emgRunning == true) {
    Iterator<Vehicle> it = vehicles.iterator();
    while (it.hasNext()) {
      Vehicle v = it.next();
      v.follow(flowfield);
      v.run();
      if (v.isDead()) {
        if (side == "left") {
          if (v.position.x > pulseCtr.x) {
            PVector reStart = new PVector(0, random(height));
            startPos.set(reStart);
          } else {
            startPos.set(v.position);
          }
        }
        
        if (side == "right") {
          println(v.position.x);
          if (v.position.x < 0.55 * width) {
            println("restart right");
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







void drawFlowLinesEMG() {
  float canvasUnit = width/8;
  
  float emg1LeftSensor1 = map(emg1LeftSensor, 20, 1000, 0, 255);
  bright = emg1LeftSensor1;

  float emg1LeftSensor2 = map(emg1LeftSensor, 20, 1000, 150, 250);
  brightIo = emg1LeftSensor2;
  //emgAmount = leftSensorEmg2;
  //rightSensorEmg = map(rightSensorEmg, 20, 1000, 0, 255);
  
  //canvas 1  
  //if (v1Start.x >= 0 && v1Start.x < canvasUnit) {
  //  currentCanvL = canvas1;
  //  currentCanvOffsetL = 0;
  //  //currentCanvHueL = 255;
  //}
  
  ////canvas 2
  //if (v1Start.x >= canvasUnit && v1Start.x < canvasUnit * 2) {
  //  currentCanvL = canvas2;
  //  currentCanvOffsetL = canvasUnit;
  //  //currentCanvHueL = 200;
  //}
  
  ////canvas 3
  //if (v1Start.x >= canvasUnit * 2 && v1Start.x < canvasUnit * 3) {
  //  currentCanvL = canvas3;
  //  currentCanvOffsetL = canvasUnit * 2;
  //  //currentCanvHueL = 100;
  //}
  
  ////canvas 4
  //if (v2Start.x >= canvasUnit * 6 && v2Start.x <= canvasUnit *8) {
  //  currentCanvR = canvas4;
  //  currentCanvOffsetR = canvasUnit * 6;
  //  //currentCanvHueR = 255;
  //}
  
  ////canvas 5
  //if (v2Start.x >= canvasUnit * 5 && v2Start.x <= canvasUnit * 7) {
  //  currentCanvR = canvas5;
  //  currentCanvOffsetR = canvasUnit * 5;
  //  //currentCanvHueR = 200;
  //}
  
  ////canvas 6
  //if (v2Start.x >= canvasUnit * 4 && v2Start.x <= canvasUnit * 6) {
  //  currentCanvR = canvas6;
  //  currentCanvOffsetR = canvasUnit * 4;
  //  //currentCanvHueR = 100;
  //}
  
  //for (int i = 0; i < 2; i++) {
    //vehiclesL.add(new Vehicle(currentCanvL, currentCanvOffsetL, v1Start.x, v1Start.y, random(protoArea*minSpeed, protoArea*maxSpeed), random(protoArea*force)));
    //vehiclesR.add(new Vehicle(currentCanvR, currentCanvOffsetR, v2Start.x, v2Start.y, random(protoArea*minSpeed, protoArea*maxSpeed), random(protoArea*force)));
  //}

   
}


void emgFlowCanvas() {
  pushMatrix();
  translate(width/8, height/2, canvZ1);
  rotateX(radians(0+canvDegs));
  imageMode(CENTER);
  image(canvas1, 0, 0);
  translate(width/8, 0, canvZ2);
  image(canvas2, 0, 0);
  translate(width/8, 0, canvZ3);
  image(canvas3, 0, 0);
  translate(width*2/8, 0, canvZ6);
  imageMode(CENTER);
  image(canvas6, 0, 0);
  translate(width/8, 0, canvZ5);
  image(canvas5, 0, 0);
  translate(width/8, 0, canvZ4);
  image(canvas4, 0, 0);
  popMatrix();
  

  
}






//////////////////// Binary Options ////////////////////  

void ioOp1() {
  background(0);
  colorMode(RGB);
  fill(255);
  String lSens = binary(floor(emg1LeftSensor));
  String rSens = str(floor(emg1RightSensor));
  int firstOne = lSens.indexOf("1");
  String noZeros = lSens.substring(firstOne);
  allStrings = noZeros+allStrings;
  text(allStrings, pulseCtr.x, pulseCtr.y);
}




void ioOp2() {
  emg1LBinary.run();
  emg1LBinary.update(emg1LeftSensor);
  emg1RBinary.run();
  emg1RBinary.update(emg1RightSensor);
  
  emg2LBinary.run();
  emg2LBinary.update(emg1LeftSensor);
  emg2RBinary.run();
  emg2RBinary.update(emg1RightSensor);
  
  pulseBinary.run();
  pulseBinary.update(pulseSensor);
 
}

void ioOp3() {
  colorMode(RGB);
  fill(255);
  String lSens = binary(floor(emg1LeftSensor));
  String rSens = str(floor(emg1RightSensor));
  
  float lW = textWidth(lSens);
  float rW = textWidth(rSens); 
  //text(lSens, pulseCtr.x, pulseCtr.y);
  float rectW = map(emg1LeftSensor, 20, 1000, 1,10);
  float rectH = map(emg1LeftSensor, 20, 1000, 1,10);
  fill(brightIo);
  rect(ioL.x, ioL.y, rectW, rectH);
  rect(pulseCtr.x-rW, pulseCtr.y, rW, 10);
  
  ioL.x += rectW;
  if (ioL.x > width) {
    ioL.x = pulseCtr.x;
    ioL.y += ioHtInc;
  }
  

  ioY++;
  if (ioY > height) {
    ioY = 0;
    ioX +=10;
  }
}


void ioOp4() {
  emg1LStroke.run();
  emg1LStroke.update(emg1LeftSensor);
  emg1RStroke.run();
  emg1RStroke.update(emg1RightSensor);

  emg2LStroke.run();
  emg2LStroke.update(emg1LeftSensor); // fix me
  emg2RStroke.run();
  emg2RStroke.update(emg1RightSensor); // fix me
  
  pulseStroke.run();
  pulseStroke.update(pulseSensor); // fix me

  
}