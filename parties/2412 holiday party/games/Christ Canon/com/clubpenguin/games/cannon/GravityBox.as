class com.clubpenguin.games.cannon.GravityBox extends com.clubpenguin.games.cannon.GameplayObstacle
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
   var spinning;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function GravityBox($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
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
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.movie.master = this;
      this.spinning = false;
   }
   function updateGameplay($speedMod)
   {
      var _loc6_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc6_ = true;
               }
            }
         }
      }
      if(_loc6_ == true)
      {
         if(this.hidden == true)
         {
            this.movie.gotoAndStop(this.settingN);
            this.hidden = false;
            if(this.game.gravityInverted == false)
            {
               this.movie.art.art.gotoAndStop("down");
            }
            else
            {
               this.movie.art.art.gotoAndStop("up");
            }
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
         if(this.spinning == true)
         {
            this.invertGravity();
         }
      }
      if(this.game.playerObj.inCannon == false)
      {
         var _loc7_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
         if(_loc7_ < 43)
         {
            var _loc5_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.playerObj.getPosX(),this.game.playerObj.getPosY(),this.movie._x,this.movie._y);
            var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc5_,20);
            var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc5_,20);
            this.motionX += _loc3_;
            this.motionY += _loc4_;
            this.game.playerObj.motionX = _loc3_ * -0.9;
            this.game.playerObj.motionY = _loc4_ * -1.2;
            this.game.playerObj.motionR = Math.abs(_loc3_) + Math.abs(_loc4_);
            this.movie.art.gotoAndStop("still");
            this.movie.art.gotoAndStop("bump");
            if(this.game.gravityInverted == false)
            {
               this.movie.art.art.art.gotoAndStop("up");
            }
            else
            {
               this.movie.art.art.art.gotoAndStop("down");
            }
            this.spinning = true;
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
      if(this.spinning == true)
      {
         this.movie.art.art.art.art.nextFrame();
      }
   }
   function invertGravity()
   {
      if(this.game.gravityInverted == false)
      {
         this.game.gravityInverted = true;
      }
      else if(this.game.gravityInverted == true)
      {
         this.game.gravityInverted = false;
      }
      this.spinning = false;
   }
}
