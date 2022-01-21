//Basic melee class, is big and strong but slow
class MeleeEnemy extends GameObject {
  
  //For hit cd
  int hitTimer;
  
  float speed;
  
  MeleeEnemy (float x_, float y_, Room objRoom_) {
    super(objRoom_);
    
    hp = 50;
    
    loc = new PVector(x_, y_);
    
    invTimeLimit = 5;
    
    sizeX = sizeY = 105;
    
    attackDamage = 14;
    
    speed = 1;
    
    solid = true;
    
    solid = true;
  }
  
  void show () {
    pushMatrix();
    translate(loc.x, loc.y);
    if (myHero.loc.x >= loc.x) rotate(atan((myHero.loc.y - loc.y)/(myHero.loc.x - loc.x)) - PI/2);
    if (myHero.loc.x < loc.x) rotate(atan((myHero.loc.y - loc.y)/(myHero.loc.x - loc.x)) + PI/2);
    
    noStroke();
    fill(lerp(White, Black, map(hp, 0, 25, 0.2, 1)));
    ellipse(0, 0, sizeX, sizeY);
    
    pushMatrix();
    rotate(-PI/3); 
    
    fill(White);
    
    rectMode(CENTER);
    rect(-30, 0, 15, 15);
    rectMode(CORNER);
    
    popMatrix();
    
    pushMatrix();
    rotate(PI/3);
    
    fill(White);
    
    rectMode(CENTER);
    rect(30, 0, 15, 15);
    rectMode(CORNER);
    
    popMatrix();
    
    popMatrix();
  }
  
  void act () {
    super.act();
            
    deathAnim();
        
    //Collision
    if (dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y) <= sizeX/2 - 10 + myHero.sizeX/2) {
      loc.sub(vel);
    }
    
    hitTimer++;
    
    vel.x = myHero.loc.x - loc.x;
    vel.y = myHero.loc.y - loc.y;
    vel.setMag(speed);
  }
  
  void deathAnim () {
    if (hp <= 0) {        
      if (deathTime == 0) deathTime = frameCount;
      
      //Amount of frames given to spawn particles
      int spawnLimit = 12;
      
      if (frameCount <= deathTime + spawnLimit) {
        int i = 0;
        
        //# determines density of particles
        while (i < 17) {
          myObjects.add(new Splash(Splash.triangle, loc.x, loc.y, NRed1, true, 10, 20));
          
          myHero.myScore.killedEnemy(1);
          
          i++;
        }
      }
      
      //Time between death and game over screen
      //amount of time given for particles to spawn + amount of time for particles of dissipate
      if (frameCount >= deathTime + spawnLimit + Splash.hplimit/Splash.hplossrate) myObjects.remove(this);      
      
      //Not part of death anim but happens at the same time
      if (myHero.hp > 0) {
      int i = 0;
        while (i < 3) {
          myObjects.add(new HealthPoint(1, loc.x + random(-sizeX/4, sizeX/4), loc.y + random(-sizeY/4, sizeY/4)));
          i++;
        }
      }
    } 
  }  
  
}
