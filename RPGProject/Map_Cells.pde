class MapCell {
  
  float x, y;
  int mx, my;
  static final float size = 10;
  color c;
  
  //Distance between map and origin
  float bx = 45;
  float by = height - 155;
  
  MapCell (int mx_, int my_, float x_, float y_) {
    x = x_;
    y = y_;
    mx = mx_;
    my = my_;
    c = map.get(mx, my);
  }
  
  void show () {
    stroke(lerp(0, 255, 0.5));
    strokeWeight(1);
    
    //Becomes more transparent closer player is to it
    float transparency;
    if (dist(x+bx, y+by, myHero.loc.x, myHero.loc.y) <= 150) {
      transparency = map(dist(x+bx, y+by, myHero.loc.x, myHero.loc.y), 0, sqrt(pow(currentRoom.sx, 2) + pow(currentRoom.sy, 2)), 80, 255);
    } else {
      transparency = 255;
    }
        
    fill(c, transparency);
    
    if (myHero.roomX == mx && myHero.roomY == my) {
      //Did this so it wouldn't mess with the frameCount var itself and therefore the death animation
      int frameCount_ = frameCount;
      if ((frameCount_ %= 30) > 15) {
        fill(White, transparency);
      } else {
        fill(Black, transparency);
      }
    }
    
    square(x + bx, y + by, size);
  }
}
