class Room {
  
  //Coordinates on map
  int roomX, roomY;
  
  //Room width
  float sx = 4*height/5;
  float sy = 4*height/5;
  
  //Exits
  color northExit, eastExit, southExit, westExit;
  boolean northToggle, eastToggle, southToggle, westToggle;
  
  Room (int roomX_, int roomY_) {
    roomX = roomX_;
    roomY = roomY_;
    
    northExit = map.get(myHero.roomX, myHero.roomY-1);
    eastExit = map.get(myHero.roomX+1, myHero.roomY);
    southExit = map.get(myHero.roomX, myHero.roomY+1);
    westExit = map.get(myHero.roomX-1, myHero.roomY);
  }
  
  public void show () {
    
    //Exits
    if (northExit != #FFFFFF) {
      exitdoor(width/2, height/2 - sy/2);
      northToggle = true;
    }
    
    if (eastExit != #FFFFFF) {
      exitdoor(width/2 + sx/2, height/2);
      eastToggle = true;
    }
    
    if (southExit != #FFFFFF) {
      exitdoor(width/2, height/2 + sy/2);
      southToggle = true;
    }
    
    if (westExit != #FFFFFF) {
      exitdoor(width/2 - sx/2, height/2);
      westToggle = true;
    }

    fill(#050505);
    stroke(White);
    strokeWeight(8);
    rect((width - sx)/2, (height - sx)/2, sx, sy);
  }
  
  void exitdoor(float x, float y) {
    pushMatrix();
    translate(x, y);
    
    noStroke();
    
    //Code based off documentation: https://processing.org/examples/radialgradient.html
    int radius = 150;
    float h = 0;
    for (int r = radius; r > 0; --r) {
      fill(h);
      ellipse(0, 0, r, r);
      if (h <= 180) {
        h += 255/r*3;
      } else {
        h += 255/r;
      }
    }
    
    popMatrix();
  }
  
  public void act () {
    if (doorCheck(width/2, height/2 - sy/2, northToggle)) {
      myHero.roomY--;
      moveRoom();
    } else if (doorCheck(width/2 + sx/2, height/2, eastToggle)) {
      myHero.roomX++;
      moveRoom();
    } else if (doorCheck(width/2, height/2 + sy/2, southToggle)) {
      myHero.roomY++;
      moveRoom();
    } else if (doorCheck(width/2 - sx/2, height/2, westToggle)) {
      myHero.roomX--;
      moveRoom();
    }
  }
  
  boolean doorCheck (float doorX, float doorY, boolean dirToggle) {
    if (myHero.loc.x >= doorX - myHero.sizeX/2 && myHero.loc.x <= doorX + myHero.sizeX/2 && myHero.loc.y >= doorY - myHero.sizeY/2 && myHero.loc.y <= doorY + myHero.sizeY/2 && dirToggle) {
      return true;
    } else {
      return false;
    }
  }
  
  void moveRoom () {
    myHero.loc.x = width - myHero.loc.x;
    myHero.loc.y = height - myHero.loc.y;
    
    //Commented until I implement checker to make sure you can't just go back and forth for free hp
    //if (myHero.hp <= 90) myHero.hp += 10;
        
    //So I don't run into an infinite loop of the player getting sent back and forth because they are always within range of the door
    if (myHero.loc.x < width/2) myHero.loc.x += 10;
    if (myHero.loc.x > width/2) myHero.loc.x -= 10;
    if (myHero.loc.y < height/2) myHero.loc.y += 10;
    if (myHero.loc.y > height/2) myHero.loc.y -= 10;
    
    //Checks if new room is already saved, if so it goes to that, if not it makes a new one
    int i = 0;
    while (i < myRooms.size()) {
      Room cRoom = myRooms.get(i);
      
      if (cRoom.roomX == myHero.roomX && cRoom.roomY == myHero.roomY) {
        i = myRooms.size();
        
        currentRoom = cRoom;
      }
      
      i++;
      
      if (i == myRooms.size()) {
        currentRoom = new Room (myHero.roomX, myHero.roomY);
        myRooms.add(currentRoom);
      }
    }
  }
}
