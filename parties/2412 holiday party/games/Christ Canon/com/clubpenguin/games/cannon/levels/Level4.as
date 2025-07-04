class com.clubpenguin.games.cannon.levels.Level4 extends com.clubpenguin.games.cannon.CannonLevel
{
   var sky;
   var ground;
   var startIconX;
   var startIconY;
   var endIconX;
   var endIconY;
   var level1bgArtArraySaved;
   var level1cannonArraySaved;
   var level1obstacleArraySaved;
   var level1puffleOArraySaved;
   function Level4()
   {
      super();
      this.sky = 1;
      this.ground = 1720;
      this.startIconX = 290;
      this.startIconY = 910;
      this.endIconX = -2530;
      this.endIconY = -1370;
      this.buildArrays();
   }
   function buildArrays()
   {
      this.level1bgArtArraySaved = [[1,1140,-270],[2,546.9,443.75],[2,1059.4,334.4],[3,787.5,656.25],[4,887.5,156.25],[5,12.5,-325],[6,490.65,53.15],[6,-600,-10],[7,-846.9,-281.25],[1,-1537.55,-118.75],[2,-1862.55,-381.25],[2,-2278.2,318.8],[3,-2660,440],[4,-2660,-240],[7,-2340,-690],[5,-2710,-500],[3,-2350,-1260],[2,-2690.7,-1284.4],[12,80,1500],[9,40,1140],[12,-1070,1550],[10,-1240,1240],[8,-907.75,1346.3],[5,-2707.9,869.3],[7,-2100.15,1246.25],[3,-1661.65,630.8],[3,-207.7,638.5],[6,-2377.1,-38.45],[8,730,1420],[12,1220,1510],[9,1025.05,1155.6],[3,-569.25,-526.9],[5,-1041.7,350]];
      this.level1cannonArraySaved = [[1,320,1130,-46],[1,690,830,-145],[1,380,640,3],[1,1070,670,-135],[1,790,410,-56],[1,140,-460,176],[11,-1100,-300,-176],[1,-1760,-200,90],[11,-1750,-20,177],[1,-2180,50,89],[1,-2170,410,-174],[1,-2550,70,-90],[1,-2550,-140,-90],[1,-2550,-330,-90],[1,-2550,-520,-90],[12,-2570,400,-90],[3,1040,90,-180],[2,150,-140,0],[1,-450,190,-90],[1,-450,-320,90],[1,620,670,17],[1,941.25,535,-138],[1,870,750,-25],[1,-180,-410,164]];
      this.level1obstacleArraySaved = [[3,350.05,262.5],[3,-650,-180],[3,-800,-130],[3,-950,-80],[1,-2670,250],[1,-2440,250],[3,-2690,-650],[3,-2510,-780],[3,-2360,-630],[3,-2360,-930],[3,-2710,-930],[3,-2530,-1110],[4,-1953.9,-138.45],[4,-1490,-390],[6,-1300,-180]];
      this.level1puffleOArraySaved = [[1,376,1072],[1,429,1019],[1,481,973],[1,531,931],[1,579,896],[1,624,865],[1,624,784],[1,561,742],[1,500,706],[1,441,676],[1,1016,611],[1,867,464],[1,835,344],[1,878,282],[1,920,227],[1,960,178],[1,998,135],[1,960,90],[1,882,93],[1,808,100],[1,736,110],[1,667,124],[1,601,141],[1,538,161],[1,477,184],[1,352.5,137.5],[1,326.2,60.25],[1,300,-24.05],[1,246.9,-96.6],[1,144,-380],[1,148,-300],[1,152,-218],[1,-297,-378],[1,-361,-354],[1,-67.5,-440],[1,25,-452.5],[1,-1180,-305],[1,-1257,-308],[1,-1332,-306],[1,-1403,-301],[1,-1471,-292],[1,-1537,-279],[1,-1600,-264],[1,-1661,-244],[1,-1760,-120],[1,-2179,130],[1,-2177,210],[1,-2176,292],[1,-2249,402],[1,-2327,396],[1,-2401,395],[1,-2550,320],[1,-2550,245],[1,-2550,177],[1,-2550,-10],[1,-2550,-85],[1,-2550,-220],[1,-2550,-295],[1,-2550,-410],[1,-2550,-485],[1,-2550,-600],[1,-2550,-675],[1,-2550,-742],[1,-2550,-804],[1,-2550,-859],[1,-2550,-907],[1,-2550,-951],[1,-2550,-988],[1,-450,-240],[1,-450,-159],[1,-450,-78],[1,-450,4],[1,-450,86],[1,-1830,-16],[1,-1907,-9],[1,-1982,2],[1,-2053,16],[1,-2122,33],[1,460,644],[1,537,651],[1,697,693],[1,771,719],[1,943,716],[1,1013,686],[1,1040,-388],[1,1040,-437.8],[1,1040,-486],[1,-670,-437],[1,-822,-394],[1,-970,-335]];
   }
}
