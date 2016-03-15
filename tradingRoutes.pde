import java.util.*;

int timeline = 0;
PFont f;
boolean isSaved = false; //is princess saved
int MAXBG = 6; 
int deadTrolls = 0; //troll counter
int MAXTROLLS = 3;
boolean startKey = true;
String story_text,inventory;
Story line_to_disp = new Story();
//gifts
String[] forestGifts = {"coins","key"};
String[] dungeonGifts = {"coins","heart"};
boolean giftHeld = false;
//characters
Character player = new Character();
Enemy troll_1 = new Enemy();
Enemy troll_2 = new Enemy();
Enemy troll_3 = new Enemy();
Enemy troll_4 = new Enemy();
Enemy troll_5 = new Enemy();
Princess princess = new Princess();
//Environment
Dungeon jail = new Dungeon();
Items treats = new Items();
Weapon axe = new Weapon();
Magic potion = new Magic();
Money coins = new Money();
Health hearts = new Health();
MarketStand stock = new MarketStand();
PImage win,gameDone,start;
PImage[] bg = new PImage[MAXBG];
//bg = house,path,dungeon(no_key),dungeon,forest,market
boolean[] bg_show = {true,false,false,false,false,false};


void setup(){
  size(700,450);
  f = createFont("Arial",16,true);
  win = loadImage("won.png");
  start = loadImage("startscreen.png");
  gameDone = loadImage("gameover.png");
  bg[0] = loadImage("house_bg.png");
  bg[1] = loadImage("routes.png");
  bg[2] = loadImage("dungeon_0.png");
  bg[3] = loadImage("dungeon_1.png");
  bg[4] = loadImage("forest.png");
  bg[5] = loadImage("market.png");
}

void draw(){
  if(startKey == true){
    background(start); 
    if(mousePressed == true) startKey = false; 
  }else{
    checkKeys();
    story();
    inventory();
    resetGames();
    if(isSaved == true) won();
  }
  
}

void inventory(){
  fill(0);
  rect(600,0,100,height);  

  if(treats.getHeart() < 0) inventory = "Inventory\n\nHearts: "+0+"\n\nAxe: "+treats.getAxe()+"\n\nCoins: "+treats.getCoins()+"\n\nKeys: "+treats.getKeys()+"\n\nMagic: \n"+treats.getMagic();
  else inventory = "Inventory\n\nHearts: "+treats.getHeart()+"\n\nAxe: "+treats.getAxe()+"\n\nCoins: "+treats.getCoins()+"\n\nKeys: "+treats.getKeys()+"\n\nMagic: \n"+treats.getMagic();
  
  if(treats.getCoins() < 0){
    if(treats.getHeart() > 0) inventory = "Inventory\n\nHearts: "+treats.getHeart()+"\n\nAxe: "+treats.getAxe()+"\n\nCoins: "+0+"\n\nKeys: "+treats.getKeys()+"\n\nMagic: \n"+treats.getMagic();
    else inventory = "Inventory\n\nHearts: "+0+"\n\nAxe: "+treats.getAxe()+"\n\nCoins: "+0+"\n\nKeys: "+treats.getKeys()+"\n\nMagic: \n"+treats.getMagic();   
  }
  
  fill(255);
  text(inventory,610,20); 
}

void story(){
  fill(0);
  rect(0,400,width,50);
  textFont(f);
  story_text = line_to_disp.display(timeline);
 
  fill(255);
  text(story_text,3,420);

  
}
void resetGames(){
  for(int i = 0;i<MAXBG;i++){
    if(bg_show[i] == true) image(bg[i],0,0);
  }  
  int whichTroll;
  player.loadImages();
  axe.loadImages();
  potion.loadImages();
  hearts.loadImages();
  coins.loadImages();
  jail.loadImages();
  princess.loadImages();
  troll_1.loadImages();
  troll_2.loadImages();
  troll_3.loadImages();
  troll_4.loadImages();
  troll_5.loadImages();
  if(!giftHeld){
    troll_1.gift = forestGifts[(int)random(forestGifts.length)];
    //assigning gifts to trolls - forest  
    if(troll_1.gift == "key") troll_2.gift = "coins";  
    else troll_2.gift = "key";  
    //assigning gifts to trolls - dungeon
    troll_3.gift = dungeonGifts[(int)random(dungeonGifts.length)];
    giftHeld = true;
  }
  drawCoins();

  if(timeline !=5){
    checkKeys();
    player.checkState();
    manageTrolls(timeline);
    if(timeline == 4){    
      if(coins.Money(player.cX,player.cY)) treats.Items("coins",1);
    }
    
    inventory();
    whichTroll = checkCollisions();
    if(player.attackState == "attacking"){
      player.attackState = "none";
      if(treats.getAxe() > 0){
        if(whichTroll > 0) updateAttackPoints(whichTroll,true);
        if(player.idlingState == "right") image(player.images[2],player.cX,player.cY);
        if(player.idlingState == "left") image(player.images[5],player.cX,player.cY);
        if(player.idlingState == "up") image(player.images[6],player.cX,player.cY);
        if(player.idlingState == "down") image(player.images[7],player.cX,player.cY);
      }
      else{
        if(whichTroll > 0 ) updateAttackPoints(whichTroll,false);
        if(player.dirState == "right") image(player.images[1],player.cX,player.cY);      
        else if(player.dirState == "up") image(player.images[3],player.cX,player.cY); 
        else if(player.dirState == "left") image(player.images[4],player.cX,player.cY);
        else image(player.images[0],player.cX,player.cY);    
      }
      player.attackState = "none";
    }
    else{
      if(whichTroll > 0){
        troll_1.attackState = "attacking";
        manageTrolls(timeline);
        updateDamagePlayer(whichTroll);    
      }
      if(player.dirState == "right") image(player.images[1],player.cX,player.cY);      
      else if(player.dirState == "up")image(player.images[3],player.cX,player.cY); 
      else if(player.dirState == "left")image(player.images[4],player.cX,player.cY);
      else image(player.images[0],player.cX,player.cY);  
    }
    /*Change story board*/
    if(timeline == 3){
      if(isSaved == true) image(princess.images,princess.cX,princess.cY);
      else image(jail.images,jail.cX,jail.cY); 
      //manageTrolls(timeline); spawn for dungeon
    }
  }
  if(timeline == 5){
    image(axe.images,axe.cX,axe.cY);
    image(potion.images,potion.cX,potion.cY);
    for(int i=0;i<=70;i=i+10){
      image(coins.images,coins.cX+i,coins.cY);
    }
    if(mousePressed){
      if(axe.chosen(mouseX,mouseY)){
        if(stock.getAxeStock()){
          updateCoinInventory("axe",-4);
          stock.axeStock = false;
        }
      } 
      if(potion.chosen(mouseX,mouseY)){
        if(stock.getPotionStock()){
          updateCoinInventory("magic",-8);
          stock.potionStock = false;
        }
      }
      if(coins.chosen(mouseX,mouseY)){
        if(stock.getCoinStock() > 1){
          updateCoinInventory("heart",-2);
          stock.coinStock = stock.coinStock - 2;
        }
      }
    }      
      inventory();      
  }  
  if(player.isDead(treats.getHeart())) gameOver(); 
  
}

void updateDamagePlayer(int who){
  if(who == 1){
    if(treats.getHeart() < .5) player.isDead(0);  
    else treats.Items("heart",-1);  
  }  
  if(who == 2){
    if(treats.getHeart() < .5) player.isDead(0);  
    else treats.Items("heart",-1);  
  }  
  if(who == 3){
    if(treats.getHeart() < .5) player.isDead(0);  
    else treats.Items("heart",-1);  
  }    
  inventory();
}

void updateAttackPoints(int who,boolean axed){
  if(who == 1){
    if(troll_1.getHealth() >= 1){
      println("health"+troll_1.getHealth());
      if(!axed) troll_1.Enemy(1,false);   
      else troll_1.Enemy(2,false); 
    }
    else{
      troll_1.cX = -150;
      troll_1.cY = -150;
      troll_1.Enemy(0,true);
      deadTrolls++;
      if(troll_1.gift == "key"){
        treats.Items("keys",1);
        treats.Items("heart",2);    
      }
      else treats.Items("coins",3);    
    }
  }
  if(who == 2){
    if(troll_2.getHealth() >= 1){
      println("health"+troll_2.getHealth());
      if(!axed) troll_2.Enemy(1,false);   
      else troll_2.Enemy(2,false); 
    }
    else{
      troll_2.cX = -150;
      troll_2.cY = -150;
      troll_2.Enemy(0,true);
      deadTrolls++;
      if(troll_2.gift == "key"){
        treats.Items("keys",1);
        treats.Items("heart",2);    
      }
      else treats.Items("coins",4);    
    }    
  }
  if(who == 3){
    if(troll_3.getHealth() >= 1){
      println("health"+troll_3.getHealth());
      if(!axed) troll_3.Enemy(1,false);   
      else troll_3.Enemy(2,false); 
    }
    else{
      troll_3.cX = -150;
      troll_3.cY = -150;
      troll_3.Enemy(0,true);
      deadTrolls++;
      if(troll_3.gift == "heart"){
        treats.Items("heart",4);    
      }
      else treats.Items("coins",2);    
    }    
  }
    
  inventory();  
}

void updateCoinInventory(String type,int num){
  if(type != "heart"){
    if(abs(num) <= treats.getCoins()){
      treats.Items("coins",num);
      treats.Items(type,1); 
    }
  }
  else{
    if(abs(num) <= treats.getHeart()){
      treats.Items(type,num);
      treats.Items("coins",2);
    }
  }  
}

void manageTrolls(int timeline){
  if(timeline == 4){
    troll_1.checkState();
    troll_2.checkState();
    troll_1.checkBorders(timeline);
    troll_2.checkBorders(timeline);
    if(troll_1.attackState == "attacking" && troll_1.isDead == false){
        if(troll_1.idlingState == "left") image(troll_1.images[1],troll_1.cX,troll_1.cY);
        if(troll_1.idlingState == "right") image(troll_1.images[3],troll_1.cX,troll_1.cY);    
    }
    else{
      if(troll_1.dirState == "idling" && troll_1.isDead == false){
        troll_1.cX = troll_1.randX[0];    
        troll_1.cY = troll_1.randY[0];
        image(troll_1.images[2],troll_1.cX,troll_1.cY);
      }
      if(troll_1.dirState == "left" && troll_1.isDead == false) image(troll_1.images[0],troll_1.cX,troll_1.cY);
      if(troll_1.dirState == "right" && troll_1.isDead == false) image(troll_1.images[2],troll_1.cX,troll_1.cY);
    }
    if(troll_2.dirState == "attacking" && troll_2.isDead == false){
      if(troll_2.idlingState == "up"&& troll_2.isDead == false) image(troll_2.images[3],troll_2.cX,troll_2.cY);
    }
    else{
      if(troll_2.dirState == "idling"&& troll_2.isDead == false){
        troll_2.cX = troll_2.randX[1];
        troll_2.cY = troll_2.randY[1];       
        image(troll_2.images[2],troll_2.cX,troll_2.cY);        
      }
      if(troll_2.dirState == "up" || troll_2.dirState == "down" && troll_2.isDead == false) image(troll_2.images[2],troll_2.cX,troll_2.cY);
      
    }
    troll_1.attackState = "none";
    troll_2.attackState = "none"; 
  }
  if(timeline == 3){
    troll_3.checkState();
    troll_3.checkBorders(timeline);
    if(troll_3.attackState == "attacking" && troll_3.isDead == false){
        if(troll_3.idlingState == "left") image(troll_3.images[1],troll_3.cX,troll_3.cY);
        if(troll_3.idlingState == "right") image(troll_3.images[3],troll_3.cX,troll_3.cY);    
    }
    else{
      if(troll_3.dirState == "idling" && troll_3.isDead == false){
        troll_3.cX = troll_3.randX[2];    
        troll_3.cY = troll_3.randY[2];
        image(troll_3.images[2],troll_3.cX,troll_3.cY);
      }
      if(troll_3.dirState == "left" && troll_3.isDead == false) image(troll_3.images[0],troll_3.cX,troll_3.cY);
      if(troll_3.dirState == "right" && troll_3.isDead == false) image(troll_3.images[2],troll_3.cX,troll_3.cY);
    }    
  }
  troll_3.attackState = "none"; 
}
int checkCollisions(){
    if(player.cX >= troll_1.cX && player.cX-troll_1.cX <= troll_1.buffX){
      if(player.cY >= troll_1.cY && player.cY-troll_1.cY <= troll_1.buffY) return 1; 
    }
    if(player.cX >= troll_2.cX && player.cX-troll_2.cX <= 100 ){
      if(player.cY >= troll_2.cY && player.cY-troll_2.cY <= troll_1.buffY) return 2;
    }
    if(player.cX >= troll_3.cX && player.cX-troll_3.cX <= troll_3.buffX){
      if(player.cY >= troll_3.cY && player.cY-troll_3.cY <= troll_3.buffY) return 3; 
    }    
    return 0;  
}
void drawCoins(){
  if(timeline == 4){
    for(int i=0;i<3;i++){
      image(coins.images,coins.randX[i],coins.randY[i]);
    }
    
  }
}
HashSet<Integer> keysDown = new HashSet<Integer>();

void keyPressed()
{ 
  keysDown.add(keyEvent.getKeyCode());
}

void keyReleased()
{ 
  keysDown.remove(keyEvent.getKeyCode());
}

boolean keyDown(int kcode) {
  return keysDown.contains(kcode);
}

void checkKeys() {
  if (keyDown(ENTER)){
    displayRoutes();
  }
  if (keyDown(LEFT) && timeline != 1 && timeline != 2){
    player.dirState = "left";
    troll_1.dirState = "left";
    troll_2.dirState = "up";
    troll_3.dirState = "left";
  }
  if (keyDown(RIGHT) && timeline != 1 && timeline != 2){
    player.dirState = "right";
    troll_1.dirState = "left";
    troll_2.dirState = "down";
    troll_3.dirState = "left";
  }
  if (keyDown(UP) && timeline != 1 && timeline != 2){
    player.dirState = "up";
    troll_1.dirState = "left";
    troll_2.dirState = "up";
    troll_3.dirState = "left";
  }
  if (keyDown(DOWN) && timeline != 1 && timeline != 2){
    player.dirState = "down";
    troll_1.dirState = "left";
    troll_2.dirState = "down";
    troll_3.dirState = "left";
  }
  if (keyDown(CONTROL) && player.attackState == "none" && timeline != 1 && timeline != 2){
    player.attackState = "attacking";

  }
  if(keyDown(SHIFT) && timeline == 3){
    if(treats.getMagic() != "no magic"){
      treats.magic = "none";
      isSaved = true;
      timeline = 6;
    }  
  }
  if (!keyDown(LEFT) &&  !keyDown(RIGHT) &&  !keyDown(UP) && !keyDown(DOWN) && !keyDown(SHIFT)){
    player.dirState = "idling";
  }  
  
  //if at route screen then choose path
  if(keyDown('1')){
      displayForest();
  }
  if(keyDown('2')){
      displayDungeon();

  }
  if(keyDown('3')){
      displayMarket();
  }

}
void displayRoutes(){
  for(int i =0;i<MAXBG;i++){
    if(i==1){
      bg_show[i] = true;      
    }
    else{
      bg_show[i] = false;  
    }
  }
  timeline = 1;
 
}

void displayForest(){
  for(int i =0;i<MAXBG;i++){
    if(i==4){
      bg_show[i] = true;      
    }
    else{
      bg_show[i] = false;  
    }
  }
  timeline = 4;
}

void displayDungeon(){
  int num = treats.getKeys();
  
  for(int i =0;i<MAXBG;i++){
    if(i== 2 && num == 0){
      bg_show[i] = true;  
      timeline = 2;   
    }
    else if(i==3 && num > 0){
      bg_show[i] = true;  
      timeline = 3;
    }
    else{
      bg_show[i] = false; 
      
    }     
  }
  

}
void gameOver(){
  background(gameDone);
 
  noLoop();  
}
void won(){
  background(win);
 
  noLoop();
}
void displayMarket(){
  for(int i =0;i<MAXBG;i++){
    if(i==5){
      bg_show[i] = true;      
    }
    else{
      bg_show[i] = false;  
    }
  }
  timeline = 5;
}
