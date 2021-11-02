class Hero extends GameObject {
  
  float speed;
  float speedLimit;
  int roomX, roomY;
  
  //Booleans for turning
  boolean upleft, up, upright, downleft, down, downright, left, right;
  
  //To time death anim
  int deathTime = 0;
  
  Hero () {
    super();
    
    speed = 0.9;
    roomX = 1;
    roomY = 1;
    
    sizeX = 85;
    sizeY = 85;
    
    speedLimit = 7;
    hp = 100;    
  }
  
  public void show () {
    pushMatrix();
    translate(loc.x, loc.y);
    
    //...
    if (upkey && leftkey) {
      upleft = true;
      up = upright = downleft = down = downright = false;
    } else if (upkey && rightkey) {
      upright = true;
      upleft = up = downleft = down = downright = false;
    } else if (downkey && leftkey) {
      downleft = true;
      upleft = up = upright = down = downright = false;
    } else if (downkey && rightkey) {
      downright = true;
      upleft = up = upright = downleft = down = false;
    } else if (upkey) {
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
        
    if (upleft) {
      rotate(3*PI/4);
    } else if (upright) {
      rotate(-3*PI/4);
    } else if (downleft) {
      rotate(PI/4);
    } else if (downright) {
      rotate(-PI/4);
    } else if (up) {
      rotate(PI);
    } else if (left) {
      rotate(PI/2);
    } else if (right) {
      rotate(-PI/2);
    }
    
    noStroke();
    fill(lerp(255, 0, map(hp, 0, 100, 0.85, 0)));
    strokeWeight(8);
    
    ellipse(0, 0, sizeX, sizeY);
        
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
    if (hp > 0) super.act();
    
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
    
    if (mousePressed && hp >= 0) hp--;
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
          myObjects.add(new Splash(loc.x, loc.y, White));
          
          i++;
        }
      }
      
      //Time between death and game over screen
      //amount of time given for particles to spawn + amount of time for particles of dissipate + 20 frame buffer (for player to be able to see empty screen)
      if (frameCount >= deathTime + spawnLimit + Splash.hplimit/Splash.hplossrate + 20) mode = over;
      
    }
  }
  
}
