class Lamp extends GameObject {   
  //Used for making light shift in intensity, don't really know what to call the effect
  int target = 225;
  float intensity = 225;
  
  int type;
  color c;
  
  Lamp (float x_, float y_, color c_, Room objRoom_) {
    super(objRoom_);
    
    type = c_;
    
    switch (type) {
      case 1:
        lumColor = 0;
        c = Red;
        break;
      case 2:
        lumColor = 85;
        c = Green;
        break;
      case 3:
        lumColor = 170;
        c = Blue;
        break;
    }
            
    solid = true;
    
    loc = new PVector(x_, y_);
    
    sizeX = sizeY = 100;
    
    lum = 180;
    
    solid = true;
  }
  
  void show() {
    noStroke();

    fill(lumColor, 255, 255, intensity);
        
    ellipse(loc.x, loc.y, sizeX, sizeY);
    
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
    
    ellipse(loc.x, loc.y, sizeX*0.75, sizeY*0.75);
  }
  
  void hit (float ad) {
    super.hit(ad);
    
    hp += ad;
  }
}
