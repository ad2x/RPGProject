class MapCell {
  
  float x, y;
  int mx, my;
  static final float size = 15;
  color c;
  
  //Distance between map and origin
  float bx = 50;
  float by = 50;
  
  //Used to make it so rooms only appear on map once revealed (player has entered them)
  boolean discovered;
  
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
      transparency = map(dist(x+bx, y+by, myHero.loc.x, myHero.loc.y), 0, sqrt(pow(currentRoom.sx, 2) + pow(currentRoom.sy, 2)), 80, 220);
    } else {
      transparency = 220;
    }
    
    fill(Black, transparency);
    
    //!!!! NEED TO FIGURE OUT WHY JUST USING c DOESN'T WORK RN
    if (discovered) {
      fill(White, transparency);
    }
    
    if (myHero.roomX == mx && myHero.roomY == my) {
      //Did this so it wouldn't mess with the frameCount var itself and therefore the death animation
      int frameCount_ = frameCount;
      if ((frameCount_ %= 30) > 15) {
        fill(#646464, transparency);
      } else {
        fill(White, transparency);
      }
    }
    
    square(x + bx, y + by, size);
  }
  
  void discovery () {
    int i = 0;
    while (i < myRooms.size()) {
      Room aRoom = myRooms.get(i);
      
      if (aRoom.roomX == mx && aRoom.roomY == my) {
        discovered = true;
       }
      
      i++;
    }
  }
}
