/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
This command switches the camera on or off.
*/
public class CameraSwitchOnOff implements Command{
  public void execute(){
    camManager.switchOnOrOff();
  }
}
