class com.clubpenguin.games.cannon.ShatterBox extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var groundX;
   var movie;
   var groundY;
   var motionX;
   var motionY;
   var elasticMultiplier;
   var elasticMultiplierDefault;
   var settingN;
   var sizeX;
   var sizeY;
   var hidden;
   var breakN;
   var defaultBreakN;
   var waitN;
   var game;
   var gameplayHolder;
   var gameplayWorld;
   function ShatterBox($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.motionX = 0;
      this.motionY = 0;
      this.elasticMultiplier = 0.95;
      this.elasticMultiplierDefault = 0.95;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height + 700;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.movie.master = this;
      this.breakN = random(3);
      this.defaultBreakN = this.breakN;
      this.waitN = 0;
   }
   function updateGameplay($speedMod)
   {
      if(this.breakN == 4)
      {
         if(this.game.playerObj.alive == false)
         {
            this.breakN = this.defaultBreakN;
            this.movie.art.gotoAndStop("reappear");
         }
      }
      var _loc12_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc12_ = true;
               }
            }
         }
      }
      if(_loc12_ == true)
      {
         if(this.hidden == true)
         {
            this.movie.gotoAndStop(this.settingN);
            this.movie.art.gotoAndStop("break" + this.breakN + "still");
            this.hidden = false;
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
      }
      if(this.waitN > 0)
      {
         this.waitN = this.waitN - 1;
      }
      else if(this.breakN < 4)
      {
         if(this.game.playerObj.inCannon == false)
         {
            var _loc10_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
            var _loc9_ = false;
            var _loc7_ = this.movie._x;
            var _loc8_ = this.movie._y;
            var _loc2_ = this.game.playerObj.movie._x;
            var _loc3_ = this.game.playerObj.movie._y;
            if(_loc10_ < 70)
            {
               if(_loc2_ > _loc7_ - 51)
               {
                  if(_loc2_ < _loc7_ + 51)
                  {
                     if(_loc3_ > _loc8_ - 41)
                     {
                        if(_loc3_ < _loc8_ + 41)
                        {
                           _loc9_ = true;
                        }
                     }
                  }
               }
            }
            if(_loc9_ == true)
            {
               var _loc11_ = false;
               _loc2_ = this.game.playerObj.halfPosX;
               _loc3_ = this.game.playerObj.halfPosY;
               if(_loc10_ < 70)
               {
                  if(_loc2_ > _loc7_ - 51)
                  {
                     if(_loc2_ < _loc7_ + 51)
                     {
                        if(_loc3_ > _loc8_ - 41)
                        {
                           if(_loc3_ < _loc8_ + 41)
                           {
                              _loc11_ = true;
                           }
                        }
                     }
                  }
               }
            }
            if(_loc9_ == true)
            {
               if(_loc11_ == true)
               {
                  _loc2_ = this.game.playerObj.halfPosX;
                  _loc3_ = this.game.playerObj.halfPosY;
               }
               else
               {
                  _loc2_ = this.game.playerObj.movie._x;
                  _loc3_ = this.game.playerObj.movie._y;
               }
               var _loc13_ = com.clubpenguin.math.AaronsPhysics.findAngle(_loc2_,_loc3_,this.movie._x,this.movie._y);
               var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc13_,20);
               var _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc13_,20);
               this.motionX += _loc4_ / 2;
               this.motionY += _loc5_ / 2;
               if(Math.abs(_loc4_) > Math.abs(_loc5_))
               {
                  _loc4_ *= 1.5;
                  _loc5_ *= 0.5;
               }
               else
               {
                  _loc4_ *= 0.5;
                  _loc5_ * 2;
               }
               this.game.playerObj.motionX = _loc4_ * -0.7;
               this.game.playerObj.motionY = _loc5_ * -1.3;
               this.game.playerObj.motionR = Math.abs(_loc4_) + Math.abs(_loc5_);
               this.shatter();
            }
         }
      }
      if(this.movie._x > this.groundX + 1)
      {
         this.motionX -= Math.abs(this.movie._x - this.groundX) * this.elasticMultiplier * $speedMod;
      }
      else if(this.movie._x < this.groundX - 1)
      {
         this.motionX += Math.abs(this.movie._x - this.groundX) * this.elasticMultiplier * $speedMod;
      }
      if(this.movie._y > this.groundY + 1)
      {
         this.motionY -= Math.abs(this.movie._y - this.groundY) * this.elasticMultiplier * $speedMod;
      }
      else if(this.movie._y < this.groundY - 1)
      {
         this.motionY += Math.abs(this.movie._y - this.groundY) * this.elasticMultiplier * $speedMod;
      }
      this.motionX *= 1 - 0.3 * $speedMod;
      this.motionY *= 1 - 0.3 * $speedMod;
      this.movie._x += this.motionX * $speedMod;
      this.movie._y += this.motionY * $speedMod;
   }
   function shatter()
   {
      this.breakN = 4;
      this.movie.art.gotoAndStop("break0still");
      this.movie.art.gotoAndStop("break" + this.breakN);
      this.waitN += 1;
   }
   function reappear()
   {
      this.movie.art.gotoAndStop("break" + this.breakN);
   }
}
