class MarketStand {
  boolean axeStock = true;
  boolean potionStock = true;
  int coinStock = 8;
  boolean getAxeStock(){
    return this.axeStock;  
  }
  boolean getPotionStock(){
    return this.potionStock;  
  }
  int getCoinStock(){
    return this.coinStock;   
  }
}

class Weapon extends MarketStand{
  PImage images;
  int cX = 40;
  int cY = 40;
  void loadImages(){
    images = loadImage("axe.png"); 
  } 
  boolean chosen(float x, float y){ 
    if(x >= axe.cX && x <= axe.cX+98 && y >= axe.cY && y <= axe.cY+51 ){
        //now check if player has enough money to buy
        return true;
      }
      return false;
  }
}

class Money extends MarketStand{
  PImage images;
  //marketStand coins
  float cX = 40;
  float cY = 280;
  //forest coins
  float[] randX = {200f,50f,450f}; 
  float[] randY = {100f,250f,250f};
  boolean isPicked = false;
  void Money(){

  }
  
  boolean Money(float x, float y){
    loadImages();
    if(collected(x,y)){
      return true;
    }
    return false;
  }
  
  void loadImages(){
    images = loadImage("coin.png");
  }
 
  boolean chosen(float x, float y){
    if(x >= coins.cX && x <= coins.cX+94 && y >= coins.cY && y <= coins.cY+11 ){
      return true;
    }
    return false;
  }  
  boolean collected(float x,float y){
   //check collision with player and coin
   float diffX = 0f;
   float diffY = 0f;
   for(int i=0;i<3;i++){
     diffX = x - randX[i];
     diffY = y - randY[i];
     if(diffX >= -65 && diffX <= -5){
       if(diffY >= -124 && diffY <= -12){
         randX[i] = -30f;
         randY[i] = -30f;
         return true;
       }
     }
   }
   return false; 
  }
  
}

class Health extends Items{
  PImage images;
  void loadImages(){
    images = loadImage("heart.png"); 
  } 
  
}
class Magic extends MarketStand{
  PImage images;
  int cX = 400;
  int cY = 140;
  void loadImages(){
    images = loadImage("potion.png");
  }
  boolean chosen(float x, float y){ 
     //potion: x 399 - 450 y:132-226
    if(x >= potion.cX && x <= potion.cX+50 && y >= potion.cY-8 && y <= potion.cY+86 ){
        return true;
     }
     return false;
  }
}

class Key extends Items{
  PImage[] images = new PImage[2];
  void loadImages(){
    images[0] = loadImage("key_0.png"); 
    images[1] = loadImage("key_1.png");
  } 
  
}
