class Button {
  
  //Almost-fully universal button class
  //I managed to make it automatically determine mouse hover and pressed colours based on input colours
  
  //Size and strokeweight
  float sx, sy, sw;
  //Circle vs square (true for circle false for square)
  boolean shape;
  //Button text
  int font;
  //Button colour
  color inner, outer;
  //Text
  String text;
  int textSize;
  
  float x, y;
  
  //Seperate outer hover color 
  color hover;
  
  public void show () {
    pushMatrix(); //<>//
    translate(x, y);
    
    fill(inner); //<>//
    stroke(outer);
    strokeWeight(sw);
        
    //Blends inner and outer to make new hovered and pressed colours without having to seperately add them
    //I spent so much time trying to figure out how to do this with blendColor() before realizing lerpColor did what I thought blendColor() was supposed to do -_-
    
    if (shape == true) { //<>//
      if (dist(mouseX, mouseY, x, y) <= sx/2) {
        stroke(lerpColor(hover, Black, 0.2));
        fill(lerpColor(inner, Black, 0.2));
        if (mousePressed) {
          stroke(lerpColor(hover, Black, 0.4));
          fill(lerpColor(inner, Black, 0.4));
        }
      }
      ellipse(0, 0, sx, sx);
    } else if (shape == false) {
      if (mouseX >= x-sx/2 && mouseX <= x+sx/2 && mouseY >= y-sy/2 && mouseY <= y+sy/2) {
        stroke(lerpColor(hover, Black, 0.2));
        fill(lerpColor(inner, Black, 0.2));
        if (mousePressed) {
          stroke(lerpColor(hover, Black, 0.4));
          fill(lerpColor(inner, Black, 0.4));
        }
      }
      rect(-sx/2, -sy/2, sx, sy);
    }
    
    fill(outer);
    
    if (shape == true) {
      if (dist(mouseX, mouseY, x, y) <= sx/2) {
        fill(lerpColor(hover, Black, 0.1));
        if (mousePressed) {
          fill(lerpColor(hover, Black, 0.3));
        }
      }
    } else if (shape == false) {
      if (mouseX >= x-sx/2 && mouseX <= x+sx/2 && mouseY >= y-sy/2 && mouseY <= y+sy/2) {
        fill(lerpColor(hover, Black, 0.2));
        if (mousePressed) {
          fill(lerpColor(hover, Black, 0.4));
        }
      }
    }
    
    textFont(menuFont);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, 0, 0);
    
    popMatrix();
  }
  
  public boolean pressed () {
    if (shape == true && shape == true && dist(mouseX, mouseY, x, y) <= sx/2) {
      return true;
    } else if (shape == false && shape == false && mouseX >= x-sx/2 && mouseX <= x+sx/2 && mouseY >= y-sy/2 && mouseY <= y+sy/2) {
      return true;
    } else {
      return false;
    }
  }
}
