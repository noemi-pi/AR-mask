/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
AR Mask project
Provides an interface for getting a video feed from a webcam, detecting fiducials and selecting manually points to track + augmenting the image with 2D and 3D graphics filters.
It is designed to draw filters over and around a face mask worn by the user, on which the necessary markers and/or fiducials have been added.
For the moment, only a spherical 3D filter (for testing fiducial tracking and detection), and a 2D filter (for object tracking) are used. More to be added later.

Install boofcv for processing to run this program (tools > add > libraries > boofcv).
It works with BoofCV square binary fiducials:
https://boofcv.org/index.php?title=File:Fiducial_squre_binary.png

The AR mask project was originally made a a final project for the Computational Media course (Fall 2018) at National Cheng kung University, Tainan.
*/

import boofcv.processing.*;
import processing.video.*;

//To access the PApplet object from inside other classes
PApplet appThis;

//Application manager objects
GUIManager GUIMan = new GUIManager();
CameraManager camManager = new CameraManager(false, 640, 480);
TrackingManager trackMan = new TrackingManager();
FiducialManager fiducialMan = new FiducialManager();
FilterManager filterManager = new FilterManager();

//Animation variables
float timeVar = 0;

void setup(){
  appThis = this;
  camManager.init();
  GUIMan.initGUI();
  fiducialMan.init();
}

void draw(){
  timeVar+=0.1;
  camManager.run();
  fiducialMan.runDetection();
  GUIMan.displayGUI();
  trackMan.runTracking(camManager.getCam());
  trackMan.displayResults(camManager.getCam());
  if(camManager.cameraOn()){
    filterManager.displayFilters();
  } 
}

void mouseClicked(){
  GUIMan.onClick();
}

void mousePressed(){
  if(!GUIMan.mouseOnGUI()){
    trackMan.onMousePress();
  }
}

void mouseDragged(){
  trackMan.onDrag();
}

void mouseReleased(){
  trackMan.onMouseRelease();
}

boolean coordsOutOfScreen(float x, float y){
  if(x < 0 || x > width || y < 0 || y > height){
    return true;
  }
  return false;
}
