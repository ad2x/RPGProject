class UpgradeOrb extends GameObject {
  
  //Orb upgrade type
  color c;
  int ct;
  
  UpgradeOrb (float x, float y, int c_, Room ObjRoom) {
    super(ObjRoom);
    
    switch (c_) {
      case 1: 
        c = Red;
        break;
      case 2:
        c = Green;
        break;
      case 3:
        c = Blue;
        break;
    }
    
    ct = c_;
    
    loc = new PVector(x, y);
    
    lum = 100;
    
    sizeX = sizeY = 75;
    
    hp = 200;
    
    solid = true;
  }
  
  void show () {
    stroke(#a27c00);
    strokeWeight(10);
    fill(Gold);
    
    ellipse(loc.x, loc.y, sizeX, sizeY);
    
    if (ct == 1) {
      float cx = 0;
      float cy = 25;
      
      float bx = cx*cos(radians(120)) - cy*sin(radians(120));
      float by = cx*sin(radians(120)) + cy*cos(radians(120));
      
      float ax = cx*cos(radians(240)) - cy*sin(radians(240));
      float ay = cx*sin(radians(240)) + cy*cos(radians(240));
      
      triangle(ax, ay, bx, by, cx, cy);
    } else if (ct == 2) {
      rect(-25, -25, 50, 50);
    } else if (ct == 3) {
      ellipse(0, 0, 50, 50);
    }
  }
  
  void act () {
    if (dist(loc.x, loc.y, myHero.loc.x, myHero.loc.y) <= (sizeX + sizeY)/4 + myHero.sizeX/2) {
      hp = 0;
      
      myHero.myScore.gotUpgrade(1);
      
      if (ct == 1) {
        myHero.extdamage++;
      } else if (ct == 2) {
        myHero.exthealth++;
        myHero.increaseHp(10);
      } else if (ct == 3) {
        myHero.extspeed++;
      }
      
      int i = 0;
      while (i < 16) {
        myObjects.add(new Splash(Splash.square, loc.x, loc.y, c, false, 12, 18, true));
        
        i++;
      }
    }
  }
}
