
import processing.javafx.*;

//== Arrays ==
ArrayList<GameObject> myObjects;
ArrayList<DarknessCell> myCells;
ArrayList<MapCell> mapCells;
//I will never confuse these ^^^

//== Keyboard ==
boolean upkey, downkey, leftkey, rightkey, spacekey;

//== Colour Pallette ==
//-- Black & White --
color NRed1 = #a60000;
color NRed2 = #bd0000;
color NRed3 = #cb0000;
color NRed4 = #e20000;
color NRed5 = #ff5b5b;
color NRed6 = #FF0000;

color NGreen1 = #174c19;
color NGreen2 = #1f6522;
color NGreen3 = #277f2a;
color NGreen4 = #2f9832;
color NGreen5 = #3eca43;
color NGreen6 = #00FF00;

color NBlue1 = #1f1f66;
color NBlue2 = #272780;
color NBlue3 = #2e2e99;
color NBlue4 = #3e3ecc;
color NBlue5 = #4d4dff;
color NBlue6 = #0000FF;

color Black = #000000;
color White = #FFFFFF;

//== Fonts ==
PFont menuFont;
PFont titleFont;

//== Mode Framework == 
int mode = 0;

final int start = 0;
final int main = 1;
final int playing = 2;
final int upgradesel = 3;
final int savesel = 4;
final int over = 5;

//-- Save Vars --

//-- Start --

ModeButton startButton;

//-- Main --

ModeButton playButton;
ModeButton saveselButton;
ModeButton upgradeselButton;

//-- Playing --

//Rooms
Room currentRoom;
PImage map;

Hero myHero;

//Darkness Cells
float dcx;
float dcy;
float dcs = 5;

//-- Upgrade Select --

//-- Save Select --

//-- Game Over -- 

void setup() {
  size(800, 800, FX2D);
  
  myObjects = new ArrayList<GameObject>();
  myCells = new ArrayList<DarknessCell>();
  mapCells = new ArrayList<MapCell>();
  
  //-- General --
  
  menuFont = createFont("fonts/conthrax.ttf", 75);
  
  titleFont = createFont("fonts/origintech.ttf", 150);
  
  //-- Start -- 
  
  startButton = new ModeButton("Start", 55, main, Black, White, 220, 15);
  
  //-- Main --
  
  playButton = new ModeButton("Play", 90, playing, Black, White, width - 100, height/2 - 75, 15, NRed6);
  
  /*
  
    Above is an example of my weird Button constructor for future reference
    
    "Play" -> text
    90 -> textSize
    playing -> end mode
    Black -> inner colour
    White -> outer colour
    width - 100 -> horizontal width
    height/2 - 75 -> vertical width
    15 -> strokeWeight
    NRed4 -> hover colour
  
  */
  
  saveselButton = new ModeButton("Save Select", 35, savesel, Black, White, width/2 - 75, height/2 - 75, 15, NBlue6);
  upgradeselButton = new ModeButton("Upgrades", 35, upgradesel, Black, White, width/2 - 75, height/2 - 75, 15, NGreen6);

  //-- Playing --
  
  //Map
  map = loadImage("maps/testMap.png");
  
  myHero = new Hero(); 
  
  currentRoom = new Room(myHero.roomX, myHero.roomY);
    
  while (dcx != width && dcy != height) {
    while (dcx < height) {
      myCells.add(new DarknessCell(dcx, dcy, dcs));
      dcx += dcs;
    }
    
    dcy += dcs;
    dcx = 0;
  }
  
  int mx = 0;
  int my = 0;
  dcx = dcy = 0;
  dcs = MapCell.size;
  //Reusing some darkness cells variables
  while (my < map.height) {
    mapCells.add(new MapCell(mx, my, dcx, dcy));
    mx++;
    dcx += dcs;
    println(dcx, dcy);
    if (mx >= map.width) {
      dcx = 0;
      dcy += dcs;
      mx = 0;
      my++;
    }
  }
  
  
  //-- Upgrade Select --
  
  //-- Save Select --
  
  //-- Game Over -- 
  
}

void draw() {
  switch (mode) {
    case start:
      start();
      break;
    case main:
      main();
      break;
    case playing:
      playing();
      break;
    case upgradesel:
      upgradesel();
      break;
    case savesel:
      savesel();
      break;
    case over:
      over();
      break;
  }
}

void mousePressed () {
  if (mode == start) {
    
    
    
  } else if (mode == main) {
    
    
    
  } else if (mode == playing) {
    
    
    
  } else if (mode == upgradesel) {
    
    
    
  } else if (mode == savesel) {
    
    
    
  } else if (mode == over) {
    
    
    
  }
}

void mouseReleased () {
  if (mode == start) {
    
    startButton.click();
    
  } else if (mode == main) {
    
    playButton.click();
    saveselButton.click();
    upgradeselButton.click();
    
  } else if (mode == playing) {
    
    
    
  } else if (mode == upgradesel) {
    
    
    
  } else if (mode == savesel) {
    
    
    
  } else if (mode == over) {
    
    
    
  }
}

void keyPressed() {
  if (key == 'W' || keyCode == UP) upkey = true;
  if (key == 'S' || keyCode == DOWN) downkey = true;
  if (key == 'A' || keyCode == LEFT) leftkey = true;
  if (key == 'D' || keyCode == RIGHT) rightkey = true;
  if (key == ' ') spacekey = true;
  if (keyCode == 27) {
    key = 0;
  } else if (keyCode == 27) {
    key = 0;
  }
}

void keyReleased() {
  if (key == 'W' || keyCode == UP) upkey = false;
  if (key == 'S' || keyCode == DOWN) downkey = false;
  if (key == 'A' || keyCode == LEFT) leftkey = false;
  if (key == 'D' || keyCode == RIGHT) rightkey = false;
  if (key == ' ') spacekey = false;
}

//== Random Function ==
//Didn't really belong anywhere in particular so I put it here
boolean boolRandom () {
  int rand = (int) random(0, 2);
  
  if (rand == 0) {
    return true;
  } else {
    return false;
  }
}
