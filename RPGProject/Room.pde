class Room {
  
  //Coordinates on map
  int roomX, roomY;
  
  //Room width
  float sx, sy;
  
  //Exits
  color northExit, eastExit, southExit, westExit;
  boolean northToggle, eastToggle, southToggle, westToggle;
  
  Room (int roomX_, int roomY_) {
    sx = 4*width/5;
    sy = 4*height/5;
    
    roomX = roomX_;
    roomY = roomY_;
    
    northExit = map.get(myHero.roomX, myHero.roomY-1);
    eastExit = map.get(myHero.roomX+1, myHero.roomY);
    southExit = map.get(myHero.roomX, myHero.roomY+1);
    westExit = map.get(myHero.roomX-1, myHero.roomY);
  }
  
  public void show () {
    strokeWeight(8);
    stroke(White);
    
    line(0, 0, width, height);
    line(0, height, width, 0);
    
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

    fill(Black);
    stroke(White);
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
      moveRoom();
      myHero.roomY--;
      currentRoom = new Room (myHero.roomX, myHero.roomY);
    } else if (doorCheck(width/2 + sx/2, height/2, eastToggle)) {
      myHero.roomX++;
      moveRoom();
      currentRoom = new Room (myHero.roomX, myHero.roomY);
    } else if (doorCheck(width/2, height/2 + sy/2, southToggle)) {
      myHero.roomY++;
      moveRoom();
      currentRoom = new Room (myHero.roomX, myHero.roomY);
    } else if (doorCheck(width/2 - sx/2, height/2, westToggle)) {
      myHero.roomX--;
      moveRoom();
      currentRoom = new Room (myHero.roomX, myHero.roomY);
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
    
    if (myHero.hp <= 90) myHero.hp += 10;
        
    //So I don't run into an infinite loop of the player getting sent back and forth because they are always within range of the door
    if (myHero.loc.x < width/2) myHero.loc.x += 10;
    if (myHero.loc.x > width/2) myHero.loc.x -= 10;
    if (myHero.loc.y < height/2) myHero.loc.y += 10;
    if (myHero.loc.y > height/2) myHero.loc.y -= 10;
  }
}
