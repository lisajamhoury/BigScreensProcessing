class FlowField {
  int resolution;
  int cols;
  int rows;
  int horMid;
  PVector[][] field;
  
  FlowField(int r) {
    resolution = r;
    cols = width / resolution;
    rows = height / resolution;
    horMid = cols/2;
    field = new PVector[cols][rows];
  }

  void update(PVector iLoc) {
    add(iLoc);
    init();
  }

  void add(PVector iLoc) {
    magnet.add(new Magnet(new PVector(iLoc.x-250, iLoc.y), new PVector(iLoc.x + 250, iLoc.y)));
  }

  void init() {
    for (int col = 0; col < this.cols; col++) {
      for (int row = 0; row < this.rows; row++) {
        PVector avgDist1 = new PVector();
        PVector avgDist2 = new PVector();
        
        float theta = map(noise(col/10.0f, row/10.0f), 0, 1, 0, TWO_PI);
        PVector noisy = new PVector(cos(theta), sin(theta));
        
        for (int i = 0; i < magnet.size(); i++) {
          PVector pos = magnet.get(i).posPos;
          PVector neg = magnet.get(i).posNeg;
          
          PVector xy = new PVector(col * this.resolution + this.resolution / 2, row * this.resolution + this.resolution / 2);
          PVector dist1 = PVector.sub(xy, pos);
          PVector dist2 = PVector.sub(neg, xy);

          float div1 = dist1.mag();
          float div2 = dist2.mag();
          
          dist1.normalize();
          dist2.normalize();

          dist1.div(div1 * 0.01); //how strong flowfield is (how long the line is)
          dist2.div(div2 * 0.01); //how strong flowfield is (how long the line is)

          avgDist1.add(dist1);
          avgDist2.add(dist2);

        }

        avgDist1.div(magnet.size());
        avgDist2.div(magnet.size());

        //field[col][row] = avgDist1.copy();//PVector.add(avgDist1, avgDist2);
        if (col > horMid) {
          field[col][row] = PVector.add(avgDist1, avgDist2).add(noisy);
        } else {
          field[col][row] = PVector.add(avgDist1, avgDist2).sub(noisy);
        }
          

      }
    }
    getOutPoints();

  }

  void display() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        drawVector(field[x][y], x * resolution, y * resolution);
      }
    }
  }

  PVector lookup(PVector lookup) {
    int column = floor(constrain(lookup.x / resolution, 0, cols - 1));
    int row = floor(constrain(lookup.y / resolution, 0, rows - 1));
    return field[column][row].copy();
  }
  
  void getOutPoints() {
   println("get points");
   int[] rowsToCheck = new int[2];
   rowsToCheck[0] = rows-2;
   rowsToCheck[1] = rows-1;
   
   for (int x = 0; x < cols; x++) {
      for (int z = 0; z < rowsToCheck.length; z++) {
        int y = rowsToCheck[z];
        float heading = getHeading(field[x][y]);
        if (( x < cols/2) && (heading > 0.2 &&heading < 1.4)) {
          PVector outPointL = new PVector(x*resolution, y*resolution);
          fieldOutPointsLeft.add(outPointL);
          //USE TO DEBUG OUT POINTS
          //fill(255,0,0);
          //ellipse(outPointL.x, outPointL.y, 10, 10);
        }
        if (( x > cols/2) && (heading > 1.7 && heading < 2.8)) {
          PVector outPointR = new PVector(x*resolution, y*resolution);
          fieldOutPointsRight.add(outPointR);
          //USE TO DEBUG OUT POINTS
          //fill(255,0,0);
          //ellipse(outPointR.x, outPointR.y, 10, 10);
        }
      }     
     }
  }
  
  float getHeading(PVector v) {
   return v.heading(); 
  }
  
  

  void drawVector(PVector v, float x, float y) {
    pushMatrix();
    float arrowsize = 4;
    // Translate to location to render vector
    translate(x, y);
    stroke(100);
    // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
    rotate(v.heading());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*resolution;
    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
    line(0, 0, len, 0);
    line(len, 0, len-arrowsize, +arrowsize/2);
    line(len, 0, len-arrowsize, -arrowsize/2);
    popMatrix();
  }
}