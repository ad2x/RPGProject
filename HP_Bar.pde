class HpBar {
  
  float dx, dy;
  
  HpBar (float dx_, float dy_) {
    dx = dx_;
    dy = dy_;
  }
  
  void show (float x, float y) {
    float transparency;
    if (dist(x, y, myHero.loc.x, myHero.loc.y) <= 100) {
      transparency = map(dist(x, y, myHero.loc.x, myHero.loc.y), 0, sqrt(pow(currentRoom.sx, 2) + pow(currentRoom.sy, 2)), 80, 220);
    } else {
      transparency = 220;
    }
    
    pushMatrix();
    translate(x, y);
    
    stroke(White, transparency);
    strokeWeight(8);
    fill(Black, transparency);
    
    rect(-dx/2, -dy/2, dx, dy, 45);
    
    noStroke();
    fill(White, transparency);
    
    if (myHero.hp >= 0) rect(-dx/2, -dy/2, map(myHero.hp, 0, myHero.maxhp, 0, dx), dy, 45);
    
    fill(map(myHero.hp, 0, myHero.maxhp, 255, 0), transparency);
    textSize(12);
    
    if (myHero.hp > 0) text((int)myHero.hp + "/" + myHero.maxhp, 0, 0);
    if (myHero.hp <= 0) text("DEAD", 0, 0);
    
    popMatrix();
  }
}
