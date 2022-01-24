//Subclass of the melee unit; is much smaller, can only move in light, does less damage, and is much faster
class Lurker extends MeleeEnemy {
  
  Lurker (float x_, float y_, Room objRoom_) {
    super(x_, y_, objRoom_);
    
    hp = 25;
    
    sizeX = sizeY = 60;
    
    attackDamage = 8;
    
    speed = 4;        
  }
  
  void act () {
    if (dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y) >= myHero.lum) {
      vel.setMag(0);
    }
    
    super.act();
  }
}
