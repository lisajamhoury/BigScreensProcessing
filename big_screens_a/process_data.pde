//variables for manipulating data
float pulseSensor = 0;
float emg1LeftSensor = 0;
float emg1RightSensor = 0;
float emg2LeftSensor = 0;
float emg2RightSensor = 0;

//Constants for mapping data 
float EMGLOWER = 20;
float EMGUPPER = 1000;


//pulse vairables
boolean pulse = false;


void getSensorData() { 
 emg1LeftSensor = emg1L;
 emg1RightSensor = emg1R;
 emg2LeftSensor = emg1L;
 emg2RightSensor = emg1R;
 pulseSensor = polar0;
 
 readPulse();
}

void readPulse() {
 if (pulseSensor == 1) {
   pulse = true;
 } else {
   pulse = false;
 }
}