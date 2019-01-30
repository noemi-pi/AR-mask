/*
AR Mask by Noemie Pierre-Jean, January 2019
*/

/*
The GUIManager class manages GUI elements and events.
*/
public class GUIManager{
  ArrayList<GUIButton> buttons;
  
  public GUIManager(){
    buttons = new ArrayList<GUIButton>();
  }
  
  public void initGUI(){
    float offset = width/100;
    float buttonRadius = width/30;
    float marginW = width/110;
    float marginH = width/15;
    
    float iconSizeW, iconSizeH;
    iconSizeW = iconSizeH = 2*buttonRadius;
    
    GUIButtonIcon cameraIcon = new GUIButtonIcon(drawCameraIcon(iconSizeW, iconSizeH));
    GUIButtonIcon screenshotIcon = new GUIButtonIcon(drawScreenshotIcon(iconSizeW, iconSizeH));
    GUIButtonIcon trackingIcon = new GUIButtonIcon(drawTrackingIcon(iconSizeW, iconSizeH));
    GUIButtonIcon faceIcon = new GUIButtonIcon(drawFaceIcon(iconSizeW, iconSizeH));
    
    GUIButton filterButton = new GUIButton(width/2, height - marginH, buttonRadius, faceIcon, new ActivateFilter("filterTest"));
    GUIButton cameraButton = new GUIButton(width -(buttonRadius*2 + offset)*2 - marginW, marginH, buttonRadius, cameraIcon, new CameraSwitchOnOff());
    GUIButton trackingButton = new GUIButton((buttonRadius*2 + offset)*1 + marginW, marginH, buttonRadius, trackingIcon, new TrackingModeOnOff());
    GUIButton screenshotButton = new GUIButton(width -(buttonRadius*2 + marginW)*1, marginH, buttonRadius, screenshotIcon, new SaveScreenshot());
    
    buttons.add(filterButton);
    buttons.add(cameraButton);
    buttons.add(trackingButton);
    buttons.add(screenshotButton);
  }
  
  public void displayGUI(){
    for(GUIButton button : buttons){
      button.display();
    }
  }
  public void onClick(){
    for(GUIButton button : buttons){
      if(button.isSelected()){
        button.onClick();
      }
    }
  }
  
  public boolean mouseOnGUI(){
    for(GUIButton button : buttons){
      if(button.isSelected()){
        return true;
      }
    }
    return false;
  }
  
}
