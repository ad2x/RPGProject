class DarknessCell {
  float opacity;
  float x, y, s;
  
  //Slightly randomizes exact darkness values, makes it look nicer
  float range;
  //Makes it more staticy
  float frange;
        
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
   
    float d = dist(x, y, myHero.loc.x, myHero.loc.y);
    float o = map(d, (myHero.sizeX + myHero.sizeY)/4, myHero.lum, 0, 255);
    int o_ = (int) o;
    opacity = o;
    
    //Color of cell
    color cellColor = Black;
    //Number of colours blended
    //Makes it so all colours blended have an equal impact on final colour regardless of when they were blended in the process
    int stepN = 1;
    
    float l = 0;
    
    boolean hueT = false;
    
    int i = 0;
    while (i < myObjects.size()) {
      GameObject myObj = myObjects.get(i);
      
      //myObj.lum - each GameObject gets a lum score that represents the radius of light around it
      if (myObj.lum > 0 && myObj.objRoom == currentRoom) {
        
        //Gets dist from object
        float d_ = dist(x, y, myObj.loc.x, myObj.loc.y);
        //Maps brightness value from dist
        l = map(d_, (myObj.sizeX + myObj.sizeY)/4, myObj.lum, 0, 255);
        if (l < 0) l = 0;
        int l_ = (int) l;
        if (l < opacity) {
          opacity = l;
          frange = 0;
        }
        
        int objHue = (int) myObj.lumColor;
        if (d_ < myObj.lum && objHue != White) {
          hueT = true;
          //Checks colour of object
          //Gets the average hue
          if (stepN == 1) {
            cellColor = objHue;
            stepN++;
          } else {
            cellColor = mixColor(cellColor, objHue, 1/stepN);
            stepN++;
          }
             
        }
      }
      
      i++;
    }
        
    if (myHero.deathTime <= 0 && opacity != 255) opacity += map(dist(x, y, myHero.loc.x, myHero.loc.y), 0, myHero.lum, range/2 + frange/4, range + 2*frange);
    
    //Removes all static while hero is dying 
    if (myHero.deathTime > 0) opacity += map(dist(x, y, myHero.loc.x, myHero.loc.y), 0, myHero.lum, range/2, range);
    
    float a = 0;
    if (hueT) a = map(opacity, 0, 255, 50, 0);
    
    if (x > 80 && x < 720 && y > 80 && y < 720) {
      fill(color(cellColor, 255, a), opacity);
    } else {
      fill(Black, opacity);
    }
    noStroke();
    
    rect(x, y, s, s);
  }
  
}
