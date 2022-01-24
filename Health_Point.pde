//Little health particles that drop when an enemy is killed
//Move toward player and upon connecting restore hp
class HealthPoint extends GameObject {
  
  //Amount restored
  float restVal;
  
  float speed = 45;
  
  //Boolean for animation
  boolean targetHero = false;
  int targetTimer = 0;
  
  PVector targetEnemy;
  
  float opacity = 0;
  
  HealthPoint (float restVal_, float x, float y) {
    super(currentRoom);
    
    restVal = restVal_;
    
    loc = new PVector(x, y);
    sizeX = sizeY = restVal*10;
    
    //Target within radius of enemy so they are spread out
    targetEnemy = new PVector(loc.x + random(-30, 30), loc.y + random(-30, 30));
  }
  
  void show () {
    stroke(White, opacity);
    fill(Black, opacity);
    strokeWeight(3);
    
    ellipse(loc.x, loc.y, sizeX, sizeY);
  }
  
  void act () {
    super.act();
    
    targetTimer++;
    opacity = map(targetTimer, 15, 30, 0, 255);
    if (targetTimer >= 30) targetHero = true;
    
    if (targetHero == true) {
      vel.x = myHero.loc.x - loc.x;
      vel.y = myHero.loc.y - loc.y;
    } else {
      vel.x = targetEnemy.x - loc.x;
      vel.y = targetEnemy.y - loc.y;
    }
    
    //Moves faster the further it is from the player
    float speedcalc = 0;
    if (targetHero) speedcalc = map(dist(loc.x, loc.y, myHero.loc.x, myHero.loc.y), 0, sqrt(pow(4*width/5, 2) + pow(4*height/5, 2)), 1, speed);
    if (targetHero == false) speedcalc = 2;
    vel.setMag(speedcalc);
    
    if (dist(loc.x, loc.y, myHero.loc.x, myHero.loc.y) <= 30) {
      hp = 0;
      myHero.hp += restVal;
    }
  }
}
