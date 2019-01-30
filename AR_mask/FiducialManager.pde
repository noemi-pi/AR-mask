/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
import boofcv.struct.calib.CameraPinholeRadial;
import boofcv.alg.geo.PerspectiveOps;

/**
The FiducialManager class manages the detection of fiducial markers as well as the retrieval of information from found fiducials (such as the projection matrix).
Based on functions from BoofProcessing:
*/

public class FiducialManager{
  SimpleFiducial detector;
  CameraPinholeRadial intrinsic;
  List<FiducialFound> found;
  WorldToCameraToPixel worldToPixel;
  
  public FiducialManager(){
    this.detector = Boof.fiducialSquareBinaryRobust(0.1);
    //detector = Boof.fiducialSquareBinary(0.1,100);
    this.intrinsic = new CameraPinholeRadial();
    this.worldToPixel = new WorldToCameraToPixel();
    this.found = new ArrayList<FiducialFound>();
  }
  
  public void init(){
    Capture cam = camManager.getCam();
    // Much better results if you calibrate the camera.
    // It is guessing the parameters and assuming there is no lens distortion, which is never true!
    // detector.setIntrinsic(intrinsic);
    detector.guessCrappyIntrinsic(cam.width,cam.height);
    intrinsic = guessCrappyIntrinsic(cam.width,cam.height);
  }
  
  //adapted from the SimpleFiducial guessCrappyIntrinsic method from the BoofProcessing github repo 
  //at https://github.com/lessthanoptimal/BoofProcessing/blob/master/src/boofcv/processing/SimpleFiducial.java
  public CameraPinholeRadial guessCrappyIntrinsic( int width , int height ) {
      CameraPinholeRadial param = new CameraPinholeRadial();
  
      param.width = width; param.height = height;
      param.cx = width/2;
      param.cy = height/2;
      param.fx = param.cx/Math.tan(Math.toRadians(30)); //(UtilAngle.degreeToRadian(30)); // assume 60 degree FOV
      param.fy = param.cx/Math.tan(Math.toRadians(30)); //(UtilAngle.degreeToRadian(30));
  
      return param;
  }
  
  public void runDetection(){
    Capture cam = camManager.getCam();
    found = detector.detect(cam);
    for (FiducialFound f : found){
      worldToPixel = PerspectiveOps.createWorldToPixel(intrinsic, f.getFiducialToCamera());
    }
  }
  
  public WorldToCameraToPixel getProjectionMatrix(){
    return worldToPixel;
  }
  
  public List<FiducialFound> getFoundFiducials(){
    return found;
  }
}
