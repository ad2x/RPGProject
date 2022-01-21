class Lamp extends GameObject { 
  color c;
  
  //Used for making light shift in intensity, don't really know what to call the effect
  int target = 225;
  float intensity = 225;
  
  Lamp (float x_, float y_, color c_, Room objRoom_) {
    super(objRoom_);
    
    c = c_;
        
    solid = true;
    
    loc = new PVector(x_, y_);
    
    sizeX = sizeY = 100;
    
    lum = 180;
    
    solid = true;
    
    //Makes things easier with darknesscell calcs
    if (c == NRed6) {
      hp = 77777;
    } else if (c == NGreen6) {
      hp = 88888;
    } else {
      hp = 99999;
    }
  }
  
  void show() {
    noStroke();

    fill(c, intensity);
        
    ellipse(loc.x, loc.y, 100, 100);
    
    //If current brightness (intensity) is higher than the target it goes down, if not it goes up
    if (intensity == target) {
      target = (int) random(170, 255);
      if (target%2 != 0) target -= 1;
    } else if (paused == false) {
      if (intensity > target) {
        intensity -= 1;
      } else {
        intensity += 1;
      }
    }
    
    //Changes luminosity based on intensity
    lum = map(intensity, 170, 255, 165, 205);
    
    fill(#050505);
    
    ellipse(loc.x, loc.y, 75, 75);
  }
  
  void hit (float ad) {
    super.hit(ad);
    
    hp += ad;
  }
}
