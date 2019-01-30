/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
public class FilterManager{
  private HashMap<String, Boolean> filterStates;
  private List<Filter> filters;
  private List<Filter> activeFilters;
  
  FilterManager(){
    Sphere sphereTest = new Sphere(new PVector(0,0,0), 0.1 * 6);
    Filter filterTest = new Filter3D(sphereTest, "filterTest");
    this.filterStates = new HashMap<String, Boolean>();
    this.filters = new ArrayList<Filter>();
    this.activeFilters = new ArrayList<Filter>();
    filterStates.put("filterTest", false);
    filters.add(filterTest);
  }
  
  public void changeActiveFilter(String filterName, boolean isActive){
    if(filterStates.containsKey(filterName)){
      filterStates.put(filterName, isActive);
    }
    updateActiveFilters();
  }
  
  public void updateActiveFilters(){
    activeFilters = new ArrayList<Filter>();
    for(Filter filter : filters){
      if(filterStates.get(filter.getName()) == true){
        activeFilters.add(filter);
      }
    }
  }
  
  public void displayFilters(){
    if(!fiducialMan.getFoundFiducials().isEmpty()){
      for(Filter filter : activeFilters){
        filter.display();
      }
    }
  }
}
