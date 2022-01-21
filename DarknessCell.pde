class DarknessCell {
  float opacity;
  float x, y, s;
  
  //Slightly randomizes exact darkness values, makes it look nicer
  float range;
  //Makes it more staticy
  float frange;
  
  static final int radius = 190;
      
  DarknessCell(float x_, float y_, float s_) {
    s = s_;
    x = x_;
    y = y_;
    opacity = 255;   
    
    range = random(-10, 10);
  }
  
  void show () {
    opacity = 255;
    
    frange = random(-map(myHero.hp, 0, myHero.maxhp, 16, 2), map(myHero.hp, 0, myHero.maxhp, 16, 2));
    
    //Temporary color each frame 
    //Makes it so tint from lamp can take priority without being permanent
    float rval = 0;
    float gval = 0;
    float bval = 0;
    
    float d = dist(x, y, myHero.loc.x, myHero.loc.y);
    float o = map(d, (myHero.sizeX + myHero.sizeY)/4, myHero.lum, 0, 255);
    opacity = o;
    
    int i = 0;
    while (i < myObjects.size()) {
      GameObject myObj = myObjects.get(i);
      
      //myObj.lum - each GameObject gets a lum score that represents the radius of light around it
      if (myObj.lum > 0 && myObj.objRoom == currentRoom) {
        
        //Gets dist from object
        float d_ = dist(x, y, myObj.loc.x, myObj.loc.y);
        //Maps brightness value from dist
        float l = map(d_, (myObj.sizeX + myObj.sizeY)/4, myObj.lum, 0, 255);
        if (l < 0) l = 0;
        if (l < opacity) {
          opacity = l;
          frange = 0;
        }
        
        float st = map(d_, 0, myObj.lum, 45, 0);
        
        if (st < 0) st = 0;
        
        //Checks colour of lamp (using hp as an intermediary)
        if (myObj.hp == 77777) {
          rval += st;
        } else if (myObj.hp == 88888) {
          gval += st;
        } else if (myObj.hp == 99999) {
          bval += st;
        }
                               
      }
      
      i++;
    }
    
    if (myHero.deathTime <= 0 && opacity != 255) opacity += map(dist(x, y, myHero.loc.x, myHero.loc.y), 0, radius, range/2 + frange/4, range + 2*frange);
    
    //Removes all static while hero is dying 
    if (myHero.deathTime > 0) opacity += map(dist(x, y, myHero.loc.x, myHero.loc.y), 0, radius, range/2, range);
        
    fill(rval, gval, bval, opacity);
    noStroke();
    rect(x, y, s, s);
  }
}
