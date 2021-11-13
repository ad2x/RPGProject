//Room with four lurkers, one in each corner
class LurkerRoom extends Room {
  
  LurkerRoom (int roomX, int roomY) {
    super(roomX, roomY);
    
    myObjects.add(new Lurker(width/4, height/4, this));
    myObjects.add(new Lurker(width/4, 3*height/4, this));
    myObjects.add(new Lurker(3*width/4, height/4, this));
    myObjects.add(new Lurker(3*width/4, 3*height/4, this));
  }
}
