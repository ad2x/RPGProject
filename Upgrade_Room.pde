//Room with a lamp in each corner and an upgrade point orb in the center
class UpgradeRoom extends Room {
  
  float rand = 0;
  
  UpgradeRoom (int roomX, int roomY) {
    super(roomX, roomY);
    
    color c;
    
    //Generates room based on floor type
    //1 - RG
    //2 - GB
    //3 - RB
    if (ftype == 1) {
      if (boolRand()) {
        c = NRed6;
      } else {
        c = NGreen6;
      }
    } else if (ftype == 2) {
      if (boolRand()) {
        c = NGreen6;
      } else {
        c = NBlue6;
      }
    } else {
      if (boolRand()) {
        c = NRed6;
      } else {
        c = NBlue6;
      }
    }
    
    myObjects.add(new Lamp(150, 150, c, this));
    myObjects.add(new Lamp(150, 650, c, this));
    myObjects.add(new Lamp(650, 150, c, this));
    myObjects.add(new Lamp(650, 650, c, this));
    
    myObjects.add(new UpgradeOrb(width/2, height/2, c, this));
    
    myObjects.add(new Pedestal(width/2, height/2, this));
  }
}
