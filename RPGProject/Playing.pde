void playing () {
  background(Black);
  
  currentRoom.show();
  currentRoom.act();
  
  //Didn't add playerChar to the myObjects array because it made things 
  //more difficult and there wasn't really any benefit
  myHero.act();
  if (myHero.hp > 0) myHero.show();
  
  int i = 0;
  while (i < myObjects.size()) {
    GameObject myObj = myObjects.get(i);
    myObj.show();
    myObj.act();

    if (myObj.hp <= 0) {
      myObjects.remove(i);
    } else {
      i++;
    }    
  } 
  
  i = 0;
  while (i < myCells.size()) {
    DarknessCell myC = myCells.get(i);
    myC.show();
    i++;
  }
  
  myHero.deathAnim();
  
  i = 0;
  while (i < myObjects.size()) {
    GameObject myObj = myObjects.get(i);
    if (myObj instanceof Splash) {
      myObj.show();
      myObj.act();
    }
    
    i++;
  } 
  
  i = 0;
  while (i < mapCells.size()) {
    MapCell myCell = mapCells.get(i);
    myCell.show();
    
    i++;
  }
}
