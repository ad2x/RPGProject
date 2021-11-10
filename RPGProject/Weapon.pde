class Weapon {
  
  int shotTimer;
  int threshold;
  int bulletSpeed;
  
  Weapon() {
    shotTimer = 0;
    threshold = 30;
    bulletSpeed = 5;
  }
  
  Weapon(int thr, int ps) {
    shotTimer = 0;
    threshold = thr;
    bulletSpeed = ps;
  }
  
  void update() {
    shotTimer++;
  }
  
  void shoot() {
    if (shotTimer >= threshold) {
      PVector aimVector;
      
      //I put everything into each if statement because otherwise it would say aimVector was uninitialized even though I literally just initialized it so rather than figure out what I was missing I just did this
      if (myHero.up) {
        aimVector = new PVector (0, -1);
        aimVector.setMag(bulletSpeed);
        myObjects.add(new Bullet(aimVector.x, aimVector.y, myHero.loc.x, myHero.loc.y, White, 18));
      } else if (myHero.left) {
        aimVector = new PVector (-1, 0);
        aimVector.setMag(bulletSpeed);
        myObjects.add(new Bullet(aimVector.x, aimVector.y, myHero.loc.x, myHero.loc.y, White, 18));
      } else if (myHero.right) {
        aimVector = new PVector (1, 0);
        aimVector.setMag(bulletSpeed);
        myObjects.add(new Bullet(aimVector.x, aimVector.y, myHero.loc.x, myHero.loc.y, White, 18));
      } else {
        aimVector = new PVector (0, 1);
        aimVector.setMag(bulletSpeed);
        myObjects.add(new Bullet(aimVector.x, aimVector.y, myHero.loc.x, myHero.loc.y, White, 18));
      }
      
      shotTimer = 0;
    }
  }
}
