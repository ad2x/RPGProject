class Bullet extends GameObject {
   
  color c;
  
  
  Bullet (float ax, float ay, float sx, float sy, color f, float s) {
    super(currentRoom);
    
    vel = new PVector(ax + 0.05*myHero.extdamage, ay + 0.05*myHero.extdamage);
    loc = new PVector(sx, sy);
    c = f;
    sizeX = sizeY = s;
    
  }
  
  void show () {
    pushMatrix();
    translate(loc.x, loc.y);
    
    //Increases size based on extdamage
    sizeX = sizeY = map(myHero.extdamage, 0, 4, 18, 24);
    
    //Changes colour based on extdamage
    color t = (int) lerp(c, NRed6, map(myHero.extdamage, 0, 4, 0, 1));
    
    noStroke();
    fill(t);
        
    ellipse(0, 0, sizeX, sizeY);
    
    popMatrix();
  }
  
  void act () {
    super.act();
    
    vel.x /= 1.01;
    vel.y /= 1.01;
    
    if (vel.x == 0 && vel.y == 0) hp = 0;
        
    deathAnim();
  }
  
  //Copied from my hero class
  void deathAnim () {
    if (hp <= 0) {
        
        if (deathTime == 0) deathTime = frameCount;
        
        //Amount of frames given to spawn particles
        int spawnLimit = 3;
        
        if (frameCount <= deathTime + spawnLimit) {
          int i = 0;
          
          //# determines density of particles
          while (i < 9) {
            //Increases size based on extdamage
            float sizebonus = map(myHero.extdamage, 0, 4, 0, 7);
            
            //Changes colour based on extdamage
            color t = (int) lerp(c, NRed6, map(myHero.extdamage, 0, 4, 0, 1));
            
            myObjects.add(new Splash(Splash.circle, loc.x, loc.y, t, false, 5 + sizebonus, 10 + sizebonus));
            
            i++;
          }
        }
        
        //Time between death and game over screen
        //amount of time given for particles to spawn + amount of time for particles of dissipate 
        if (frameCount >= deathTime + spawnLimit + Splash.hplimit/Splash.hplossrate) myObjects.remove(this);      
      }
  }
  
}
