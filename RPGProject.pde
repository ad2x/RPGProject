import processing.javafx.*;

//== Arrays ==
ArrayList<GameObject> myObjects;
ArrayList<DarknessCell> myCells;
ArrayList<MapCell> mapCells;
//I will never confuse these ^^^
ArrayList<Room> myRooms;

//== Keyboard ==
boolean upkey, downkey, leftkey, rightkey, spacekey, ekey, qkey, esckey;

//== Colour Pallette ==
//-- Black & White --
color NRed1 = #a60000;
color NRed2 = #bd0000;
color NRed3 = #cb0000;
color NRed4 = #e20000;
color NRed5 = #ff5b5b;

color NGreen1 = #174c19;
color NGreen2 = #1f6522;
color NGreen3 = #277f2a;
color NGreen4 = #2f9832;
color NGreen5 = #3eca43;


color NBlue1 = #1f1f66;
color NBlue2 = #272780;
color NBlue3 = #2e2e99;
color NBlue4 = #3e3ecc;
color NBlue5 = #4d4dff;

color Black = #000000;
color White = #FFFFFF;
color Red = #FF0000;
color Green = #00FF00;
color Blue = #0000FF;
color MGreen = #e1ad01;
color Gold = #FFD700;

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

//Floor type (RG - 1, GB - 2, RB - 3)
int ftype;

//Darkness Cells
float dcx;
float dcy;
float dcs = 5;

//Map toggle
boolean tmap = true;

//Upgrade toggle
boolean upgrscr = false;

//Hp Bar
HpBar myHp;

//Pause
boolean paused;

//Button
ModeButton exitButton;

//-- Upgrade Select --

//-- Save Select --

//-- Game Over -- 

void setup() {
  size(800, 800, FX2D);
  
  colorMode(HSB);
  
  myObjects = new ArrayList<GameObject>();
  myCells = new ArrayList<DarknessCell>();
  mapCells = new ArrayList<MapCell>();
  myRooms = new ArrayList<Room>();
  
  //-- General --
  
  menuFont = createFont("fonts/conthrax.ttf", 75);
  
  titleFont = createFont("fonts/origintech.ttf", 150);
  
  //-- Start -- 
  
  startButton = new ModeButton("Start", 55, main, Black, White, 220, 15);
  
  //-- Main --
  
  playButton = new ModeButton("Play", 90, playing, Black, White, width - 100, height/2 - 75, 15, Red);
  
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
  
  saveselButton = new ModeButton("Save Select", 35, savesel, Black, White, width/2 - 75, height/2 - 75, 15, Blue);
  upgradeselButton = new ModeButton("Upgrades", 35, upgradesel, Black, White, width/2 - 75, height/2 - 75, 15, Green);

  //-- Playing --
  
  //Map
  map = loadImage("maps/colorMap.png");
  
  myHero = new Hero(); 
  
  currentRoom = new StartingRoom(myHero.roomX, myHero.roomY);
  //currentRoom = new UpgradeRoom(myHero.roomX, myHero.roomY);
  myRooms.add(currentRoom);
    
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
    if (mx >= map.width) {
      dcx = 0;
      dcy += dcs;
      mx = 0;
      my++;
    }
  }
  
  myHp = new HpBar(150, 25);
  
  //Exit button
  exitButton = new ModeButton("Exit", 25, main, Black, White, 100, 8);
  
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
    
    if (paused && !upgrscr) exitButton.click();
    
  } else if (mode == upgradesel) {
    
    
    
  } else if (mode == savesel) {
    
    
    
  } else if (mode == over) {
    
    
    
  }
}

void keyPressed() {
  if (paused && keyCode != 27 && key != 'Q') key = 0;
  if (key == 'W' || keyCode == UP) upkey = true;
  if (key == 'S' || keyCode == DOWN) downkey = true;
  if (key == 'A' || keyCode == LEFT) leftkey = true;
  if (key == 'D' || keyCode == RIGHT) rightkey = true;
  if (key == ' ') spacekey = true;
  if (keyCode == 27) {
    key = 0;
    esckey = true;
    if (upgrscr == false) paused = !paused;
  }
  if (key == 'E') {
    ekey = true;
    esckey = !esckey;
  }
  if (key == 'Q') {
    qkey = true;
    upgrscr = !upgrscr;
    paused = !paused;
  }
}

void keyReleased() {
  if (key == 'W' || keyCode == UP) upkey = false;
  if (key == 'S' || keyCode == DOWN) downkey = false;
  if (key == 'A' || keyCode == LEFT) leftkey = false;
  if (key == 'D' || keyCode == RIGHT) rightkey = false;
  if (key == ' ') {
    spacekey = false;
  }
  if (keyCode == 27) {
    key = 0;
    esckey = false;
  }
  if (key == 'E') {
    ekey = false;
    tmap = !tmap;
  }
  if (key == 'Q') {
    qkey = false;
  }
}

//== Random Function ==
//Didn't really belong anywhere in particular so I put it here
boolean boolRand () {
  int rand = (int) random(0, 2);
  
  if (rand == 0) {
    return true;
  } else {
    return false;
  }
}

//== Radius of Light Circle ==
//Made it outside of the DarknessCell class so it could be used anywhere I needed
float darknessDist () {
  return map(myHero.hp, myHero.maxhp, 0, 175, 90);
}

//== Mix Colours ==
//Function for mixing colours
color mixColor(color a_, color b_, float ratio) {
  float a = hue(a_);
  float b = hue(b_);
    
  if (a == b) return color(a, 255, 255);
  
    
  
  //Stumped me for a while, turns out processing inexplicably treats hue as being from 0-255 rather than 0-360
  if (a > b + 255/2 || b > a + 255/2) {
    if (a > b + 255/2) {
      float th = (255 - a - b) * ratio + a;
      
      return color(th, 255, 255);
    } else if (b > a + 255/2) {
      float th = (255 - a - b) * ratio + b;
      
      return color(th, 255, 255);
    }
  }
  
  if (a > b) return color((a - b) * ratio + b, 255, 255);
  if (b > a) return color((b - a) * ratio + a, 255, 255);
  
  return Black;
}  

float mixColorFloat(float a_, float b_, float ratio) {
  float a = a_;
  float b = b_;
  
  if (a == b) return a;
  
  if (a > b + 127.5 || b > a + 127.5) {
    if (a > b + 127.5) {
      float th = (255 - a - b) * ratio + a;
      
      return th;
    } else if (b > a + 127.5) {
      float th = (255 - a - b) * ratio + b;
      
      return th;
    }
  }
  
  if (a > b) return (a - b) * ratio + b;
  if (b > a) return (b - a) * ratio + b;
  
  return 0;
}
