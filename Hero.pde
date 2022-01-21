class Hero extends GameObject {
  
  float speed;
  float speedLimit;
  int roomX, roomY;
  
  //Booleans for turning
  boolean upleft, up, upright, downleft, down, downright, left, right;
  
  Weapon myWeapon;
  
  //Overall score
  Score myScore;
  
  //== Hero Upgrades ==
  //Hp
  int exthp = 0;
  int basehp = 50;
  int maxhp = basehp + exthp*10;
  //Speed
  int extspeed = 0;
  //Damage
  int extdamage = 0;
  
  //Upgrade points (to spend for upgrades)
  int upgradePoints;
  
  Hero () {
    super(currentRoom);
    
    myScore = new Score();
    
    speed = 0.9;
    roomX = 1;
    roomY = 1;
    
    sizeX = 94;
    sizeY = 94;
    
    speedLimit = 6.5;
    hp = maxhp;    
    
    myWeapon = new Weapon(20, 12, 15);
    
    invTimeLimit = 60;
    
    lum = 200;
  }
  
  public void show () {
    pushMatrix();
    translate(loc.x, loc.y);
    
    //...
    if (upkey) {
      up = true;
      upleft = upright = downleft = down = downright = false;
    } else if (leftkey) {
      left = true;
      upleft = up = upright = downleft = down = downright = right = false;
    } else if (rightkey) {
      right = true;
      upleft = up = upright = downleft = down = downright = left = false;
    } else if (downkey) {
      down = true;
      upleft = up = upright = downleft = downright = left = right = false; 
    }
        
    if (up) {
      rotate(PI);
    } else if (left) {
      rotate(PI/2);
    } else if (right) {
      rotate(-PI/2);
    }
    
    //Changes stroke colour the more hp you have
    //stroke(lerp(White, NGreen6, map(exthp, 0, 4, 0, 1)));
    stroke(NGreen6, map(exthp, 0, 4, 0, 200));
    fill(lerp(0, 255, map(hp, 0, maxhp, 0.4, 1)));
    
    sizeX = sizeY = map(exthp, 0, 4, 94, 110);
    
    int strokeSize = 8;
    
    strokeWeight(strokeSize);
    
    //Makes everything else treat the hero's size like it's smaller than it really is in order to make collision account for strokeWeight
    sizeX -= strokeSize;
    sizeY -= strokeSize;
    ellipse(0, 0, sizeX, sizeY);
    sizeX += strokeSize;
    sizeY += strokeSize;
        
    fill(Black);
    
    float exthp_ = map(exthp, 0, 4, 1, 1.15);
    
    noStroke();
    
    pushMatrix();
    rotate(PI/5);
    ellipse(-3*exthp_, 27*exthp_, 30*exthp_, 19*exthp_);
    popMatrix();
    
    pushMatrix();
    rotate(-PI/5);
    ellipse(3*exthp_, 27*exthp_, 30*exthp_, 19*exthp_);
    popMatrix();
    
    popMatrix();
  }
  
  public void act () {
    //Shooting
    myWeapon.update();
    if (spacekey) myWeapon.shoot();
    
    //Hp stuff
    if (hp > 0) super.act();
    if (hp > maxhp) hp = maxhp;
    maxhp = basehp + exthp * 10;
    
    //Don't allow upgrades to go over limit
    if (extdamage > 4) extdamage = 4;
    if (exthp > 4) exthp = 4;
    if (extspeed > 4) extspeed = 4;
    
    //====== Movement ======
    if (upkey) {
      vel.y -= speed;
    }
    
    if (downkey) {
      vel.y += speed;
    }
    
    if (leftkey) {
      vel.x -= speed;
    }
    
    if (rightkey) {
      vel.x += speed;
    }
    
    if (upkey == false && downkey == false) {
      vel.y /= 1.1;
    }
    
    if (leftkey == false && rightkey == false) {
      vel.x /= 1.1;
    }
    
    //Changes speed limit based on speed bonus
    float speedLimit_ = speedLimit + 0.6*extspeed;
    
    if (vel.x > speedLimit_) {
      vel.x = speedLimit_;
    } else if (vel.x < -speedLimit_) {
      vel.x = -speedLimit_;
    }
    
    if (vel.y > speedLimit_) {
      vel.y = speedLimit_;
    } else if (vel.y < -speedLimit_) {
      vel.y = -speedLimit_;
    }
    
    if ((upkey && leftkey) || (upkey && rightkey) || (downkey && leftkey) || (downkey && rightkey)) {
      
      //I realised you could go faster when moving diagonally because you had the combined acceleration of both vertices
      //This just checks if you are moving diagonally, and if so enforces an adjusted speed limit on each vertex
      //The reason why it's that number in particular (0.707107) is because I guessed that it probably had something to do with triangles and threw the pyth. theorum at it
      //The end result of this is that while you technically move equally as fast moving diagonally, the speed limit slows you down if you go back and forth which I like because it encourages you to not spam press buttons
      
      if (vel.x > speedLimit_*0.707107) {
        vel.x = speedLimit_*0.707107;
      } else if (vel.x < -speedLimit_*0.707107) {
        vel.x = -speedLimit_*0.707107;
      }
      
      if (vel.y > speedLimit_*0.707107) {
        vel.y = speedLimit_*0.707107;
      } else if (vel.y < -speedLimit_*0.707107) {
        vel.y = -speedLimit_*0.707107;
      }
    }
    
    //== Trail ==
    //Leaves trail if player is fast enough
    if (extspeed != 0 && (vel.x > 3 || vel.x < -3 || vel.y > 3 || vel.y < -3)) {
      //Create more particles the faster you are
      int rate = (int) map(extspeed, 0, 4, 35, 5);
      if (frameCount % rate == 0) {
        myObjects.add(new Splash(Splash.square, loc.x, loc.y, NBlue6, false, 12, 18, 0));
        myObjects.add(new Splash(Splash.square, loc.x, loc.y, NBlue6, false, 12, 18, 0));
        myObjects.add(new Splash(Splash.square, loc.x, loc.y, NBlue6, false, 12, 18, 0));
      }
    }
    
    //=====================
    
    //== Collision ==
    
    int i = 0;
    while (i < myObjects.size()) {
      GameObject myObj = myObjects.get(i);
      
      if (myObj.solid == true && myObj.objRoom == currentRoom) {
        if (dist(myHero.loc.x, myHero.loc.y, myObj.loc.x, myObj.loc.y) <= myHero.sizeX/2 - 10 + myObj.sizeX/2) {
          vel.set(myObj.loc.x - myHero.loc.x, myObj.loc.y - myHero.loc.y);
          vel.setMag(-1);
        }
      }
      
      i++;
    }
    
    //===============
    
    ////Testing
    //if (mousePressed && hp >= 0) hp--;
    //if (spacekey) {
    //  bright = true;
    //} else {
    //  bright = false;
    //}
  }
  
  void deathAnim() {
    if (hp <= 0) {
      
      if (deathTime == 0) {
        deathTime = frameCount;
      }
      
      //Amount of frames given to spawn particles
      int spawnLimit = 10;
      
      if (frameCount <= deathTime + spawnLimit) {
        int i = 0;
        
        //# determines density of particles
        while (i < 15) {
          myObjects.add(new Splash(loc.x, loc.y, White, false));
          
          i++;
        }
      }
      
      //Time between death and game over screen
      //amount of time given for particles to spawn + amount of time for particles of dissipate + 20 frame buffer (for player to be able to see empty screen)
      if (frameCount >= deathTime + spawnLimit + Splash.hplimit/Splash.hplossrate + 20) mode = over;      
    }
  }
  
  public void increaseHp(int n) {
    exthp += n;
  }
}
