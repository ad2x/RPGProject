class GameObject {
  
  PVector loc;
  PVector vel;
  float hp;
  
  float sizeX;
  float sizeY;
  
  //Can go through walls
  boolean passthrough;
  
  GameObject () {
    loc = new PVector (width/2, height/2);
    vel = new PVector (0, 0);
    hp = 1;
  }
  
  void show () {
    
  }
  
  void act () {
    loc.add(vel);
    
    if (passthrough == false) {
      if (loc.x < (width - currentRoom.sx)/2 + sizeX/2) {
        vel.set(0, 0);
        loc.x = (width - currentRoom.sx)/2 + sizeX/2;
      }
      
      if (loc.x > width/2 + currentRoom.sx/2 - sizeX/2) {
        vel.set(0, 0);
        loc.x = width/2 + currentRoom.sx/2 - sizeX/2;
      }
      
      if (loc.y < (height - currentRoom.sy)/2 + sizeY/2) {
        vel.set(0, 0);
        loc.y = (height - currentRoom.sy)/2 + sizeY/2;
      }
      
      if (loc.y > height/2 + currentRoom.sy/2 - sizeY/2) {
        vel.set(0, 0);
        loc.y = height/2 + currentRoom.sy/2 - sizeY/2;
      }
    }
  }
  
}
