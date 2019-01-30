/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
import java.util.*;
import java.text.*;

/*
The SaveScreenshot Command saves a screenshot of the current frame.
*/

class SaveScreenshot implements Command{
  private String folder;
  private String prefix;
  
  public SaveScreenshot(String folder, String prefix){
    this.folder = folder;
    this.prefix = prefix;
  }
  
  public SaveScreenshot(){
    this("screenshots", "screenshot");
  }
  
  public void execute(){
    Date date = new Date();
    SimpleDateFormat ft = new SimpleDateFormat ("yyyyMMdd'_'HHmmss");
    save(folder + "/" + prefix + ft.format(date)+ ".png");
  }
}
