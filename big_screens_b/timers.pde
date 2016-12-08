//Documentation timers 
//24fps 

//0:00 -- 00 -- 00  -- startPulse (7)
//0:08 -- 08 -- 192 -- startEmgCurves (1)
//0:35 -- 35 -- 840 -- startEmg lines(3) (8)
//1:10 -- 70 -- 1704 -- justLines (5)
//1:44 -- 104 --2496 --justWhiteLines(6)(t)
//2:19 -- 139 -- 3336 -- slow1(5)
//2:28 -- 148 -- 3552 -- slow2(3)
//2:36 -- 156 -- 3744 -- slow3(1)
//2:41 -- 161 -- 3864 -- removePulse(9)
//2:45 -- 165 -- 3960 -- emgDark(0)
//2:54 -- 174 -- 4176 -- removeEmg (o)

// TIMING IN FRAMES AT 24 FPS
int pulseStart = 240; // give 10 second lead time 
int startEmgCurves = pulseStart + 192;
int startEmgLines = pulseStart + 840;
int justLines = pulseStart + 1704;
int justWhiteLines = pulseStart + 2496;
int slow1 = pulseStart + 3336;
int slow2 = pulseStart + 3552;
int slow3 = pulseStart + 3744;
int removePulse = pulseStart + 3864;
int emgDark = pulseStart + 3960;
int removeEmg = pulseStart + 4176;

//0:00 -- 00 -- 00  -- startPulse (7)
//0:08 -- 08 -- 240 -- startEmgCurves (1)
//0:35 -- 35 -- 1050 -- startEmg lines(3) (8)
//1:10 -- 70 -- 2100 -- justLines (5)
//1:44 -- 104 --3120 --justWhiteLines(6)(t)
//2:19 -- 139 -- 4170 -- slow1(5)
//2:28 -- 148 -- 4440 -- slow2(3)
//2:36 -- 156 -- 4680 -- slow3(1)
//2:41 -- 161 -- 4830 -- removePulse(9)
//2:45 -- 165 -- 4950 -- emgDark(0)
//2:54 -- 174 -- 5220 -- removeEmg (o)



//TIMING AT 30 FPS
//int pulseStart = 60; // give 10 second lead time 
//int startEmgCurves = pulseStart + 240;
//int startEmgLines = pulseStart + 1050;
//int justLines = pulseStart + 2100;
//int justWhiteLines = pulseStart + 3120;
//int slow1 = pulseStart + 4170;
//int slow2 = pulseStart + 4440;
//int slow3 = pulseStart + 4680;
//int removePulse = pulseStart + 4830;
//int emgDark = pulseStart + 4950;
//int removeEmg = pulseStart + 5220;

void runTimer() {
  if (frameCount == pulseStart) {
    println("one");
    processControls('7');
    
  }
  if (frameCount == startEmgCurves) {
    println("two");
    processControls('1');
    
  }
  if (frameCount ==  startEmgLines) {
    println("three");
    processControls('3');
    processControls('8');
    
  }
  if (frameCount ==  justLines) {
    processControls('5');
  }
  if (frameCount ==  justWhiteLines) {
    processControls('6');
    processControls('t');
  }
  if (frameCount ==  slow1) {
    processControls('5');
  }
  if (frameCount ==  slow2) {
    processControls('3');
  }
  if (frameCount ==  slow3) {
    processControls('1');
  }
  if (frameCount ==  removePulse) {
    processControls('9');
  }
  if (frameCount ==  emgDark) {
    processControls('0');
  }
  if (frameCount ==  removeEmg) {
    processControls('o');
  }

}

//int startPulse (7)
//int startEmgCurves (1)
//int startEmg lines(3) (8)
//int justLines (5)
//int justWhiteLines(6)(t)
//int slow1(5)
//int slow2(3)
//int slow3(1)
//int removePulse(9)
//int emgDark(0)
//int removeEmg (o)