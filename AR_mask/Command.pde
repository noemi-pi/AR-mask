/*
AR Mask by Noemie Pierre-Jean, January 2019
*/

/*
The Command interface represents an action to be executed, it can be passed to another object of function such as a GUI interactive element.
It is based on the command design pattern https://en.wikipedia.org/wiki/Command_pattern
*/
public interface Command{
  public void execute();
}
