/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
The Filter class represents Filters that overlay 2D or 3D graphics on camera footage
*/
public abstract class Filter implements Displayable {
  private String name;
  public Filter(String name){
    this.name = name;
  }
  
  public String getName(){
    return name;
  }
}
