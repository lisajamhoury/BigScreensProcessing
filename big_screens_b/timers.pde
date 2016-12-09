//Documentation timers 
//24fps 

//0:00 -- 00  -- startPulse (7)
//0:08 -- 08 -- 8000 -- startEmgCurves (1)
//0:35 -- 35 -- 35000 -- startEmg lines(3) (8)
//1:10 -- 70 -- 70000 -- justLines (5)
//1:44 -- 104 --104000 --justWhiteLines(6)(t)
//2:19 -- 139 -- 139000 -- slow1(5)
//2:28 -- 148 -- 148000 -- slow2(3)
//2:36 -- 156 -- 156000 -- slow3(1)
//2:41 -- 161 -- 161000 -- removePulse(9)
//2:45 -- 165 -- 165000 -- emgDark(0)
//2:54 -- 174 -- 174000 -- removeEmg (o)

// TIMING IN MILLIS
int pulseStart = 1000; // give 15 second lead time 
int startEmgCurves = pulseStart + 8000;
int startEmgLines = pulseStart + 35000;
int justLines = pulseStart + 70000;
int justWhiteLines = pulseStart + 104000;
int slow1 = pulseStart + 139000;
int slow2 = pulseStart + 148000;
int slow3 = pulseStart + 156000;
int removePulse = pulseStart + 161000;
int emgDark = pulseStart + 165000;
int removeEmg = pulseStart + 174000;

boolean pulseStartToggle = false; 
boolean startEmgCurvesToggle = false;
boolean startEmgLinesToggle = false;
boolean justLinesToggle = false;
boolean justWhiteLinesToggle = false;
boolean slow1Toggle = false;
boolean slow2Toggle = false;
boolean slow3Toggle = false;
boolean removePulseToggle = false;
boolean emgDarkToggle = false;
boolean removeEmgToggle = pulseStartToggle = false;

void runTimer() {
  if (millis() > pulseStart) {
    if (pulseStartToggle == false) {
      println("one");
      processControls('7');
      pulseStartToggle = true;
    }
  }
  if (millis() > startEmgCurves) {
    if (startEmgCurvesToggle == false) {
      println("two");
      processControls('1');
      startEmgCurvesToggle = true;
    }
  }
  if (millis() >  startEmgLines) {
    if (startEmgLinesToggle == false) {
      println("three");
      processControls('3');
      processControls('8');
      startEmgLinesToggle = true;
    }
  }
  if (millis() >  justLines) {
    if ( justLinesToggle == false) {
      processControls('5');
      justLinesToggle = true;
    }
  }
  if (millis() >  justWhiteLines) {
    if (justWhiteLinesToggle == false) {
      processControls('6');
      processControls('t');
      justWhiteLinesToggle = true;
    }
  }
  if (millis() >  slow1) {
    if (slow1Toggle == false) {
      processControls('5');
      processControls('y');
      slow1Toggle = true;
    }
  }
  if (millis() >  slow2) {
    if (slow2Toggle == false) {
      processControls('3');
      slow2Toggle = true; 
    }
  }
  if (millis() ==  slow3) {
    if (slow3Toggle == false) {
      processControls('1');
      slow3Toggle = true;
    }
  }
  if (millis() >  removePulse) {
    if (removePulseToggle == false) {
      processControls('9');
      removePulseToggle = true;
    }
  }
  if (millis() >  emgDark) {
    if (emgDarkToggle == false) {
      processControls('0');
      emgDarkToggle = true;
    }
  }
  if (millis() >  removeEmg) {
    if (removeEmgToggle == false) {
      processControls('o');
      removeEmgToggle = true;
    }
  }

}