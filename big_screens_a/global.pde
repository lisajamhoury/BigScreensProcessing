//POSTITIONING
PVector PULSECTR;
PVector LEFTEMGCTR;
PVector RIGHTEMGCTR;
float ONETHIRD;
float TWOTHIRD;
float AREA;

void setupGlobals() {  
  //Set positioning constants
  PULSECTR = new PVector(0.44*width, 0.44*height);
  LEFTEMGCTR = new PVector(0.16*width, 0.44*height);
  RIGHTEMGCTR = new PVector(0.72*width, 0.44*height);
  ONETHIRD = 0.31*width;
  TWOTHIRD = 0.57*width;
  AREA = width * height;
}