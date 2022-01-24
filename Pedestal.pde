//Pedestal the orb rests on
class Pedestal extends GameObject {
  
  //Altar shape
  //Red - Triangle
  //Green - Square
  //Blue - Circle
  
  int shape;
  
  Pedestal (float x, float y, int c, Room objRoom) {
    super(objRoom);
    
    loc = new PVector(x, y);
    
    shape = c;
    
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
    
    //Altar shape
    
    if (shape == 1) {
      pushMatrix();
      translate(0, -22);
      //Used triangle code from https://stackoverflow.com/questions/11449856/draw-a-equilateral-triangle-given-the-center/11479662
      float cx = 0;
      float cy = 120;
      
      float bx = cx*cos(radians(120)) - cy*sin(radians(120));
      float by = cx*sin(radians(120)) + cy*cos(radians(120));
      
      float ax = cx*cos(radians(240)) - cy*sin(radians(240));
      float ay = cx*sin(radians(240)) + cy*cos(radians(240));
      
      triangle(ax, ay, bx, by, cx, cy);
      popMatrix();
    } else if (shape == 2) {
      rect(-90, -90, 180, 180);
    } else {
      ellipse(0, 0, 180, 180);
    }
        
    noFill();
    
    //line(-50, -150, -50, 150);
    //line(50, -150, 50, 150);
    
    //line(-150, -50, 150, -50);
    //line(-150, 50, 150, 50);
    
    popMatrix();
  }
}
