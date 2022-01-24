 //Room with four lurkers, one in each corner
class LurkerRoom extends Room {
  
  LurkerRoom (int roomX, int roomY) {
    super(roomX, roomY);
    
    myObjects.add(new Lurker(width/4 + random(-25, 25), height/4 + random(-25, 25), this));
    myObjects.add(new Lurker(width/4 + random(-25, 25), 3*height/4 + random(-25, 25), this));
    myObjects.add(new Lurker(3*width/4 + random(-25, 25), height/4 + random(-25, 25), this));
    myObjects.add(new Lurker(3*width/4 + random(-25, 25), 3*height/4 + random(-25, 25), this));
    myObjects.add(new Lurker(width/2 + random(-25, 25), height/2 + random(-25, 25), this));
  }
}
