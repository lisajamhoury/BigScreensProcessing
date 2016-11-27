//variables for manipulating data
// TO DO REFACTOR -- floats become ints for sensor data
int pulseSensor = 0;
float emg1LeftSensor = 0;
float emg1RightSensor = 0;
float emg2LeftSensor = 0;
float emg2RightSensor = 0;

//Constants for mapping data 
int EMG1LOWER = 20;
int EMG1UPPER = 400;
int EMG2LOWER = 20;
int EMG2UPPER = 400;

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
 emg1LeftSensor = mapEmgData(emg1L, EMG1LOWER, EMG1UPPER);
 emg1RightSensor = emg1R;
 emg2LeftSensor = emg2L; // fix me 
 emg2RightSensor = emg2R; // fix me ;
 pulseSensor = polar0;
 
 calculateBpm();
}


float mapEmgData(float sensorReading, int lowerBound, int upperBound) {
  if (sensorReading < lowerBound) {
    sensorReading = lowerBound;
  }
  
  if (sensorReading > upperBound) {
    sensorReading = upperBound;
  }
  
  sensorReading = map(sensorReading, lowerBound, upperBound, 0, 1000);
  return sensorReading;   
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
    
  if (leftSensor > 900 && rightSensor > 900) { // 950 instead of 900?
    status = "high";
  } else if (leftSensor > 900) {
    status = "left high";
  } else if (rightSensor > 900) { 
    status = "right high";
  } else if (leftSensor < 90 && rightSensor < 90) { // was 300
    status = "low";
  } else if (abs(leftSensor - rightSensor) <=100) {
    status = "close";
  } 
 
 return status;
}