/*
AR Mask by Noemie Pierre-Jean, January 2019
*/

/*
Command to enable or disable the object tracking mode
*/

public class TrackingModeOnOff implements Command {
  public void execute(){
    trackMan.switchOnOrOff();
  }
}
