class StartingRoom extends Room {
  
  //Added a throwaway var to differentiate it from super class
  StartingRoom (int roomX_, int roomY_) {
    super(roomX_, roomY_);
  }
  
  void show () {
    super.show();
    
    textSize(30);
    fill(White);
    text("WASD to move", width/2, height/2 - 150);
    text("Space to shoot", width/2, height/2 - 75);
    text("E to toggle overlay", width/2, height/2);
    text("Q for upgrade panel", width/2, height/2 + 75);
  }
  
}
