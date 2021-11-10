class StartingRoom extends Room {
  
  //Added a throwaway var to differentiate it from super class
  StartingRoom (int roomX_, int roomY_) {
    super(roomX_, roomY_);
  }
  
  void show () {
    super.show();
    
    textSize(30);
    fill(White);
    text("WASD to move", width/2, height/2 - 50);
    text("Space to shoot", width/2, height/2 + 50);
  }
  
}
