boolean emg1 = false;
boolean emg2 = false;
boolean emg3 = false;
boolean emg4 = false;
boolean emg5 = false;
boolean emg6 = false;
boolean pulse1 = false;
boolean pulse2 = false;
boolean pulse3 = false; 



void keyPressed() {
  if (key == '1') {
    if (emg1 == false) {
      emg1 = true; 
      emg2 = false;
      emg3 = false;
      emg4 = false;
      emg5 = false; 
      return;
    }
    //if (emg1 == true) {
    //  emg1 = false; 
    //  return;
    //}
  }

  if (key == '2') {
    if (emg2 == false) {
      emg1 = false; 
      emg2 = true;
      emg3 = false;
      emg4 = false;
      emg5 = false;
      return;
    }
    //if (emg2 == true) {
    //  emg2 = false; 
    //  return;
    //}
  }

  if (key == '3') {
    if (emg3 == false) {
      emg1 = false; 
      emg2 = false;
      emg3 = true;
      emg4 = false;
      emg5 = false;
      
      return;
    }
    //if (emg3 == true) {
    //  emg3 = false; 
    //  return;
    //}
  }

  if (key == '4') {
    if (emg4 == false) {
      emg1 = false; 
      emg2 = false;
      emg3 = false;
      emg4 = true;
      emg5 = false; 
      return;
    }
    //if (emg4 == true) {
    //  emg4 = false; 
    //  return;
    //}
  }

  if (key == '5') {
    if (emg5 == false) {
      emg1 = false;
      emg2 = false;
      emg3 = false;
      emg4 = false;
      emg5 = true; 
      return;
    }
    //if (emg5 == true) {
      
    //  emg5 = false; 
    //  return;
    //}
  }

  if (key == '6') {
    if (emg6 == false) {
      emg6 = true; 
      return;
    }
    if (emg6 == true) {
      emg6 = false; 
      return;
    }
  }
  
  // turn emg off entirely
  if (key == '0') {
    emg1 = false;
    emg2 = false;
    emg3 = false;
    emg4 = false;
    emg5 = false;
    emg6 = false;
  }


  // show hide pulse -- growing
  if (key == '7') {
    if (pulse1 == false) {
      pulse1 = true; 
      return;
    }
    if (pulse1 == true) {
      pulse1 = false; 
      return;
    }
  }

  // animate 
  if (key == '8') { 
    if (animate == false) {
      animate = true; 
      return;
    }
    if (animate == true) {
      animate = false; 
      return;
    }
  }

  // stop from growing / toggle growing pulse
  if (key == '9') {
    if (pulse2 == false) {
      pulse2 = true; 
      pulse1 = false;
      return;
    }
    if (pulse2 == true) {
      pulse2 = false;
      pulse1 = true;
      return;
    }
  }

  if (key == CODED) {
    if (keyCode == UP) {
      println("u");
      minSpeed+= 0.00000001;
    }

    if (keyCode == DOWN) {
      println("d");
      minSpeed-= 0.00000001;
    }
    
    if (keyCode == LEFT) {
     println("enter");
     drawBigTriangle();

    }
  }
}

void runControls() {


  // TO DO -- ADD LABELS TO THESE
  if (emg1 == true) {
    //background(0);
    drawEmgVehicles();
    emgRunning = true;
    emgState = 1;
  }
  if (emg2 == true) {
    //background(0);
    drawEmgVehicles();
    emgRunning = true;
    emgState = 2;
  }
  if (emg3 == true) {
    //background(0);
    drawEmgVehicles();
    emgRunning = true;
    emgState = 3;
  }
  if (emg4 == true) {
    //background(0);
    drawEmgVehicles();
    emgRunning = true;
    emgState = 4;
  }
  if (emg5 == true) {
    //background(0);
    drawEmgVehicles();
    emgRunning = true;
    emgState = 5;
  }

  if (emg6 == true) {
    drawBigTriangle();
  }

  if (pulse1 == true) {
    drawPulse = true;
    if (currentBpm > 10) {
      if (!growing) {
        //begin timer
        pulseStartTime = millis();
        pulseIncTimeX = pulseStartTime;
        pulseIncTimeY = pulseStartTime;
      }
      growing = true;

      expandPulseBounds();
      //noBoundExpansion();

      drawMultiPulse();
    }
  }

  if (pulse2 == true) {
    drawPulse = true;
    if (currentBpm > 10) {
      growing = false;

      expandPulseBounds();
      //noBoundExpansion();

      drawMultiPulse();
    }
  }
}


  //boolean toggleKey(boolean scene) {
  //  println("THERE");
  //  boolean newScene = scene;
  //  if (scene == false) {
  //    println("it's false");
  //    newScene = true; 
  //  } else if (scene == true) {
  //    println("it's true");
  //    println("it's true");
  //    newScene = false; 
  //  }
  //  scene = newScene;
  //  return scene;
  //}