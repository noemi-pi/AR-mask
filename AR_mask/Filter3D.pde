/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
import boofcv.alg.geo.WorldToCameraToPixel;

/*
The Filter3D class creates and renders Filters that overlay 3D graphics on camera footage
*/
public class Filter3D extends Filter implements Displayable {
  //private String name;
  private Object3D object3D;
  
  public void display(){
    render(fiducialMan.getProjectionMatrix(), new PVector(0,0,0), new PVector(1, 1, 1));
  }
  
  public Filter3D(Object3D object3D, String name){
    super(name);
    this.object3D = object3D;
  }
  
  public void render(WorldToCameraToPixel projection, PVector translation, PVector size){
    Capture cam = camManager.getCam();
    pushMatrix();
    translate(cam.width, 0);
    scale(-1,1);
    object3D.render(projection, translation, size);
    popMatrix();
  } 
}
