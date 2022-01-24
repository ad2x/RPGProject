class GameObject {
  
  PVector loc;
  PVector vel;
  float hp;
  
  float sizeX;
  float sizeY;
  
  //Invincibility timer
  int invTimer;
  int invTimeLimit;
  
  int deathTime;
  
  //Luminescence
  float lum = 0;
  color lumColor = White;
  
  //Room that object is saved to
  //Object will only be displayed or processed if in current room
  //Allows for a system in which the locations and states of different gameObjects (e.g. bullets, enemies, andn powerups) are fully saved throughout different rooms 
  //and can be reaccessed as they were left
  Room objRoom;
  
  //Boolean for collision
  //Solid objects can be hit and can't be walked through
  boolean solid;
  
  //Attack damage 
  int attackDamage;
  
  GameObject (Room objRoom_) {
    loc = new PVector (width/2, height/2);
    vel = new PVector (0, 0);
    hp = 1;
    
    objRoom = objRoom_;
  }
  
  void show () {}
  
  void act () {
    int i = 0;
    if (solid && objRoom == currentRoom) {
      while (i < myObjects.size()) {
        GameObject myObj = myObjects.get(i);
        
        if (myObj instanceof Bullet) {
          if (dist(myObj.loc.x, myObj.loc.y, loc.x, loc.y) <= sizeX/2 + myObj.sizeX/2) {
            hit(myHero.myWeapon.attackDamage);
                      
            //Outright removes bullet to skip death anim (don't want anims to overlap)
            myObj.hp = 0;
            
          }
        } else if (dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y) <= sizeX/2 + myHero.sizeX/2) {
          myHero.hit(attackDamage);
        }
        
        i++;
      }
    }
    
    loc.add(vel);
    
    if (solid == false) {
      if (loc.x < (width - currentRoom.sx)/2 + sizeX/2) {
        vel.set(0, 0);
        loc.x = (width - currentRoom.sx)/2 + sizeX/2;
      }
      
      if (loc.x > width/2 + currentRoom.sx/2 - sizeX/2) {
        vel.set(0, 0);
        loc.x = width/2 + currentRoom.sx/2 - sizeX/2;
      }
      
      if (loc.y < (height - currentRoom.sy)/2 + sizeY/2) {
        vel.set(0, 0);
        loc.y = (height - currentRoom.sy)/2 + sizeY/2;
      }
      
      if (loc.y > height/2 + currentRoom.sy/2 - sizeY/2) {
        vel.set(0, 0);
        loc.y = height/2 + currentRoom.sy/2 - sizeY/2;
      }
    }
    
    invTimer++;
    
    //Makes everything explode when you die
    if (!(this instanceof Splash) && !(this instanceof HealthPoint)) {
      if (myHero.hp <= 0) hp = 0;
    }
  }
  
  void hit (float ad) {
    if (invTimer > invTimeLimit) {
      hp -= ad;
      invTimer = 0;
    }
  }
  
}
