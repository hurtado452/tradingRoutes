abstract class Sprite{
  // Boundaries
  float minX=0;
  float minY=0;
  float maxX=480;
  float maxY=250;
  // Initial coordinates
  float initialX= 265;
  float initialY= 250;

  // Position
  float cX = initialX;
  float cY = initialY; 
  String attackState = "none";
  String dirState;
  
  abstract void loadImages(); 
  abstract void checkState(); 
  
}
