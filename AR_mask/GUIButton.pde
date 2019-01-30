/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
The GUIButton class manages the creation and display of GUI clickable buttons, and executes a command on click
*/
public class GUIButton{
  private float radius;
  private float x;
  private float y;
  private color defaultColor;
  private GUIButtonIcon icon;
  private Command command;
  private color activeColor;
  private boolean isActive;
  
  public GUIButton(float x, float y, float radius, GUIButtonIcon icon, Command command){
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.icon = icon;
    this.defaultColor = color(0);
    this.command = command;
    this.activeColor = color(255,0,0);
    this.isActive = false;
  }
  
  public void display(){
    color hoverColor = color(255, 150, 0);
    if(mouseOnButton()){
      stroke(hoverColor);
    }
    else if(isActive){
      stroke(activeColor);
    }
    else {
      stroke(defaultColor);
    }
    strokeWeight(1);
    noFill();
    ellipse(x, y, radius*2, radius*2);
    icon.setPosition(x,y);
    icon.setSize(radius*2*0.8, radius*2*0.8);
    icon.animate(mouseOnButton());
    icon.display();
  }
  
  public boolean isSelected(){
    return mouseOnButton();
  }
  
  private boolean mouseOnButton(){
    if(mouseX >= x - radius && mouseX <= x + radius
       && mouseY >= y-radius && mouseY <= y +radius){
      return true;
    }
    return false;
  }
  
  public void setActive(boolean isActive){
    this.isActive = isActive;
  }
  
  public void onClick(){
    setActive(!this.isActive);
    command.execute();
  }
  
}
