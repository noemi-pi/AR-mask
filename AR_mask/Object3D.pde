/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
An abstract class to represent 3D objects. The objects that inherit from this class can be represented with 3D points and projected in camera images.
*/
public abstract class Object3D {
  public void render(WorldToCameraToPixel projection, PVector translation, PVector size){
  }
}
