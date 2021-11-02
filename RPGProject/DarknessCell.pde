class DarknessCell {
  float opacity;
  float x, y, s;
  
  DarknessCell(float x_, float y_, float s_) {
    s = s_;
    x = x_;
    y = y_;
    opacity = 0;
  }
  
  void show () {
    //Radius of light circle
    float darknessDist = map(myHero.hp, 100, 0, 350, 120);
    
    float d = dist(x, y, myHero.loc.x, myHero.loc.y);
    opacity = map(d, 0, darknessDist, 0, 255);
    
    fill(Black, opacity);
    noStroke();
    rect(x, y, s, s);
  }
}
