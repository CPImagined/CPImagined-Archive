class com.clubpenguin.games.cannon.BabushkaBox extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var groundX1;
   var groundY1;
   var groundX2;
   var groundY2;
   var groundX3;
   var groundY3;
   var groundX4;
   var groundY4;
   var groundX5;
   var groundY5;
   var motionX1;
   var motionY1;
   var motionX2;
   var motionY2;
   var motionX3;
   var motionY3;
   var motionX4;
   var motionY4;
   var motionX5;
   var motionY5;
   var elasticMultiplier;
   var elasticMultiplierDefault;
   var settingN;
   var movie;
   var sizeX;
   var sizeY;
   var hidden;
   var waitN;
   var b1Hittable;
   var b2Hittable;
   var b3Hittable;
   var b4Hittable;
   var b5Hittable;
   var game;
   var gameplayHolder;
   var gameplayWorld;
   function BabushkaBox($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX1 = 0;
      this.groundY1 = 0;
      this.groundX2 = 150;
      this.groundY2 = 0;
      this.groundX3 = 300;
      this.groundY3 = 0;
      this.groundX4 = 450;
      this.groundY4 = 0;
      this.groundX5 = 600;
      this.groundY5 = 0;
      this.motionX1 = 0;
      this.motionY1 = 0;
      this.motionX2 = 0;
      this.motionY2 = 0;
      this.motionX3 = 0;
      this.motionY3 = 0;
      this.motionX4 = 0;
      this.motionY4 = 0;
      this.motionX5 = 0;
      this.motionY5 = 0;
      this.elasticMultiplier = 0.95;
      this.elasticMultiplierDefault = 0.95;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width + 700;
      this.sizeY = this.movie._height + 700;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.movie.master = this;
      this.waitN = 0;
      this.b1Hittable = true;
      this.b2Hittable = false;
      this.b3Hittable = false;
      this.b4Hittable = false;
      this.b5Hittable = false;
      if(this.game.gameMode == "standardGameplay")
      {
         this.movie.art.gotoAndStop("gameplay");
      }
   }
   function updateGameplay($speedMod)
   {
      var _loc4_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc4_ = true;
               }
            }
         }
      }
      if(_loc4_ == true)
      {
         if(this.hidden == true)
         {
            this.movie.gotoAndStop(this.settingN);
            this.hidden = false;
            this.movie.art.gotoAndStop("gameplay");
            this.movie.art.art.b1.gotoAndStop("still");
            if(this.b2Hittable == true)
            {
               this.movie.art.art.b2.gotoAndStop("still");
            }
            if(this.b3Hittable == true)
            {
               this.movie.art.art.b3.gotoAndStop("still");
            }
            if(this.b4Hittable == true)
            {
               this.movie.art.art.b4.gotoAndStop("still");
            }
            if(this.b5Hittable == true)
            {
               this.movie.art.art.b5.gotoAndStop("still");
            }
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
      else if(this.game.playerObj.inCannon == false)
      {
         var _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            if(this["b" + _loc2_ + "Hittable"] == true)
            {
               this.detectPlayer(_loc2_);
            }
            _loc2_ += 1;
         }
      }
      _loc2_ = 1;
      while(_loc2_ <= 5)
      {
         this.updatePos(_loc2_,$speedMod);
         _loc2_ += 1;
      }
   }
   function detectPlayer($n)
   {
      var _loc15_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x + this.movie.art.art["b" + $n]._x,this.movie._y + this.movie.art.art["b" + $n]._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
      var _loc11_ = false;
      var _loc9_ = this.movie._x + this.movie.art.art["b" + $n]._x;
      var _loc10_ = this.movie._y + this.movie.art.art["b" + $n]._y;
      var _loc4_ = this.game.playerObj.movie._x;
      var _loc6_ = this.game.playerObj.movie._y;
      var _loc13_ = 100;
      if($n == 1)
      {
         var _loc5_ = 59;
         var _loc3_ = 48;
      }
      else if($n == 2)
      {
         _loc5_ = 50;
         _loc3_ = 41;
      }
      else if($n == 3)
      {
         _loc5_ = 41;
         _loc3_ = 34;
      }
      else if($n == 4)
      {
         _loc5_ = 33;
         _loc3_ = 28;
      }
      else if($n == 5)
      {
         _loc5_ = 24;
         _loc3_ = 22;
      }
      if(_loc15_ < _loc13_)
      {
         if(_loc4_ > _loc9_ - _loc5_)
         {
            if(_loc4_ < _loc9_ + _loc5_)
            {
               if(_loc6_ > _loc10_ - _loc3_)
               {
                  if(_loc6_ < _loc10_ + _loc3_)
                  {
                     _loc11_ = true;
                  }
               }
            }
         }
      }
      if(_loc11_ == true)
      {
         var _loc12_ = false;
         _loc4_ = this.game.playerObj.halfPosX;
         _loc6_ = this.game.playerObj.halfPosY;
         if(_loc15_ < _loc13_)
         {
            if(_loc4_ > _loc9_ - _loc5_)
            {
               if(_loc4_ < _loc9_ + _loc5_)
               {
                  if(_loc6_ > _loc10_ - _loc3_)
                  {
                     if(_loc6_ < _loc10_ + _loc3_)
                     {
                        _loc12_ = true;
                     }
                  }
               }
            }
         }
      }
      if(_loc11_ == true)
      {
         if(_loc12_ == true)
         {
            _loc4_ = this.game.playerObj.halfPosX;
            _loc6_ = this.game.playerObj.halfPosY;
         }
         else
         {
            _loc4_ = this.game.playerObj.movie._x;
            _loc6_ = this.game.playerObj.movie._y;
         }
         var _loc14_ = com.clubpenguin.math.AaronsPhysics.findAngle(_loc4_,_loc6_,this.movie._x + this.movie.art.art["b" + $n]._x,this.movie._y + this.movie.art.art["b" + $n]._y);
         var _loc7_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc14_,20);
         var _loc8_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc14_,20);
         this["motionX" + $n] += _loc7_ / 2;
         this["motionY" + $n] += _loc8_ / 2;
         if(Math.abs(_loc7_) > Math.abs(_loc8_))
         {
            _loc7_ *= 1.5;
            _loc8_ *= 0.5;
         }
         else
         {
            _loc7_ *= 0.5;
            _loc8_ * 2;
         }
         this.game.playerObj.motionX = _loc7_ * -0.7;
         this.game.playerObj.motionY = _loc8_ * -1;
         this.game.playerObj.motionR = Math.abs(_loc7_) + Math.abs(_loc8_);
         this.movie.art.art["b" + $n].gotoAndStop("bump");
         if(this["b" + ($n + 1) + "Hittable"] == false)
         {
            this["b" + ($n + 1) + "Hittable"] = true;
            this.movie.art.art["b" + ($n + 1)].gotoAndStop("appear");
         }
         else if(this["b" + ($n + 1) + "Hittable"] == true)
         {
            this["b" + ($n + 1) + "Hittable"] = false;
            this.movie.art.art["b" + ($n + 1)].gotoAndStop("remove");
         }
         else if($n == 5)
         {
            this["b" + $n + "Hittable"] = false;
            this.movie.art.art["b" + $n].gotoAndStop("dissipate");
         }
         this.waitN += 1;
      }
   }
   function chainReaction($n)
   {
      if(this["b" + $n + "Hittable"] == true)
      {
         this["b" + $n + "Hittable"] = false;
         this.movie.art.art["b" + $n].gotoAndStop("dissipate");
      }
   }
   function updatePos($n, $speedMod)
   {
      if(this.movie.art.art["b" + $n]._x > this["groundX" + $n] + 1)
      {
         this["motionX" + $n] -= Math.abs(this.movie.art.art["b" + $n]._x - this["groundX" + $n]) * this.elasticMultiplier * $speedMod;
      }
      else if(this.movie.art.art["b" + $n]._x < this["groundX" + $n] - 1)
      {
         this["motionX" + $n] += Math.abs(this.movie.art.art["b" + $n]._x - this["groundX" + $n]) * this.elasticMultiplier * $speedMod;
      }
      if(this.movie.art.art["b" + $n]._y > this["groundY" + $n] + 1)
      {
         this["motionY" + $n] -= Math.abs(this.movie.art.art["b" + $n]._y - this["groundY" + $n]) * this.elasticMultiplier * $speedMod;
      }
      else if(this.movie.art.art["b" + $n]._y < this["groundY" + $n] - 1)
      {
         this["motionY" + $n] += Math.abs(this.movie.art.art["b" + $n]._y - this["groundY" + $n]) * this.elasticMultiplier * $speedMod;
      }
      this["motionX" + $n] *= 1 - 0.3 * $speedMod;
      this["motionY" + $n] *= 1 - 0.3 * $speedMod;
      this.movie.art.art["b" + $n]._x += this["motionX" + $n] * $speedMod;
      this.movie.art.art["b" + $n]._y += this["motionY" + $n] * $speedMod;
   }
}
