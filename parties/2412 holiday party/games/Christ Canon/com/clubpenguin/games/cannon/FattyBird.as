class com.clubpenguin.games.cannon.FattyBird extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var groundX;
   var movie;
   var groundY;
   var motionX;
   var motionY;
   var settingN;
   var sizeX;
   var sizeY;
   var hidden;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function FattyBird($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.motionX = 0;
      this.motionY = 0;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
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
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
      }
      if(this.game.playerObj.inCannon == false)
      {
         var _loc7_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
         if(_loc7_ < 50)
         {
            var _loc5_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.playerObj.getPosX(),this.game.playerObj.getPosY(),this.movie._x,this.movie._y);
            var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc5_,50);
            var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc5_,50);
            this.motionX += _loc3_;
            this.motionY += _loc4_;
            if(this.game.playerObj.motionY >= 0)
            {
               this.game.playerObj.motionY = (Math.abs(_loc4_) + Math.abs(_loc3_)) * -0.5;
               this.game.playerObj.motionX *= 0.5;
               this.game.playerObj.motionR = Math.abs(_loc3_) + Math.abs(_loc4_);
            }
            this.movie.art.gotoAndPlay("bump");
         }
      }
      if(this.movie._x > this.groundX + 1)
      {
         this.motionX -= Math.abs(this.movie._x - this.groundX) * 0.01 * $speedMod;
      }
      else if(this.movie._x < this.groundX - 1)
      {
         this.motionX += Math.abs(this.movie._x - this.groundX) * 0.01 * $speedMod;
      }
      if(this.movie._y > this.groundY + 1)
      {
         this.motionY -= Math.abs(this.movie._y - this.groundY) * 0.01 * $speedMod;
      }
      else if(this.movie._y < this.groundY - 1)
      {
         this.motionY += Math.abs(this.movie._y - this.groundY) * 0.01 * $speedMod;
      }
      this.motionX *= 1 - 0.1 * $speedMod;
      this.motionY *= 1 - 0.1 * $speedMod;
      this.movie._x += this.motionX * $speedMod;
      this.movie._y += this.motionY * $speedMod;
   }
}
