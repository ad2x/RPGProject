class ModeButton extends Button {
  
  //Mode the button goes to
  int emode;
  
  //Buttons without seperate hover colours
  ModeButton(String text_, int textSize_, int emode_, color inner_, color outer_, float sx_, float sy_, float sw_) {
    text = text_;
    textSize = textSize_;
    sx = sx_;
    sy = sy_;
    sw = sw_;
    shape = false;
    emode = emode_;
    inner = inner_;
    outer = outer_; 
    hover = outer;
  }
  
  ModeButton(String text_, int textSize_, int emode_, color inner_, color outer_, float sx_, float sw_) {
    text = text_;
    textSize = textSize_;
    sx = sx_;
    sw = sw_;
    shape = true;
    emode = emode_;
    inner = inner_;
    outer = outer_;
    hover = outer;
  }
  
  //Buttons with seperate hover colours
  ModeButton(String text_, int textSize_, int emode_, color inner_, color outer_, float sx_, float sy_, float sw_, color hover_) {
    text = text_;
    textSize = textSize_;
    sx = sx_;
    sy = sy_;
    sw = sw_;
    shape = false;
    emode = emode_;
    inner = inner_;
    outer = outer_; 
    hover = hover_;
  }
  
  ModeButton(String text_, int textSize_, int emode_, color inner_, color outer_, float sx_, float sw_, color hover_) {
    text = text_;
    textSize = textSize_;
    sx = sx_;
    sw = sw_;
    shape = true;
    emode = emode_;
    inner = inner_;
    outer = outer_;
    hover = hover_;
  }
  
  public void show (float x_, float y_) {
    x = x_;
    y = y_; //<>//
    
    super.show();
  }
  
  public void click () {
    if (shape == true && dist(mouseX, mouseY, x, y) <= sx/2) {
      mode = emode;
    }
    if (shape == false && mouseX >= x-sx/2 && mouseX <= x+sx/2 && mouseY >= y-sy/2 && mouseY <= y+sy/2) {
      mode = emode;
    }
  }
}
