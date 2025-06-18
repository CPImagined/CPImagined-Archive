class com.clubpenguin.games.cannon.Piano extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var settingN;
   var movie;
   var sizeX;
   var sizeY;
   var hidden;
   var groundY;
   var holdsTotal;
   var currentHold;
   var hold1;
   var hold2;
   var waitDefault;
   var wait;
   var groundX;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function Piano($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      if(this.settingN == 4)
      {
         this.groundY = this.movie._y;
         this.holdsTotal = 2;
         this.currentHold = 2;
         this.hold1 = this.groundY + 240;
         this.hold2 = this.groundY;
         this.waitDefault = 10;
         this.wait = 0;
      }
      if(this.settingN == 5)
      {
         this.groundX = this.movie._x;
         this.holdsTotal = 2;
         this.currentHold = 2;
         this.hold1 = this.groundX + 240;
         this.hold2 = this.groundX;
         this.waitDefault = 10;
         this.wait = 0;
      }
      if(this.settingN == 6)
      {
         this.groundY = this.movie._y;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundY - 240;
         this.hold2 = this.groundY;
         this.waitDefault = 10;
         this.wait = 0;
      }
   }
   function updateGameplay()
   {
      var _loc2_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc2_ = true;
               }
            }
         }
      }
      if(_loc2_ == true)
      {
         if(this.hidden == true)
         {
            this.movie.gotoAndStop(this.settingN);
            this.hidden = false;
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
      }
      if(this.game.playerObj.inCannon == false)
      {
         var _loc6_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
         if(_loc6_ < 90)
         {
            this.movie.art.gotoAndStop("slam");
            var _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
            var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,50);
            var _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,50);
            this.game.playerObj.motionX = _loc4_ * 0.8;
            this.game.playerObj.motionY = _loc5_ * 0.8;
         }
      }
      if(this.settingN == 4 || this.settingN == 6)
      {
         if(this.wait > 0)
         {
            this.wait = this.wait - 1;
         }
         else if(int(this.movie._y) == int(this["hold" + this.currentHold]))
         {
            this.wait = this.waitDefault;
            if(this.currentHold < this.holdsTotal)
            {
               this.currentHold = this.currentHold + 1;
            }
            else
            {
               this.currentHold = 1;
            }
         }
         else if(this.movie._y < this["hold" + this.currentHold])
         {
            this.movie._y += 5;
         }
         else if(this.movie._y > this["hold" + this.currentHold])
         {
            this.movie._y -= 5;
         }
      }
      if(this.settingN == 5)
      {
         if(this.wait > 0)
         {
            this.wait = this.wait - 1;
         }
         else if(int(this.movie._x) == int(this["hold" + this.currentHold]))
         {
            this.wait = this.waitDefault;
            if(this.currentHold < this.holdsTotal)
            {
               this.currentHold = this.currentHold + 1;
            }
            else
            {
               this.currentHold = 1;
            }
         }
         else if(this.movie._x < this["hold" + this.currentHold])
         {
            this.movie._x += 5;
         }
         else if(this.movie._x > this["hold" + this.currentHold])
         {
            this.movie._x -= 5;
         }
      }
   }
}
