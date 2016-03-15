class Items{
    int axe = 0;
    int coins = 2;
    int keys = 0;
    int heart = 10;
    String magic = "no magic";

  void Items(String type, int num){
    if(type == "axe"){
      this.axe = this.axe+num;
    }
    else if(type == "coins"){
      this.coins = this.coins+num;
    }
    else if(type == "keys"){
      this.keys = this.keys+num;
    }
    else if(type == "heart"){
      this.heart = this.heart+num;
    }
    else if(type == "magic"){
      this.magic = "Potion X";
    } 
  }
  int getAxe(){
    return this.axe;
  }
  int getCoins(){
    return this.coins;  
  }
  String getMagic(){
    return this.magic;  
  }
  int getHeart(){
    return this.heart;
  }
  int getKeys(){
    return this.keys;  
  }
  
  
}

