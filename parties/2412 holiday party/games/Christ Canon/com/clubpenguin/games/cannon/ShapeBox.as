class com.clubpenguin.games.cannon.ShapeBox extends com.clubpenguin.games.cannon.GameplayObstacle
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
   var shape;
   var waitN;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function ShapeBox($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.motionX = 0;
      this.motionY = 0;
      this.elasticMultiplier = 0.35;
      this.elasticMultiplierDefault = 0.35;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height + 700;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.shape = "square";
      this.movie.master = this;
      this.waitN = 0;
   }
   function updateGameplay($speedMod)
   {
      var _loc19_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc19_ = true;
               }
            }
         }
      }
      if(_loc19_ == true)
      {
         if(this.hidden == true)
         {
            this.movie.gotoAndStop(this.settingN);
            this.movie.art.gotoAndStop(this.shape + "still");
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
      else if(this.game.playerObj.inCannon == false)
      {
         var _loc6_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
         var _loc9_ = false;
         var _loc12_ = this.movie._x;
         var _loc10_ = this.movie._y;
         var _loc4_ = this.game.playerObj.movie._x;
         var _loc5_ = this.game.playerObj.movie._y;
         if(this.shape == "triangle")
         {
            if(_loc6_ < 60)
            {
               var _loc13_ = this.movie._x;
               var _loc17_ = this.movie._y - 47;
               var _loc14_ = this.movie._x + 52;
               var _loc15_ = this.movie._y + 47;
               var _loc18_ = this.movie._x - 52;
               var _loc16_ = this.movie._y + 47;
               if(this.triangleCollision(_loc4_,_loc5_,_loc13_,_loc17_,_loc14_,_loc15_,_loc18_,_loc16_))
               {
                  _loc9_ = true;
               }
            }
         }
         if(this.shape == "square")
         {
            if(_loc6_ < 60)
            {
               if(_loc4_ > _loc12_ - 46)
               {
                  if(_loc4_ < _loc12_ + 46)
                  {
                     if(_loc5_ > _loc10_ - 36)
                     {
                        if(_loc5_ < _loc10_ + 36)
                        {
                           _loc9_ = true;
                        }
                     }
                  }
               }
            }
         }
         if(this.shape == "circle")
         {
            if(_loc6_ < 54)
            {
               _loc9_ = true;
            }
         }
         if(_loc9_ == true)
         {
            var _loc11_ = false;
            _loc4_ = this.game.playerObj.halfPosX;
            _loc5_ = this.game.playerObj.halfPosY;
            if(this.shape == "triangle")
            {
               if(_loc6_ < 60)
               {
                  _loc13_ = this.movie._x;
                  _loc17_ = this.movie._y - 47;
                  _loc14_ = this.movie._x + 52;
                  _loc15_ = this.movie._y + 47;
                  _loc18_ = this.movie._x - 52;
                  _loc16_ = this.movie._y + 47;
                  if(this.triangleCollision(_loc4_,_loc5_,_loc13_,_loc17_,_loc14_,_loc15_,_loc18_,_loc16_))
                  {
                     _loc11_ = true;
                  }
               }
            }
            if(this.shape == "square")
            {
               if(_loc6_ < 60)
               {
                  if(_loc4_ > _loc12_ - 46)
                  {
                     if(_loc4_ < _loc12_ + 46)
                     {
                        if(_loc5_ > _loc10_ - 36)
                        {
                           if(_loc5_ < _loc10_ + 36)
                           {
                              _loc11_ = true;
                           }
                        }
                     }
                  }
               }
            }
            if(this.shape == "circle")
            {
               if(_loc6_ < 54)
               {
                  _loc11_ = true;
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
            var _loc8_ = com.clubpenguin.math.AaronsPhysics.findAngle(_loc4_,_loc5_,this.movie._x,this.movie._y);
            if(this.shape == "square")
            {
               var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc8_,20);
               var _loc2_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc8_,20);
               this.motionX += _loc3_;
               this.motionY += _loc2_;
               this.game.playerObj.motionX = _loc3_ * -0.7;
               this.game.playerObj.motionY = _loc2_ * -1.3;
               this.game.playerObj.motionR = Math.abs(_loc3_) + Math.abs(_loc2_);
               this.shape = "circle";
            }
            else if(this.shape == "circle")
            {
               _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc8_,50);
               _loc2_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc8_,50);
               this.motionX += _loc3_;
               this.motionY += _loc2_;
               this.game.playerObj.motionX = _loc3_ * -0.5;
               this.game.playerObj.motionY = _loc2_ * -0.5;
               this.game.playerObj.motionR = Math.abs(_loc3_) + Math.abs(_loc2_);
               this.shape = "triangle";
            }
            else if(this.shape == "triangle")
            {
               _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc8_,50);
               _loc2_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc8_,50);
               this.motionX += _loc3_;
               this.motionY += _loc2_;
               this.game.playerObj.motionX = _loc3_ * -0.8;
               this.game.playerObj.motionY = _loc2_ * -0.8;
               this.game.playerObj.motionR = Math.abs(_loc3_) + Math.abs(_loc2_);
               this.shape = "square";
            }
            this.movie.art.gotoAndStop(this.shape + "still");
            this.movie.art.gotoAndStop(this.shape + "morph");
            this.waitN += 3;
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
      this.motionX *= 1 - 0.2 * $speedMod;
      this.motionY *= 1 - 0.2 * $speedMod;
      this.movie._x += this.motionX * $speedMod;
      this.movie._y += this.motionY * $speedMod;
   }
   function triangleCollision($targetX, $targetY, $ax, $ay, $bx, $by, $cx, $cy)
   {
      var _loc3_ = this.lineSide($ax,$ay,$bx,$by,$targetX,$targetY);
      var _loc2_ = this.lineSide($bx,$by,$cx,$cy,$targetX,$targetY);
      var _loc6_ = this.lineSide($cx,$cy,$ax,$ay,$targetX,$targetY);
      if(_loc3_ == _loc2_ && _loc2_ == _loc6_)
      {
         return true;
      }
      return false;
   }
   function lineSide($ax, $ay, $bx, $by, $targetX, $targetY)
   {
      var _loc1_ = ($bx - $ax) * ($targetY - $ay) - ($targetX - $ax) * ($by - $ay);
      if(_loc1_ > 0)
      {
         return "right";
      }
      if(_loc1_ < 0)
      {
         return "left";
      }
      return "mid";
   }
}
