/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
The GUIButtonIcon class creates, displays and animates icons for GUI buttons.
*/
public class GUIButtonIcon{
  float x;
  float y;
  float sizeh;
  float sizew;
  boolean animate;
  PImage image;
  
  GUIButtonIcon(PImage image){
    this.x = 0;
    this.y = 0;
    this.sizeh = 1;
    this.sizew = 1;
    this.animate = false;
    this.image = image;
  }
  
  public void setPosition(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void setSize(float sizew, float sizeh){
    this.sizew = sizew;
    this.sizeh = sizeh;
  }
  
  public void display(){
    if(animate){
      displayAnimated();
    }
    else{
      displayStatic();
    }
      
  }
  
  private void displayStatic(){
    imageMode(CENTER);
    image(image, x, y, sizew, sizeh);
    imageMode(CORNER);
  }
  private void displayAnimated(){
    pushMatrix();
    translate(x,y);
    rotate(cos(timeVar));
    translate(-x, -y);
    displayStatic();
    popMatrix();
  }
  
  public void animate(boolean animate){
    this.animate = animate;
  }
}
