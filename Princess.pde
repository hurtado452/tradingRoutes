class Princess extends Sprite{
  boolean isSaved = false;
  PImage images;
  int cX = 20;
  int cY = 10;
  void Princess(boolean z){
    this.isSaved = z;  
  }
  void loadImages(){
    images = loadImage("princess.png"); 
  }
  
  void checkState(){
    
  }
  
  boolean getIsSaved(){
    return this.isSaved;
  }

}
