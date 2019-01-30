/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/* simple 2D geometry utilitary functions*/
boolean isInEllipse(float x, float y, float radius1, float radius2, float centerx, float centery){
  //compute ellipse cartesian equation
  x -= centerx;
  y -= centery;
  float c = radius1;
  float a = sqrt(sq(radius2) + sq(c));
  float ellipseFormula = sqrt(sq(x-c) + sq(y)) + sqrt(sq(x+c) + sq(y));
  if( ellipseFormula < 2*a){
    return true;
  }
  return false;
}
