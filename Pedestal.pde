//Pedestal the orb rests on
class Pedestal extends GameObject {
  
  Pedestal (float x, float y, Room objRoom) {
    super(objRoom);
    
    loc = new PVector(x, y);
    
    solid = false;
  }
  
  void show () {
    pushMatrix();
    translate(loc.x, loc.y);
    
    //Pedestal for orb
    noFill();
    stroke(White);
    strokeWeight(10);
    
    rect(-150, -150, 300, 300);
    
    ellipse(0, 0, 160, 160);
    
    noFill();
    
    line(-50, -150, -50, 150);
    line(50, -150, 50, 150);
    
    line(-150, -50, 150, -50);
    line(-150, 50, 150, 50);
    
    popMatrix();
  }
}
