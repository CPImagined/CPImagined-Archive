class com.clubpenguin.games.cannon.AirFans extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var motionX;
   var motionY;
   var motionSpeed;
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
   var holdMet;
   function AirFans($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.motionX = 0;
      this.motionY = 0;
      this.motionSpeed = 1;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      if(this.settingN == 13)
      {
         this.groundY = this.movie._y;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundY;
         this.hold2 = this.groundY + 300;
         this.waitDefault = 10;
         this.wait = 0;
      }
      if(this.settingN == 14)
      {
         this.groundY = this.movie._y;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundY - 300;
         this.hold2 = this.groundY;
         this.waitDefault = 10;
         this.wait = 0;
      }
      if(this.settingN == 15)
      {
         this.groundX = this.movie._x;
         this.holdsTotal = 2;
         this.currentHold = 2;
         this.hold1 = this.groundX - 300;
         this.hold2 = this.groundX;
         this.waitDefault = 10;
         this.wait = 0;
      }
      if(this.settingN == 16)
      {
         this.groundX = this.movie._x;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundX;
         this.hold2 = this.groundX + 300;
         this.waitDefault = 10;
         this.wait = 0;
      }
   }
   function updateGameplay($speedMod)
   {
      var _loc3_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc3_ = true;
               }
            }
         }
      }
      if(_loc3_ == true)
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
         if(_loc6_ < 220)
         {
            if(this.game.playerObj.movie._y < this.movie._y)
            {
               if(this.game.playerObj.movie._x > this.movie._x - 60)
               {
                  if(this.game.playerObj.movie._x < this.movie._x + 60)
                  {
                     var _loc4_ = this.movie.art._rotation - 90;
                     var _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc4_,1.8);
                     var _loc2_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc4_,1.8);
                     this.game.playerObj.motionX += _loc5_;
                     if(this.game.playerObj.motionY > 0)
                     {
                        this.game.playerObj.motionY += _loc2_ - this.game.playerObj.motionY / 3;
                     }
                     else
                     {
                        this.game.playerObj.motionY += _loc2_;
                     }
                     this.game.playerObj.motionR += _loc2_;
                  }
               }
            }
         }
      }
      if(this.settingN == 13 || this.settingN == 14)
      {
         if(this.wait > 0)
         {
            this.wait = this.wait - 1;
         }
         else
         {
            this.holdMet = false;
            if(this.currentHold == 1)
            {
               if(this.movie._y <= this["hold" + this.currentHold])
               {
                  this.holdMet = true;
               }
            }
            else if(this.currentHold == 2)
            {
               if(this.movie._y >= this["hold" + this.currentHold])
               {
                  this.holdMet = true;
               }
            }
            if(this.holdMet == true)
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
               this.motionY += this.motionSpeed;
            }
            else if(this.movie._y > this["hold" + this.currentHold])
            {
               this.motionY -= this.motionSpeed;
            }
         }
      }
      if(this.settingN == 15 || this.settingN == 16)
      {
         if(this.wait > 0)
         {
            this.wait = this.wait - 1;
         }
         else
         {
            this.holdMet = false;
            if(this.currentHold == 1)
            {
               if(this.movie._x <= this["hold" + this.currentHold])
               {
                  this.holdMet = true;
               }
            }
            else if(this.currentHold == 2)
            {
               if(this.movie._x >= this["hold" + this.currentHold])
               {
                  this.holdMet = true;
               }
            }
            if(this.holdMet == true)
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
               this.motionX += this.motionSpeed;
            }
            else if(this.movie._x > this["hold" + this.currentHold])
            {
               this.motionX -= this.motionSpeed;
            }
         }
      }
      this.motionX *= 0.9;
      this.motionY *= 0.9;
      this.movie._x += this.motionX;
      this.movie._y += this.motionY;
   }
}
