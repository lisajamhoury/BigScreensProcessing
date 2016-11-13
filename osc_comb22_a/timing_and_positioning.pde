// TIMING
int pulseStart = 0000; // 30 seconds 
int emgStart = pulseStart + 000; // 30 seconds 
int firstDrop = pulseStart + 45000; // 45 seconds
int voice = pulseStart + 90000;
int vBreath = pulseStart + 116000;
int secondDrop = pulseStart + 160000; 
int fadeOut = pulseStart + 190000;
int justPulse = pulseStart + 203000;
int end = pulseStart + 225000;

float frZero = 0;
boolean pulseStarted = false;
boolean growing = true;
boolean runPulse = true;
boolean emgGrow = false;
boolean emgClimax = false;


//POSTITIONING
PVector pulseCtr;
PVector leftEmgCtr;
PVector rightEmgCtr;
float oneThird;
float twoThird;