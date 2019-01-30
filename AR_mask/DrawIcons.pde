/*
AR Mask by Noemie Pierre-Jean, January 2019
*/
/*
Functions to draw GUI Icons.
*/
PGraphics drawCameraIcon(float sizew, float sizeh){
  PGraphics graphics = createGraphics((int)sizew, (int)sizeh);
  float x = graphics.width/2;
  float y = graphics.height/2;
  //float radius = max(sizew, sizeh)/2;
  float cornerX = x - sizew /4;
  float cornerY = y - sizeh /4;
  float w = sizew /1.5;
  float h = sizeh /2;
  graphics.beginDraw();
  graphics.noFill();
  //graphics.ellipse(x,y, radius*2, radius*2);
  graphics.rect(cornerX,cornerY, w, h);
  graphics.triangle(cornerX - w/3, y - h/3, cornerX - w/3, y +  h/3, cornerX, y);
  graphics.endDraw();
  
  return graphics;
}

PGraphics drawScreenshotIcon(float sizew, float sizeh){
  PGraphics graphics = createGraphics((int)sizew, (int)sizeh);
  float x = graphics.width/2;
  float y = graphics.height/2;
  float radius = max(sizew, sizeh);
  graphics.beginDraw();
  graphics.noFill();
  graphics.rect(x - radius /3,y - radius/4, radius/1.5, radius/2);
  graphics.ellipse(x,y, radius/3, radius/3);
  graphics.endDraw();
  
  return graphics;
}

PGraphics drawTrackingIcon(float sizew, float sizeh){
  PGraphics graphics = createGraphics((int)sizew, (int)sizeh);
  float x = graphics.width/2;
  float y = graphics.height/2;
  float radius = max(sizew, sizeh)*0.8; 
  float lSize = radius/2;
  graphics.beginDraw();
  graphics.noFill();
  graphics.ellipse(x,y, radius, radius);
  graphics.line(x,y -radius/2 - lSize/2, x, y -radius/2 + lSize/2);
  graphics.line(x,y +radius/2 - lSize/2, x, y +radius/2 + lSize/2);
  graphics.line(x - radius/2 - lSize/2, y, x - radius/2 + lSize/2, y);
  graphics.line(x + radius/2 - lSize/2, y, x + radius/2 + lSize/2, y);
  graphics.endDraw();
  
  return graphics;
}

PGraphics drawFaceIcon(float sizew, float sizeh){
  PGraphics graphics = createGraphics((int)sizew, (int)sizeh);
  float x = graphics.width/2;
  float y = graphics.height/2;
  float radius = max(sizew, sizeh)*0.8; 
  PVector eyePos = new PVector(radius/8, radius/8);
  PVector mouthPos = new PVector(0, radius/8);
  float eyeRadius = radius/12;
  PVector mouthDim = new PVector(radius/4, radius/8);
  graphics.beginDraw();
  graphics.ellipse(x,y, radius, radius);   
  graphics.ellipse(x - eyePos.x, y - eyePos.y, eyeRadius, eyeRadius);
  graphics.ellipse(x + eyePos.x, y - eyePos.y, eyeRadius, eyeRadius);
  graphics.ellipse(x, y + mouthPos.y, mouthDim.x, mouthDim.y);
  graphics.endDraw();
  
  return graphics;
}
