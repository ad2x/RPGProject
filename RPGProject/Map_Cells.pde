class MapCell {
  
  float x, y;
  int mx, my;
  static final float size = 10;
  color c;
  
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
    fill(c, 190);
    
    if (myHero.roomX == mx && myHero.roomY == my) {
      if ((frameCount %= 30) > 15) {
        fill(White, 190);
      } else {
        fill(Black, 190);
      }
    }
    
    square(x + 10, y + 10, size);
  }
}
