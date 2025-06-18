class com.clubpenguin.games.cannon.BoxDragon extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var motionX;
   var motionY;
   var elasticMultiplier;
   var elasticMultiplierDefault;
   var settingN;
   var movie;
   var sizeX;
   var sizeY;
   var hidden;
   var pullY;
   var pullX;
   var flippedX;
   var game;
   var gameplayHolder;
   var gameplayWorld;
   function BoxDragon($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.motionX = 0;
      this.motionY = 0;
      this.elasticMultiplier = 0.95;
      this.elasticMultiplierDefault = 0.95;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width + 700;
      this.sizeY = this.movie._height + 700;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.pullY = 0;
      this.pullX = 0;
      this.flippedX = false;
      this.movie.master = this;
      if(this.game.gameMode == "standardGameplay")
      {
         this.movie.art.gotoAndStop("gameplay");
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
            this.movie.art.gotoAndStop("gameplay");
            this.movie.art.art.b1.gotoAndStop("still");
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
      }
      this.motionY += this.pullY;
      this.motionX += this.pullX;
      this.motionX *= 1 - 0.2 * $speedMod;
      this.motionY *= 1 - 0.2 * $speedMod;
      this.movie._x += this.motionX * $speedMod;
      this.movie._y += this.motionY * $speedMod;
      if(this.game.playerObj.inCannon == false)
      {
         var _loc2_ = 1;
         while(_loc2_ <= 6)
         {
            this.detectPlayer(_loc2_);
            _loc2_ += 1;
         }
      }
   }
   function detectPlayer($n)
   {
      var _loc11_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x + this.movie.art.art._x + this.movie.art.art["c" + $n]._x,this.movie._y + this.movie.art.art._y + this.movie.art.art["c" + $n]._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
      var _loc13_ = false;
      var _loc9_ = this.movie._x + this.movie.art.art._x + this.movie.art.art["c" + $n]._x;
      var _loc10_ = this.movie._y + this.movie.art.art._y + this.movie.art.art["c" + $n]._y;
      if(this.flippedX == true)
      {
         _loc11_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x - this.movie.art.art._x - this.movie.art.art["c" + $n]._x,this.movie._y + this.movie.art.art._x + this.movie.art.art["c" + $n]._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
         _loc9_ = this.movie._x - this.movie.art.art._x - this.movie.art.art["c" + $n]._x;
      }
      var _loc3_ = this.game.playerObj.movie._x;
      var _loc4_ = this.game.playerObj.movie._y;
      if($n == 1)
      {
         var _loc7_ = 186;
         var _loc6_ = 186;
         var _loc5_ = 41;
      }
      else if($n == 2)
      {
         _loc7_ = 146;
         _loc6_ = 146;
         _loc5_ = 69;
      }
      else if($n == 3)
      {
         _loc7_ = 242;
         _loc6_ = 242;
         _loc5_ = 113;
      }
      else if($n == 4)
      {
         _loc7_ = 188;
         _loc6_ = 188;
         _loc5_ = 139;
      }
      else if($n == 5)
      {
         _loc7_ = 123;
         _loc6_ = 123;
         _loc5_ = 69;
      }
      else if($n == 6)
      {
         _loc7_ = 136;
         _loc6_ = 136;
         _loc5_ = 103;
      }
      if(_loc11_ < _loc7_)
      {
         if(_loc3_ > _loc9_ - _loc6_)
         {
            if(_loc3_ < _loc9_ + _loc6_)
            {
               if(_loc4_ > _loc10_ - _loc5_)
               {
                  if(_loc4_ < _loc10_ + _loc5_)
                  {
                     _loc13_ = true;
                  }
               }
            }
         }
      }
      if(_loc13_ == true)
      {
         var _loc12_ = false;
         _loc3_ = this.game.playerObj.halfPosX;
         _loc4_ = this.game.playerObj.halfPosY;
         if(_loc11_ < _loc7_)
         {
            if(_loc3_ > _loc9_ - _loc6_)
            {
               if(_loc3_ < _loc9_ + _loc6_)
               {
                  if(_loc4_ > _loc10_ - _loc5_)
                  {
                     if(_loc4_ < _loc10_ + _loc5_)
                     {
                        _loc12_ = true;
                     }
                  }
               }
            }
         }
      }
      if(_loc12_ == true)
      {
         var _loc14_ = false;
         _loc3_ = this.game.playerObj.onethirdPosX;
         _loc4_ = this.game.playerObj.onethirdPosY;
         if(_loc11_ < _loc7_)
         {
            if(_loc3_ > _loc9_ - _loc6_)
            {
               if(_loc3_ < _loc9_ + _loc6_)
               {
                  if(_loc4_ > _loc10_ - _loc5_)
                  {
                     if(_loc4_ < _loc10_ + _loc5_)
                     {
                        _loc14_ = true;
                     }
                  }
               }
            }
         }
      }
      if(_loc13_ == true)
      {
         if(_loc14_ == true)
         {
            _loc3_ = this.game.playerObj.onethirdPosX;
            _loc4_ = this.game.playerObj.onethirdPosY;
         }
         else if(_loc12_ == true)
         {
            _loc3_ = this.game.playerObj.halfPosX;
            _loc4_ = this.game.playerObj.halfPosY;
         }
         else
         {
            _loc3_ = this.game.playerObj.movie._x;
            _loc4_ = this.game.playerObj.movie._y;
         }
         var _loc15_ = com.clubpenguin.math.AaronsPhysics.findAngle(_loc3_,_loc4_,this.movie._x + this.movie.art.art._x + this.movie.art.art["c" + $n]._x,this.movie._y + this.movie.art.art._y + this.movie.art.art["c" + $n]._y);
         if(this.flippedX == true)
         {
            _loc15_ = com.clubpenguin.math.AaronsPhysics.findAngle(_loc3_,_loc4_,this.movie._x - this.movie.art.art._x - this.movie.art.art["c" + $n]._x,this.movie._y + this.movie.art.art._y + this.movie.art.art["c" + $n]._y);
         }
         var _loc8_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc15_,20);
         if(_loc8_ > 0)
         {
            _loc8_ = 20;
         }
         if(_loc8_ < 0)
         {
            _loc8_ = -20;
         }
         _loc8_ -= this.motionY * 1.2;
         this.game.playerObj.motionY = _loc8_ * -1;
         this.game.playerObj.motionR = Math.abs(_loc8_);
         if($n == 1)
         {
            this.movie.art.art.tail2.gotoAndStop("wave");
         }
         else if($n == 2)
         {
            this.movie.art.art.tail1.gotoAndStop("bump");
         }
         else if($n == 3)
         {
            this.movie.art.art.torso.gotoAndStop("bump");
         }
         else if($n == 5)
         {
            this.movie.art.art.neck.gotoAndStop("bump");
         }
         else if($n == 6)
         {
            this.movie.art.art.head.gotoAndStop("sleep");
            this.movie.art.art.head.gotoAndStop("awake");
         }
      }
   }
}
