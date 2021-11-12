//Basic melee class, is big and strong but slow
class MeleeEnemy extends GameObject {
  
  //For hit cd
  int hitTimer;
  
  int attackDamage;
  
  float speed;
  
  MeleeEnemy (float x_, float y_, Room objRoom_) {
    super(objRoom_);
    
    hp = 50;
    
    loc = new PVector(x_, y_);
    
    invTimeLimit = 5;
    
    sizeX = sizeY = 105;
    
    attackDamage = 14;
    
    speed = 1;
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
    if (dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y) <= sizeX/2 - 5 + myHero.sizeX/2) {
      loc.sub(vel);
    }
    
    hitTimer++;
    
    if (dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y) <= sizeX/2 + myHero.sizeX/2) loc.sub(vel);
    vel.x = myHero.loc.x - loc.x;
    vel.y = myHero.loc.y - loc.y;
    vel.setMag(speed);
    
    int i = 0;
    while (i < myObjects.size()) {
      GameObject myObj = myObjects.get(i);
      
      if (myObj instanceof Bullet) {
        if (dist(myObj.loc.x, myObj.loc.y, loc.x, loc.y) <= sizeX/2 + myObj.sizeX/2) {
          hit(myHero.myWeapon.attackDamage);
          
          //Outright removes bullet to skip death anim (don't want anims to overlap)
          if (hp <= 0) {
            myObjects.remove(i);
          } else {
            myObj.hp = 0;
          }
          
          deathAnim();
        }
      } else if (dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y) <= sizeX/2 + myHero.sizeX/2) {
        myHero.hit(attackDamage);
      }
      
      i++;
    }
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
            
            i++;
          }
        }
        
        //Time between death and game over screen
        //amount of time given for particles to spawn + amount of time for particles of dissipate
        if (frameCount >= deathTime + spawnLimit + Splash.hplimit/Splash.hplossrate) myObjects.remove(this);      
      }
  }  
  
}
