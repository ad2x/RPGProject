class UpgradeOrb extends GameObject {
  
  //Orb upgrade type
  color c;
  
  UpgradeOrb (float x, float y, color c_, Room ObjRoom) {
    super(ObjRoom);
    
    c = c_;
    
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
  }
  
  void act () {
    if (dist(loc.x, loc.y, myHero.loc.x, myHero.loc.y) <= (sizeX + sizeY)/4 + myHero.sizeX/2) {
      hp = 0;
      
      myHero.myScore.gotUpgrade(1);
      
      if (c == NRed6) {
        myHero.extdamage++;
      } else if (c == NGreen6) {
        myHero.exthp++;
      } else if (c == NBlue6) {
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
