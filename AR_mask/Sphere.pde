/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
public class Sphere extends Object3D {
  PVector center;
  float radius;
  ArrayList<PVector> points;
  int latN;
  int longN;
  
  public Sphere(PVector center, float radius){
    super();
    this.center = center;
    this.radius = radius;
    this.points = new ArrayList<PVector>();
    this.latN = 96;
    this.longN = 96;
    createSphere();
  }
  
  public ArrayList<PVector> getPoints(){
    return points;
  }
  
  private void createSphere2(){
    float step = radians(360/latN);
    float phi = 0;
    float theta = 0;
    float pointX = center.x;
    float pointY = center.y;
    float pointZ = center.z;
     
      while(theta < TWO_PI){
        theta += step;
        phi = 0;
        while (phi < PI){
        phi += step;
        pointX = center.x + radius * sin(phi) * cos(theta);
        pointY = center.y + radius * sin(phi) * sin(theta);
        pointZ = center.z + radius * cos(phi);
        points.add(new PVector(pointX, pointY, pointZ));
     }
   }
 }
 
 private void createSphere(){
    float step = radians(360/latN);
    float phi = 0;
    float theta = 0;
    float pointX = center.x;
    float pointY = center.y;
    float pointZ = center.z;
     
      for(int i =0; i < latN; i++){
        for(int j = 0; j < longN; j++){
        pointX = center.x + radius * sin(PI*(float)i/latN) * cos(TWO_PI*(float)j/longN);
        pointY = center.y + radius * sin(PI*(float)i/latN) * sin(TWO_PI*(float)j/longN);
        pointZ = center.z + radius * cos(PI*(float)i/latN);
        points.add(new PVector(pointX, pointY, pointZ));
     }
   }
 }
 
 public void render(WorldToCameraToPixel projection, PVector translation, PVector size){
    renderRect(projection, translation, size);
  }
  
 public void renderPoints(WorldToCameraToPixel projection, PVector translation, PVector size){
    int i = 0;
    int j = 0;
    float g = 255;
    for(PVector point : points){
        i++;
        j++;
        Point2D_F64 ps = projection.transform(new Point3D_F64(point.x,point.y, point.z));
        //strokeWeight(2);
        noStroke();
        if(i%20==0) {
          if(i < points.size()/2) g-=1;
          else g +=1; 
        }
        fill(color(0, g,200,70));
        if(ps != null) {
          ellipse(new Float(ps.x), new Float(ps.y), size.x*2,size.y*2);
        }
      }
  }
  
  public void renderRect(WorldToCameraToPixel projection, PVector translation, PVector size){
    float g = 255;
    fill(color(0, 255,200, 70));
    noStroke();
    for(int i = 0; i < points.size() - latN - 1; i++){//points3D.size() - 4
      if(i < points.size()/2) {
        g-=1;
      }
      else {
        g +=1; 
      }
      fill(color(g, 255,200, 70));
      stroke(color(g, 255,200, 80));
      PVector point = points.get(i);
      Point2D_F64 corner1 = projection.transform(new Point3D_F64(point.x,point.y, point.z));
      point = points.get(i+1);
      Point2D_F64 corner2 = projection.transform(new Point3D_F64(point.x,point.y, point.z));
      point = points.get(i+96 +1);
      Point2D_F64 corner3 = projection.transform(new Point3D_F64(point.x,point.y, point.z));
      point = points.get(i+96);
      Point2D_F64 corner4 = projection.transform(new Point3D_F64(point.x,point.y, point.z));
      if(corner1 != null && corner2 != null && corner3 != null && corner4 != null) {
        quad((float)corner1.x, (float)corner1.y, (float)corner2.x, (float)corner2.y, (float)corner3.x, (float)corner3.y, (float)corner4.x, (float)corner4.y);
      }
    }
  }
  
}
