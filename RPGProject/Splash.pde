class Splash extends GameObject {
  //This class is for "splash" effects - not really sure how to describe them
  //Includes things like deathe effect and bullets hitting walls
  
  float direction;
  
  //Shape of the splash particles
  int type;
  static final int circle = 0;
  static final int triangle = 1;
  static final int square = 2;
  
  //Spin while moving
  float angle;
  
  //Hp/time taken to dissapear
  static final int hplimit = 30;
  static final float hplossrate = 0.5;
  
  float hploss;
  
  //Colour
  color c;
  
  Splash (float x, float y, color c_, boolean pt) {
    passthrough = pt;
    
    //Randomizes shape
    type = (int) random(0, 3);
    
    //Random size
    sizeX = sizeY = random(8, 14);
    
    //Sets initial hp to the maximum hp (needed to keep variables seperate for calculating timing)
    //Subtracts a random amount from max hp and increases hplossrate by a random amount in order to provide variance in the animation 
    //(otherwise all of the particles would die at teh exact same time at the exact same distance)
    hp = hplimit - (int) random(0, 20);
    hploss = hplossrate + random(0, 0.5);
    
    loc = new PVector (x, y);
    vel = new PVector (random(-10, 10) + 1, random(-10, 10) + 1);
    vel.setMag(2);
    
    c = c_;
  }
  
  //If I want to force shape, for bullets
  Splash (int type_, float x, float y, color c_, boolean pt) {
    passthrough = pt;
    
    //Randomizes shape
    type = type_;
    
    //Random size
    sizeX = sizeY = random(8, 11);
    
    //Sets initial hp to the maximum hp (needed to keep variables seperate for calculating timing)
    hp = hplimit - (int) random(0, 20);
    hploss = hplossrate + random(0.5, 1);
    
    loc = new PVector (x, y);
    vel = new PVector (random(-5, 10) + 1, random(-5, 10) + 1);
    vel.setMag(3);
    
    c = c_;
  }
  
  public void show () {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(angle);
    
    noStroke();
    fill(c, map(hp, 0, 30, 0, 255));
    
    if (type == circle) {
      ellipse(0, 0, sizeY, sizeX);
    } else if (type == triangle) {
      //Used triangle code from https://stackoverflow.com/questions/11449856/draw-a-equilateral-triangle-given-the-center/11479662
      float cx = 0;
      float cy = -sizeY/2;
      
      float bx = cx*cos(radians(120)) - cy*sin(radians(120));
      float by = cx*sin(radians(120)) + cy*cos(radians(120));
      
      float ax = cx*cos(radians(240)) - cy*sin(radians(240));
      float ay = cx*sin(radians(240)) + cy*cos(radians(240));
      
      triangle(ax, ay, bx, by, cx, cy);
    } else if (type == square) {
      rect(-sizeX/2, -sizeY/2, sizeX, sizeY);
    }
    
    popMatrix();
  }
  
  public void act () {
    super.act();
    
    angle += 0.35;
    hp -= hploss;
  }
}
