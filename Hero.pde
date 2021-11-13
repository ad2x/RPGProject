class Hero extends GameObject {
  
  float speed;
  float speedLimit;
  int roomX, roomY;
  
  //Booleans for turning
  boolean upleft, up, upright, downleft, down, downright, left, right;
  
  //For a powerup
  boolean bright;
  
  Weapon myWeapon;
  
  Hero () {
    super(currentRoom);
    
    speed = 0.9;
    roomX = 1;
    roomY = 1;
    
    sizeX = 94;
    sizeY = 94;
    
    speedLimit = 6.5;
    hp = 100;    
    
    myWeapon = new Weapon(20, 12, 15);
    
    invTimeLimit = 60;
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
    
    noStroke();
    
    fill(lerp(0, 255, map(hp, 0, 100, 0.4, 1)));
    if (bright) fill(White);
    
    strokeWeight(8);
    
    //Makes everything else treat the hero's size like it's smaller than it really is in order to make collision account for strokeWeight
    sizeX -= 8;
    sizeY -= 8;
    ellipse(0, 0, sizeX, sizeY);
    sizeX += 8;
    sizeY += 8;
        
    fill(Black);
    
    pushMatrix();
    rotate(PI/5);
    ellipse(-3, 27, 30, 19);
    popMatrix();
    
    pushMatrix();
    rotate(-PI/5);
    ellipse(3, 27, 30, 19);
    popMatrix();
    
    popMatrix();
  }
  
  public void act () {
    //Shooting
    myWeapon.update();
    if (spacekey) myWeapon.shoot();
    
    if (hp > 0) super.act();
    if (hp > 100) hp = 100;
    
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
    
    if (vel.x > speedLimit) {
      vel.x = speedLimit;
    } else if (vel.x < -speedLimit) {
      vel.x = -speedLimit;
    }
    
    if (vel.y > speedLimit) {
      vel.y = speedLimit;
    } else if (vel.y < -speedLimit) {
      vel.y = -speedLimit;
    }
    
    if ((upkey && leftkey) || (upkey && rightkey) || (downkey && leftkey) || (downkey && rightkey)) {
      
      //I realised you could go faster when moving diagonally because you had the combined acceleration of both vertices
      //This just checks if you are moving diagonally, and if so enforces an adjusted speed limit on each vertex
      //The reason why it's that number in particular (0.707107) is because I guessed that it probably had something to do with triangles and threw the pyth. theorum at it
      //The end result of this is that while you technically move equally as fast moving diagonally, the speed limit slows you down if you go back and forth which I like because it encourages you to not spam press buttons
      
      if (vel.x > speedLimit*0.707107) {
        vel.x = speedLimit*0.707107;
      } else if (vel.x < -speedLimit*0.707107) {
        vel.x = -speedLimit*0.707107;
      }
      
      if (vel.y > speedLimit*0.707107) {
        vel.y = speedLimit*0.707107;
      } else if (vel.y < -speedLimit*0.707107) {
        vel.y = -speedLimit*0.707107;
      }
    }
    //=====================
    
    //== Collision ==
    
    int i = 0;
    while (i < myObjects.size()) {
      GameObject myObj = myObjects.get(i);
      
      if (!(myObj instanceof Bullet) && !(myObj instanceof HealthPoint) && !(myObj instanceof Splash)) {
        if (dist(myHero.loc.x, myHero.loc.y, myObj.loc.x, myObj.loc.y) <= myHero.sizeX/2 - 10 + myObj.sizeX/2) {
          float temp = vel.mag();
          vel.set(myObj.loc.x - myHero.loc.x, myObj.loc.y - myHero.loc.y);
          vel.setMag(temp);
          vel.setMag(-1);
        }
      }
      
      i++;
    }
    
    //===============
    
    ////Testing
    if (mousePressed && hp >= 0) hp--;
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
  
}
