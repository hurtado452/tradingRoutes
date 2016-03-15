class Character extends Sprite{
  int MAX = 8;
  String dirState = "idling";
  String idlingState = "right";
  PImage[] images = new PImage[MAX];
  

  
  void loadImages(){
    for(int i=0;i<MAX;i++){
      images[i] = loadImage("farmer_"+i+".png"); 
    }
  }
  
  void checkBorders(){
    if(cX < minX){
       player.cX = minX;
    }
    if(cY < minY){
      player.cY = minY;
    }
    if(cX > maxX){
       player.cX = maxX;
    }
    if(cY > maxY){
      player.cY = maxY;  
    }
  }
  
  void checkState(){
    if (dirState == "right") {
      cX = cX+40;
      checkBorders();
      idlingState = "right";
    } 
    else if (dirState == "left") {
      cX = cX-40;
      checkBorders();
      idlingState = "left";
    }
    else if (dirState == "up"){
      cY = cY-40;
      checkBorders(); 
      idlingState = "up";
    }
    else if(dirState == "down"){
      cY = cY+40;
      checkBorders();
      idlingState = "down";
    }
    else if(dirState == "idling"){
      //do nothing
    }
    else if(attackState == "attacking"){
      
    }
  }
  
  boolean isDead(int life){
    if (life < 1){
      return true;  
    }
    return false;
  }
}
