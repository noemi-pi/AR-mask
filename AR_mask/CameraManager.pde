/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
The CameraManager class manages camera capture and the display of resulting images
*/
public class CameraManager{
  private boolean cameraOn;
  private Capture cam;
  private int initWidth;
  private int initHeight;
  
  public CameraManager(boolean cameraOn, int initWidth, int initHeight){
    this.cameraOn = cameraOn;
    this.initWidth = initWidth;
    this.initHeight = initHeight;
  }
  
  public CameraManager(){
    this(false, 640, 480);
  }
  
  public void init(){
    initializeCamera(initWidth, initHeight);
    surface.setSize(cam.width, cam.height);
  }
  
  //from boofcv example
  private void initializeCamera(int desiredWidth, int desiredHeight ) {
    String[] cameras = Capture.list();
    
    if(cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      cam = new Capture(appThis, desiredWidth, desiredHeight);
      cam.start();
    }
  }
  
  public void run(){
    if (cameraOn && cam.available() == true) {
      cam.read();
      displayImage();
    }
    
    else if (!cameraOn) {
      background(255);
    }
  }
  
  public void displayImage(){
    pushMatrix();
    translate(cam.width, 0);
    scale(-1,1);
    image(cam, 0, 0);
    popMatrix();
  }
  public void switchOnOrOff(){
    cameraOn = !cameraOn;
    String camState = new String();
    if(cameraOn){
      camState = "on";
    }
    else camState = "off";
    println("camera switched " + camState);
  }
  
  public Capture getCam(){
    return cam;
  }
  
  public boolean cameraOn(){
    return cameraOn;
  }
}
