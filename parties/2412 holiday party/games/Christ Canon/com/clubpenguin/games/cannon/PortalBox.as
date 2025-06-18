class com.clubpenguin.games.cannon.PortalBox extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var groundX;
   var movie;
   var groundY;
   var motionX;
   var motionY;
   var elasticMultiplier;
   var elasticMultiplierDefault;
   var portalLinked;
   var linkedPortal;
   var waitN;
   var linkArtN;
   var settingN;
   var sizeX;
   var sizeY;
   var hidden;
   var animating;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function PortalBox($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.motionX = 0;
      this.motionY = 0;
      this.elasticMultiplier = 0.35;
      this.elasticMultiplierDefault = 0.35;
      this.portalLinked = false;
      this.linkedPortal = this;
      this.waitN = 0;
      this.linkArtN = 1;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.animating = false;
      this.movie.master = this;
   }
   function updateGameplay($speedMod)
   {
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
      if(this.animating == true)
      {
         _loc12_ = true;
      }
      if(_loc12_ == true)
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
      if(this.portalLinked == false)
      {
         var _loc2_ = 0;
         while(_loc2_ <= this.game.portalArray.length)
         {
            if(this.game.portalArray[_loc2_] == this)
            {
               if(this.game.portalArray[_loc2_ - 1].portalLinked == false)
               {
                  this.linkedPortal = this.game.portalArray[_loc2_ - 1];
                  this.game.portalArray[_loc2_ - 1].linkedPortal = this;
                  this.game.portalArray[_loc2_ - 1].portalLinked = true;
                  this.portalLinked = true;
                  this.game.linkedPortalN = this.game.linkedPortalN + 1;
                  if(this.game.linkedPortalN > 20)
                  {
                     this.game.linkedPortalN = 1;
                  }
                  this.linkArtN = this.game.linkedPortalN;
                  this.game.portalArray[_loc2_ - 1].linkArtN = this.linkArtN;
               }
            }
            _loc2_ += 1;
         }
      }
      if(this.waitN > 0)
      {
         this.waitN = this.waitN - 1;
      }
      else if(this.game.playerObj.inCannon == false)
      {
         var _loc10_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
         if(_loc10_ < 50)
         {
            var _loc19_ = this.game.playerObj.movie._x - this.game.playerObj.motionX;
            var _loc20_ = this.game.playerObj.movie._y - this.game.playerObj.motionY;
            var _loc4_ = com.clubpenguin.math.AaronsPhysics.findAngle(_loc19_,_loc20_,this.movie._x,this.movie._y);
            if(_loc4_ >= 180)
            {
               _loc4_ -= 360;
            }
            trace("entryAngle " + _loc4_);
            var _loc13_ = undefined;
            if(_loc4_ != 0)
            {
               _loc13_ = Math.abs(_loc4_) / _loc4_;
            }
            else
            {
               _loc13_ = 1;
            }
            var _loc3_ = this.movie._rotation;
            if(_loc3_ < -180)
            {
               _loc3_ += 360;
            }
            _loc3_ += 90;
            if(_loc3_ >= 180)
            {
               _loc3_ -= 360;
            }
            trace("boxAngle " + _loc3_);
            var _loc8_ = undefined;
            if(_loc3_ != 0)
            {
               _loc8_ = Math.abs(_loc3_) / _loc3_;
            }
            else
            {
               _loc8_ = 1;
            }
            var _loc7_ = undefined;
            _loc7_ = 0;
            _loc7_ = Math.abs(_loc4_ - _loc3_);
            if(_loc7_ > 60 && _loc13_ != _loc8_)
            {
               _loc4_ += _loc8_ * 360;
               _loc7_ = Math.abs(_loc4_ - _loc3_);
            }
            trace("diff " + _loc4_ + ":" + _loc3_);
            if(_loc7_ <= 60)
            {
               this.movie.art.gotoAndStop("still");
               this.movie.art.gotoAndStop("bumpin");
               this.motionY += this.game.playerObj.motionY;
               this.linkedPortal.animating = true;
               this.linkedPortal.movie.gotoAndStop(this.settingN);
               this.linkedPortal.movie.art.gotoAndStop("still");
               this.linkedPortal.movie.art.gotoAndStop("bumpout");
               this.linkedPortal.waitN += 6;
               _loc10_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
               var _loc9_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
               _loc9_ -= this.movie._rotation;
               _loc9_ += this.linkedPortal.movie._rotation;
               var _loc18_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc9_,_loc10_);
               var _loc17_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc9_,_loc10_);
               this.game.playerObj.movie._x = this.linkedPortal.movie._x + _loc18_;
               this.game.playerObj.movie._y = this.linkedPortal.movie._y + _loc17_;
               this.game.playerObj.blurCharged = true;
               this.game.playerObj.skipNextBlur = true;
               var _loc5_ = undefined;
               _loc5_ = new flash.geom.Matrix();
               _loc5_.rotate(this.movie._rotation * 0.017453292519943295);
               _loc5_.tx = this.game.playerObj.motionX;
               _loc5_.ty = this.game.playerObj.motionY;
               var _loc16_ = this.linkedPortal.movie._rotation - this.movie._rotation - 180;
               _loc5_.rotate(_loc16_ * 0.017453292519943295);
               var _loc21_ = this.game.playerObj.motionX;
               this.game.playerObj.motionX = _loc5_.tx;
               this.game.playerObj.motionY = _loc5_.ty;
               this.game.playerObj.motionY *= 1.3;
               if(this.game.playerObj.motionY > 60)
               {
                  if(this.game.gravityInverted == false)
                  {
                     this.game.playerObj.motionY = 60;
                  }
               }
               else if(this.game.playerObj.motionY < -60)
               {
                  if(this.game.gravityInverted == true)
                  {
                     this.game.playerObj.motionY = -60;
                  }
               }
               this.game.playerObj.motionR += Math.abs(this.game.playerObj.motionY) + Math.abs(this.game.playerObj.motionX);
               this.game.playerObj.camLocked = false;
               this.game.playerObj.camChasePull = 20;
               this.game.playerObj.camChaseFriction = 0.7;
            }
            else
            {
               var _loc15_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.playerObj.getPosX(),this.game.playerObj.getPosY(),this.movie._x,this.movie._y);
               var _loc11_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc15_,20);
               var _loc14_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc15_,20);
               this.motionX += _loc11_;
               this.motionY += _loc14_;
               this.game.playerObj.motionX = _loc11_ * -0.9;
               this.game.playerObj.motionY = _loc14_ * -1.2;
               this.game.playerObj.motionR = Math.abs(_loc11_) + Math.abs(_loc14_);
               this.movie.art.gotoAndStop("still");
               this.movie.art.gotoAndStop("bump");
               this.waitN += 3;
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
      this.motionX *= 1 - 0.2 * $speedMod;
      this.motionY *= 1 - 0.2 * $speedMod;
      this.movie._x += this.motionX * $speedMod;
      this.movie._y += this.motionY * $speedMod;
      this.movie.art.art.idart.gotoAndStop(this.linkArtN);
   }
}
