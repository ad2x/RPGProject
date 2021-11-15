//Made a class to store score details
class Score {
  
  int totalKills = 0;
  int killPoints = 0;
  
  int totalUpgrades = 0;
  int upgradePoints = 0;
  
  int roomsEntered = 0;
  int roomPoints = 0;
  
  Score () {
    
  }
  
  //Calc total score
  int getTotal () {
    return killPoints + upgradePoints + roomPoints;
  }
  
  //Add commands
  void killedEnemy (int enemyScore) {
    totalKills++;
    killPoints += enemyScore;
  }
  
  void gotUpgrade (int upgradeScore) {
    totalUpgrades++;
    upgradePoints += upgradeScore;
  }
  
  void enterRoom (int roomScore) {
    roomsEntered++;
    roomPoints += roomScore;
  }
  
  
}
