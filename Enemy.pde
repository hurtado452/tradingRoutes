
class Enemy extends Sprite{
  int MAX = 4;
  /*If player attacks without axe then -1 HP point from troll
    If player attacks with axe then -2 HP points from troll
    */
  float maxX=470;
  int health = 6;
  float buffX = 35;
  float buffY = 20;
  int[] randX = {400,50,50,230,400};
  int[] randY = {90,100,150,50,210};  
  float cX;
  float cY;
  String dirState = "idling";
  String idlingState = "right";
  String attackState = "none";
  PImage[] images = new PImage[MAX];
  String gift = "none";
  boolean isDead = false;
  void Enemy(int num,boolean d){
    this.health = this.health-num;  
    this.isDead = d;
  }
  boolean getIsDead(){
    return this.isDead;  
  }
  void loadImages(){
    for(int i=0;i<MAX;i++){
      images[i] = loadImage("troll_"+i+".png");    
    }  
  }
  void checkState(){
    if(dirState == "right"){
      cX = cX+50;
      idlingState = "right";  
    }
    else if (dirState == "left") {
      cX = cX-50;
      idlingState = "left";
    }
    else if (dirState == "up"){
      cY = cY-50;
      idlingState = "right";
    }
    else if(dirState == "down"){
      cY = cY+50;
      idlingState = "right";
    }
    else if(attackState == "attacking"){
      
    }
  }
  boolean checkBorders(int timeline){
    //compensate if trolls are at dungeon
    
    if(cX < minX){
       cX = minX;
       dirState = "right";
       return true;
    }
    if(cX > maxX){
       cX = maxX;
       dirState = "left";
       return true;
    }
    if(cY < minY){
      cY = minY;
      dirState = "down";
      return true; 
    }
    if(cY > maxY){
      cY = maxY; 
      dirState = "up"; 
      return true;
    }
    return false;
  }
  int getHealth(){
    return this.health;  
  }
}
