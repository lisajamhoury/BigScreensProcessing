boolean emg1 = false;
boolean emg2 = false;
boolean emg3 = false;
boolean emg4 = false;
boolean emg5 = false;
boolean emg6 = false;
boolean emg7 = true;
boolean pulse1 = false;
boolean pulse2 = false;
boolean pulse3 = false; 

boolean fadePulsesUp = false;
boolean fadePulsesDown = false;

boolean pulseTimerStarted = false;

boolean sloMo = false;
float currentMinSpeed = 0;



void processControls() {
  if (inKeyChar == '1') {
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

  if (inKeyChar == '2') {
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

  if (inKeyChar == '3') {
    if (emg3 == false) {
      emg1 = false; 
      emg2 = false;
      emg3 = true;
      emg4 = false;
      emg5 = false;
      
      return;
    }
  }

  if (inKeyChar == '4') {
    if (emg4 == false) {
      emg1 = false; 
      emg2 = false;
      emg3 = false;
      emg4 = true;
      emg5 = false; 
      return;
    }

  }

  if (inKeyChar == '5') {
    if (emg5 == false) {
      emg1 = false;
      emg2 = false;
      emg3 = false;
      emg4 = false;
      emg5 = true; 
      return;
    }

  }

  if (inKeyChar == '6') {
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
  if (inKeyChar == '0') {
    emg1 = false;
    emg2 = false;
    emg3 = false;
    emg4 = false;
    emg5 = false;
    emg6 = false;
    emg7 = true;
  }


  // show hide pulse -- growing
  if (inKeyChar == '7') {
    pulse1 = true;
    pulse2 = false;
    pulse3 = false;
  }
  
  if (inKeyChar == '8') {
    pulse1 = false;
    pulse2 = true;
    pulse3 = false;
    
    
  }

  // animate 
  //if (key == '8') { 
  //  if (animate == false) {
  //    animate = true; 
  //    return;
  //  }
  //  if (animate == true) {
  //    animate = false; 
  //    return;
  //  }
  //}

  // stop from growing / toggle growing/shrinking pulse
  if (inKeyChar == '9') {
    pulse1 = false;
    pulse2 = false;
    pulse3 = true;
    
  }

  //increase vehicle speed
  if (inKeyChar == 'p') {
    minSpeed+= 0.00000001;
  }

  //decrease vehicle speed
  if (inKeyChar == 'l') {
    minSpeed-= 0.00000001; 
  }
  
  //slow mo on
  if (inKeyChar == 's') {
    if (sloMo == false) {
      currentMinSpeed = minSpeed;
      sloMo = true;
     }
     minSpeed = 0.0; // slow mo 
    } // return the min speed to the prev speed 
  
  // reset emg vehicle speed after slomo 
  if (inKeyChar == 'd') {
   if (sloMo == true) {
     sloMo = false;
     minSpeed = currentMinSpeed;
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
  
  if (emg7 == true) {
    drawEmgVehicles();
    emgRunning = true;
    emgState = 7;
  }

  // start pulses, draw pulses
  if (pulse1 == true) {
    if (fadePulsesDown == true) {
      fadePulsesUp = true;
      fadePulsesDown = false;
    }
    
    drawPulse = true;
    
    // if there's a bpm and it's not growing, 
    // start the bpm timer, start growing and start expanding bounds on screen, and drawpulse  
    if (currentBpm > 10 || pulseTimerStarted == true) {
      if (!growing) {
        //begin timer
        pulseTimerStarted = true;
        println("timer started");
        pulseStartTime = millis();
        pulseIncTimeX = pulseStartTime;
        pulseIncTimeY = pulseStartTime;
      }
      growing = true;

      expandPulseBounds();

      drawMultiPulse();
    } else {
      // debugging 
      println("nope", currentBpm);
    }
  }

  // hide pulses
  if (pulse2 == true) {
    fadePulsesDown = true;
    growing = true;
    expandPulseBounds();
    drawMultiPulse();
  }

  // remove pulses 
  if (pulse3 == true) {
    if (fadePulsesDown == true) {
      fadePulsesUp = true;
      fadePulsesDown = false;
    }
    
    drawPulse = true;
    //if (currentBpm > 10) {
    growing = false;

    expandPulseBounds();
      //noBoundExpansion();

    drawMultiPulse();
    //}
  }
  

  
} // Close run controls


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