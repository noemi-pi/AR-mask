/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
import boofcv.struct.image.*;
import georegression.struct.shapes.*;
import georegression.struct.point.*;

/**
The TrackingManager class manages object tracking functionalities and lets the user manually select a target object to track
Works well when there is a strong contrast between the object and background (such as a colored sticker on a dark background)
Based on examples from BoofProcessing:
https://github.com/lessthanoptimal/BoofProcessing/blob/master/examples/TrackingObject/TrackingObject.pde
*/

public class TrackingManager{
  SimpleTrackerObject tracker;
  boolean trackingModeActivated;
  Quadrilateral_F64 target; // storage for where the use selects the target and the current target location 
  boolean targetVisible;// if true the target has been detected by the tracker
  PFont f;
  int mode; // indicates if the user is selecting a target or if the tracker is tracking it
  
  TrackingManager(){
    this.tracker = Boof.trackerTld(null, ImageDataType.F32);
    this.target = new Quadrilateral_F64();
    this.targetVisible = false;
    this.mode = 0;
    this.trackingModeActivated = false;
  }
  
  public void switchOnOrOff(){
    trackingModeActivated = !trackingModeActivated;
  }
  
  public void runTracking(Capture cam){
    if (trackingModeActivated){
      switch(mode){
        case 1: 
        targetVisible = true;
        break;
        case 2:
        if (!tracker.initialize(cam, target.a.x, target.a.y, target.c.x, target.c.y)){
          mode = 100;
        } else {
          targetVisible = true;
          mode = 3;
        }
        break;
        case 3:
        // Update the track state using the next image in the sequence
        if ( !tracker.process(cam) ) {
        // it failed to detect the target.  Depending on the tracker this could mean
        // the track is lost for ever or it could be recovered in the future when it becomes visible again
          targetVisible = false;
        } else {
          // tracking worked, save the results
          targetVisible = true;
          target.set(tracker.getLocation());
        }
        break;
        default:;
      } 
    }
    else {
      mode = 0;
    }
  }
  
  void linePoint2D( Point2D_F64 a, Point2D_F64 b ) {
    line((float)a.x, (float)a.y, (float)b.x, (float)b.y);
  }
  
  void drawTarget(Quadrilateral_F64 target) {
    noFill();
    strokeWeight(3);
    stroke(255, 0, 0);
    linePoint2D(target.a, target.b);
    stroke(0, 255, 0);
    linePoint2D(target.b, target.c);
    stroke(0, 0, 255);
    linePoint2D(target.c, target.d);
    stroke(255, 0, 255);
    linePoint2D(target.d, target.a);
  }
  
  public void displayResults(Capture cam){
    //Mirror the camera image
    pushMatrix();
    translate(cam.width, 0);
    scale(-1,1);
    
    textAlign(CENTER);
    //fill(0, 0xFF, 0);
    String userMessage = new String();
    if (trackingModeActivated){
      switch(mode){
        case 0:
        userMessage = "Click and Drag";
        break;
        
        case 1: 
        if(targetVisible) {
          drawTarget(target);
          drawMask(target);
        }
         else {
          userMessage ="Can't Detect Target";
        };
        break;
        
        case 100:
        userMessage = "Initialization Failed.\nSelect again.";
        break;
        
        default:
        if(targetVisible) {
          //drawFlame(target);
          drawMask(target);
        }
        else {
          userMessage ="Can't Detect Target";
        }
      }
    }
    
    popMatrix();
    if (!userMessage.isEmpty()) {
      fill(255);
      text(userMessage, width/2, height/4);
    }
  }
  
  public void onMousePress(){
    if(trackingModeActivated){
      mode = 1;
      target.a.set(width - mouseX, mouseY);
      target.b.set(width - mouseX, mouseY);
      target.c.set(width - mouseX, mouseY);
      target.d.set(width - mouseX, mouseY);
    }
  }
  
  public void onDrag(){
    float x = mouseX;
    float y = mouseY;
    if(trackingModeActivated){
      
      if(coordsOutOfScreen(x, y)){ //prevent target frame to expand past the screen's boundaries
        if(x > width){
          x = width;
        } else if (x <0){
          x = 0;
        }
        if(y > height){
          y = height;
        } else if (y <0){
          y = 0;
        }
      }
      
      target.b.x = width - x;
      target.c.set(width - x, y);
      target.d.y = y;
    }
  }
  
  void onMouseRelease() {
    if(trackingModeActivated){
      // After the mouse is released, initialize tracking
      mode = 2;
    }
  }

}

void drawMask(Quadrilateral_F64 target){
  drawPerlinCurvesMask(target);
}

void drawPerlinCurvesMask(Quadrilateral_F64 target){
  float targetWidth = abs((float)(target.a.getX() - target.b.getX()));
  float targetHeight = abs((float)(target.a.getY() - target.c.getY()));
  
  noiseDetail(5,0.75);
  float xpos = (float)(target.a.getX() + targetWidth/2);
  float ypos = (float)(target.a.getY() + targetHeight/2);
  float radiusw = 5*targetWidth/2;
  float radiush = 5*targetHeight/2;
  int nbPoints = 100;
  float noiseScale = 0.002;
  
  //animated lines
  strokeWeight(0.8);
  stroke(0,60,60);
  noFill();
  for(int j = 0; j < nbPoints; j++){
    float x = map(random(1), 0, 1, xpos - radiusw, xpos + radiusw);
    float y = map(random(1), 0, 1, ypos - radiush, ypos + radiush);
    int steps = 50;
    for(int i = 0; i < steps; i++){
      if(!isInEllipse(x, y, radiusw, radiush, xpos, ypos)){
        break;
      }
      float direction = noise(x*noiseScale,y*noiseScale) * PI * 2;
      float x1 = x;
      float y1 = y;
      x = x + 1 * cos(direction);
      y = y + 1 * sin(direction);
      line(x1, y1,  x, y);
    }
  }
}
