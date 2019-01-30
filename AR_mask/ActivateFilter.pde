/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
This command activates or deactivates a Filter. It transmits the selected filter's active status to the FilterManager.
*/

class ActivateFilter implements Command{
  String filterName;
  boolean isActive;
  
  ActivateFilter(String filterName, boolean isActive){
    this.filterName = filterName;
    this.isActive = isActive;
  }
  
  ActivateFilter(String FilterName){
    this(FilterName, false);
  }
  
  public void execute(){
    isActive = !isActive;
    filterManager.changeActiveFilter(filterName, isActive);
  }
}
