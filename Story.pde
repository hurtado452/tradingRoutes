class Story{
  int MAX = 7;
  //timeline @forest = 4 ,market = 5
  String[] text = {"You need to save the princess from the trolls!\nPress <ENTER> to begin your journey!",
                    "There are 3 paths... path 1 leads to the forest of saul, path 2 leads to the cave\npath 3 will take you to the village market."+
                    "     Choose a path! <1> <2> <3>",
                    "Door is locked! You can't go inside! To go back hit <ENTER>",
                    "Princess: Help Help!\n Use <SHIFT> to unleash your magic...<ENTER> to go back",
                    "Forest of Saul...Trolls have 6 lives.\n<ENTER> to go back",
                    "Welcome to the Market! Click on an item to purchase\n<ENTER> to go back",
                    "Princess: Thank you for saving me! You are my hero!"};
    
  String display(int timeline){
    String line="";
    for(int i=0;i<MAX;i++){
      if(i == timeline){
        line = this.text[i];
         return line;
      }  
    }
    return line;
  }
  
}
