void playing () {
  //Roll floor type
  if (ftype == 0) typeroll();
  
  background(Black);
    
  currentRoom.show();
  currentRoom.act();
  
  int i = 0;
  
  while (i < myObjects.size()) {
    GameObject myObj = myObjects.get(i);
    if (myObj instanceof Splash) {
      myObj.show();
      if (paused == false) myObj.act();
    }
    
    i++;
  } 
  
  i = 0; 
  
  while (i < myObjects.size()) {
    GameObject myObj = myObjects.get(i);
    
    if (myObj.objRoom == currentRoom) {
      myObj.show();
      if (paused == false) myObj.act();
    }

    if (myObj.hp <= 0) {
      myObjects.remove(i);
    } else {
      i++;
    }    
  } 
  
  //Didn't add playerChar to the myObjects array because it made things 
  //more difficult and there wasn't really any benefit
  if (paused == false) myHero.act();
  if (myHero.hp > 0) myHero.show();
  
  i = 0;
  while (i < myCells.size()) {
    DarknessCell myC = myCells.get(i);
    myC.show();
    i++;
  }
  
  myHero.deathAnim();
  
  if (tmap && upgrscr == false) {
    i = 0;
    while (i < mapCells.size()) {
      MapCell myCell = mapCells.get(i);
      
      myCell.discovery();
      myCell.show();
      
      i++;
    }
    
    myHp.show(125, 225);
  }  
  
  if (upgrscr == true) upgradeScreen();
   
  if (paused && upgrscr == false) {
    fill(Black, 250);
    stroke(White, 240);
    
    ellipse(width/2, height/2, 300, 300);
    
    fill(White, 240);
    textSize(45);
    text("Paused", width/2, height/2);
    
    exitButton.show(width/2, 4*height/5);
  }
  
}

//== Upgrade Screen ==
void upgradeScreen () {
  if (upgrscr) {
    fill(Black, 252);
    stroke(White, 240);
    
    rect(width/8, height/8, 6*width/8, 6*height/8);
    
    int i = 0;
    float x = 184;
    while (i < 4) {
      upgradeDamageSq(x, 184, i + 1);
      upgradeHealthSq(x, 184 + 144, i + 1);
      upgradeSpeedSq(x, 184 + 288, i + 1);
      
      x += 144;
      i++;
    }
    
    explainSq(width/2, 184 + 288 + 144);
  }
}
//Ext damage
void upgradeDamageSq (float x, float y, int t) {
  pushMatrix();
  translate(x, y);
  
  if (myHero.extdamage < t) {
    noFill();
  } else {
    fill(NRed3);
  }
  
  strokeWeight(10);
  stroke(White);
  
  rect(-60, -60, 120, 120);
  
  textSize(65);
  fill(White);
  
  if (t == 1) {
    text("I", 0, -10);
  } else if (t == 2) {
    text("II", 0, -10);
  } else if (t == 3) {
    text("III", 0, -10);
  } else {
    text("IV", 0, -10); 
  }
  
  if (ftype == 2) line(-60, -60, 60, 60);
  
  popMatrix();
}

//Ext health
void upgradeHealthSq (float x, float y, int t) {
  pushMatrix();
  translate(x, y);
  
  if (myHero.exthp < t) {
    noFill();
  } else {
    fill(NGreen3);
  }
      
  strokeWeight(10);
  stroke(White);
  
  rect(-60, -60, 120, 120);
  
  textSize(65);
  fill(White);
  
  if (t == 1) {
    text("I", 0, -10);
  } else if (t == 2) {
    text("II", 0, -10);
  } else if (t == 3) {
    text("III", 0, -10);
  } else {
    text("IV", 0, -10); 
  }
  
  if (ftype == 3) line(-60, -60, 60, 60);
  
  popMatrix();
}

//Ext speed
void upgradeSpeedSq (float x, float y, int t) {
  pushMatrix();
  translate(x, y);
  
  if (myHero.extspeed < t) {
    noFill();
  } else {
    fill(NBlue3);
  }
    
  strokeWeight(10);
  stroke(White);
  
  rect(-60, -60, 120, 120);
  
  textSize(65);
  fill(White);
  
  if (t == 1) {
    text("I", 0, -10);
  } else if (t == 2) {
    text("II", 0, -10);
  } else if (t == 3) {
    text("III", 0, -10);
  } else {
    text("IV", 0, -10); 
  }
  
  if (ftype == 1) line(-60, -60, 60, 60);
  
  popMatrix();
}

//Explanation 
void explainSq (float x, float y) {
  pushMatrix();
  translate(x, y);
  
  noFill();
  stroke(White);
  strokeWeight(10);
  
  rect(-276, -60, 552, 120);
  
  textSize(20);
  
  fill(NRed3);
  text("Damage", -150, 0);
  
  fill(NGreen3);
  text("Health", 0, 0);
  
  fill(NBlue3);
  text("Speed", 150, 0);
  
  popMatrix();
}

//== Determine Floor Type ==
void typeroll () {
  int rand = (int) random(0, 3);
  if (rand > 2) {
    ftype = 1;
  } else if (rand > 1) {
    ftype = 2;
  } else {
    ftype = 3;
  }
}
