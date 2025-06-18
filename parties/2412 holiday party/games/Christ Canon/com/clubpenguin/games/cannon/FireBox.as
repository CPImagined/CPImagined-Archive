class com.clubpenguin.games.cannon.FireBox extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var groundX;
   var movie;
   var groundY;
   var motionX;
   var motionY;
   var settingN;
   var timehpDefault;
   var timehp;
   var state;
   var alive;
   var floatX;
   var game;
   function FireBox($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN, $motionX, $motionY, $timehp, $floatX)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.motionX = $motionX;
      this.motionY = $motionY;
      if(this.motionX * 0 != 0)
      {
         this.motionX = 0;
         this.motionY = 0;
      }
      this.movie.gotoAndStop(this.settingN);
      this.movie.art.gotoAndStop("appear");
      this.movie.master = this;
      this.timehpDefault = $timehp;
      this.timehp = $timehp;
      this.state = "still1";
      this.alive = true;
      this.floatX = $floatX;
   }
   function updateGameplay($speedMod)
   {
      if(this.game.playerObj.inCannon == false)
      {
         if(this.alive == true)
         {
            var _loc6_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
            var _loc9_ = false;
            var _loc7_ = this.movie._x;
            var _loc8_ = this.movie._y;
            var _loc4_ = this.game.playerObj.movie._x;
            var _loc5_ = this.game.playerObj.movie._y;
            if(_loc6_ < 60)
            {
               if(_loc4_ > _loc7_ - 46)
               {
                  if(_loc4_ < _loc7_ + 46)
                  {
                     if(_loc5_ > _loc8_ - 36)
                     {
                        if(_loc5_ < _loc8_ + 36)
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
               _loc4_ = this.game.playerObj.halfPosX;
               _loc5_ = this.game.playerObj.halfPosY;
               if(_loc6_ < 60)
               {
                  if(_loc4_ > _loc7_ - 46)
                  {
                     if(_loc4_ < _loc7_ + 46)
                     {
                        if(_loc5_ > _loc8_ - 36)
                        {
                           if(_loc5_ < _loc8_ + 36)
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
                  _loc4_ = this.game.playerObj.halfPosX;
                  _loc5_ = this.game.playerObj.halfPosY;
               }
               else
               {
                  _loc4_ = this.game.playerObj.movie._x;
                  _loc5_ = this.game.playerObj.movie._y;
               }
               var _loc10_ = com.clubpenguin.math.AaronsPhysics.findAngle(_loc4_,_loc5_,this.movie._x,this.movie._y);
               var _loc2_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc10_,20);
               var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc10_,20);
               this.motionX += _loc2_ * 3;
               this.motionY += _loc3_ * 3;
               if(this.timehpDefault == 48)
               {
                  if(this.state == "still3")
                  {
                     this.game.playerObj.motionX = _loc2_ * -0.7;
                     this.game.playerObj.motionY = _loc3_ * -1.3;
                     this.game.playerObj.motionR = Math.abs(_loc2_) + Math.abs(_loc3_);
                     this.game.playerObj.motionR += 30;
                  }
                  else if(this.state == "still2")
                  {
                     this.game.playerObj.motionX = _loc2_ * -0.9;
                     this.game.playerObj.motionY = _loc3_ * -1.7;
                     this.game.playerObj.motionR = Math.abs(_loc2_) + Math.abs(_loc3_);
                     this.game.playerObj.motionR += 30;
                  }
                  else if(this.state == "still1")
                  {
                     this.game.playerObj.motionX = _loc2_ * -1.1;
                     this.game.playerObj.motionY = _loc3_ * -2;
                     this.game.playerObj.motionR = Math.abs(_loc2_) + Math.abs(_loc3_);
                     this.game.playerObj.motionR += 30;
                  }
               }
               else
               {
                  this.game.playerObj.motionX = _loc2_ * -1.1;
                  this.game.playerObj.motionY = _loc3_ * -2;
                  this.game.playerObj.motionR = Math.abs(_loc2_) + Math.abs(_loc3_);
                  this.game.playerObj.motionR += 30;
               }
               if(this.game.playerObj.motionX < 0)
               {
                  this.game.playerObj.motionX *= 0.5;
               }
               this.movie._rotation = _loc10_ - 90;
               this.movie.art.gotoAndStop("still");
               this.movie.art.gotoAndStop("explode");
               this.state = "explode";
               this.alive = false;
            }
         }
      }
      if(this.timehp > 0)
      {
         this.timehp = this.timehp - 1;
      }
      else
      {
         if(this.state == "still1")
         {
            this.state = "still2";
            this.game.fireboxNewest = this;
         }
         else if(this.state == "still2")
         {
            this.state = "still3";
         }
         else if(this.state == "still3")
         {
            this.state = "expire";
            this.alive = false;
         }
         this.movie.art.gotoAndStop(this.state);
         this.timehp = this.timehpDefault;
      }
      this.motionY -= 0.2;
      this.motionX -= this.floatX;
      this.motionX *= 1 - 0.02 * $speedMod;
      this.motionY *= 1 - 0.02 * $speedMod;
      this.movie._x += this.motionX * $speedMod;
      this.movie._y += this.motionY * $speedMod;
      if(this.state == "expire")
      {
         _loc6_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
         if(_loc6_ < 160)
         {
            this.game.playerObj.motionY = -30;
            this.game.playerObj.motionR = 60;
         }
      }
   }
   function destroy()
   {
      this.movie.removeMovieClip();
   }
}
