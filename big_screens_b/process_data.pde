//variables for manipulating data
// TO DO REFACTOR -- floats become ints for sensor data
int pulseSensor = 0;
float emg1LeftSensor = 0;
float emg1RightSensor = 0;
float emg2LeftSensor = 0;
float emg2RightSensor = 0;

//Constants for mapping data 
float EMGLOWER = 20;
float EMGUPPER = 1000;

//Pulse bpm timing
int pulseTimeCtr; // count time elapsed since last calculation
int pulseCtr = 0; // count number of pulses
int BPMTIMESPAN = 5000;
int ONEMINUTE = 60000;
int lastPulseSensorVal;
int currentBpm;


//pulse vairables
boolean pulse = false;

void setupProcessData() {
  pulseTimeCtr = millis();
}

void getSensorData() { 
 emg1LeftSensor = emg1L;
 emg1RightSensor = emg1R;
 emg2LeftSensor = emg2L;
 emg2RightSensor = emg2R;
 pulseSensor = polar0;
 
 calculateBpm();
}


void calculateBpm() {
 int timeElapsed = millis() - pulseTimeCtr; 

 if (pulseSensor == 1 && lastPulseSensorVal == 0) {
   pulseCtr++;
 }
  
 if (timeElapsed > BPMTIMESPAN) {
  currentBpm = (ONEMINUTE/BPMTIMESPAN)*pulseCtr; 
  pulseTimeCtr = millis();
  pulseCtr = 0;
 }
 lastPulseSensorVal = pulseSensor;
}




// Get logic from left and right emg sensors
// TODO  delete all color data? 
String emgLogic(float leftSensor, float rightSensor) {
  String status = "neutral";
  //color clr = color(255,255,255);
  
  if (leftSensor > 900 && rightSensor > 900) {
    status = "high";
    //clr = color(255,0,0);
    // red
    //bright = 255;
  } else if (leftSensor > 900) {
    status = "left high";
    // green
    //bright = 200;
    //clr = color(0,255,0);
  } else if (rightSensor > 900) { 
    status = "right high";
  } else if (leftSensor < 300 && rightSensor < 300) {
    status = "low";
    // blue 
    //bright = 20;
    //clr = color(0,0,255);
  } else if (abs(leftSensor - rightSensor) <=100) {
    status = "close";
    //white
    //bright = 100;
    //clr = color(255,255,255);
  } 
 
 return status;
}