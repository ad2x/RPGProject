class Room {
  
  //Coordinates on map
  int roomX, roomY;
  
  //Room width
  float sx = 4*width/5;
  float sy = 4*height/5;
  
  //Exits
  color northExit, eastExit, southExit, westExit;
  boolean northToggle, eastToggle, southToggle, westToggle;
  
  //Enemy check
  boolean check = false;
  
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
      if (check == false) fill(h - 255);
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
    //Checks if all enemies have been defeated
    check = true;
    
    int i = 0;
    while (i < myObjects.size()) {
      GameObject myObj = myObjects.get(i);
      
      if (myObj instanceof MeleeEnemy) {
        check = false;
      }
      
      i++;
    }
    
    if (check) {
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
  }
  
  boolean doorCheck (float doorX, float doorY, boolean dirToggle) {
    if (myHero.loc.x >= doorX - myHero.sizeX/2 && myHero.loc.x <= doorX + myHero.sizeX/2 && myHero.loc.y >= doorY - myHero.sizeY/2 && myHero.loc.y <= doorY + myHero.sizeY/2 && dirToggle) {
      return true;
    } else {
      return false;
    }
  }
  
  //Code  for moving rooms, includes:
  //Setting hero pos.
  //Generating new room *if* room hasn't already been loaded
  //Deleting bullets and splash particles upon leaving room
  void moveRoom () {
    myHero.loc.x = width - myHero.loc.x;
    myHero.loc.y = height - myHero.loc.y;
        
    //So I don't run into an infinite loop of the player getting sent back and forth because they are always within range of the door
    if (myHero.loc.x < width/2) myHero.loc.x += 10;
    if (myHero.loc.x > width/2) myHero.loc.x -= 10;
    if (myHero.loc.y < height/2) myHero.loc.y += 10;
    if (myHero.loc.y > height/2) myHero.loc.y -= 10;
    
    //Checks if new room is already saved, if so it goes to that, if not it makes a new one
    int i = 0;
    while (i < myRooms.size()) {
      Room cRoom = myRooms.get(i);
      
      //If i is the entered room, set the current room to i
      if (cRoom.roomX == myHero.roomX && cRoom.roomY == myHero.roomY) {
        i = myRooms.size();
        
        currentRoom = cRoom;
      }
      
      i++;
      
      //If the whole arraylist has been checked through and the entered room hasn't been found, append a new room (of a certain type depending on colour) and set it as the current room
      if (i == myRooms.size()) {
        if (map.get(myHero.roomX, myHero.roomY) == Blue) {
          currentRoom = new UpgradeRoom (myHero.roomX, myHero.roomY);
        } else if (map.get(myHero.roomX, myHero.roomY) == Red) {
          currentRoom = new LurkerRoom (myHero.roomX, myHero.roomY);
        } else if (map.get(myHero.roomX, myHero.roomY) == Green) {
          currentRoom = new Room (myHero.roomX, myHero.roomY);
        } else if (map.get(myHero.roomX, myHero.roomY) == Gold) {
          currentRoom = new Room (myHero.roomX, myHero.roomY);
        } else {
          currentRoom = new Room (myHero.roomX, myHero.roomY);
        }
        
        myRooms.add(currentRoom);
        
        myHero.myScore.enterRoom(4);
      }
    }
    
    
    //Clears the screen of bullets and particles upon entering a new room
    i = 0;
    while (i < myObjects.size()) {
      GameObject myObj = myObjects.get(i);
      
      if (myObj instanceof Bullet || myObj instanceof Splash) {
        myObjects.remove(myObj);
      } else {
        i++;
      }
    }
  }
}
