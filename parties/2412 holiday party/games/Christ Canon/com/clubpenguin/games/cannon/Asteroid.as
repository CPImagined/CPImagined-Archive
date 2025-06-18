class com.clubpenguin.games.cannon.Asteroid extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var idNumber;
   var motionX;
   var motionY;
   var motionR;
   var groundX;
   var groundY;
   var settingN;
   var movie;
   var sizeX;
   var sizeY;
   var hidden;
   var variantN;
   var shrinking;
   var collidable;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function Asteroid($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.idNumber = $idn;
      this.motionX = 0;
      this.motionY = 0;
      this.motionR = 0;
      this.groundX = $posX;
      this.groundY = $posY;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.variantN = random(3) + 1;
      this.movie.art.art.gotoAndStop(this.variantN);
      this.shrinking = false;
      this.collidable = true;
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
            this.movie.art.art.gotoAndStop(this.variantN);
            this.hidden = false;
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
      }
      var _loc5_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
      if(this.game.playerObj.inCannon == false)
      {
         if(this.collidable == true)
         {
            _loc5_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
            if(_loc5_ < 50)
            {
               this.movie.art.gotoAndStop("bump");
               this.movie.art.art.art.gotoAndStop(this.variantN);
               this.game.forceSlowMode = false;
               var _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
               var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,50);
               var _loc7_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,50);
               this.game.playerObj.motionX = _loc4_ * 0.8;
               this.game.playerObj.motionY = _loc7_ * 0.8;
               this.motionX -= _loc4_ / 4;
               this.motionY -= _loc7_ / 4;
            }
         }
      }
      if(this.movie._x > this.groundX + 1)
      {
         this.motionX -= Math.abs(this.movie._x - this.groundX) * 0.001 * $speedMod;
      }
      else if(this.movie._x < this.groundX - 1)
      {
         this.motionX += Math.abs(this.movie._x - this.groundX) * 0.001 * $speedMod;
      }
      if(this.movie._y > this.groundY + 1)
      {
         this.motionY -= Math.abs(this.movie._y - this.groundY) * 0.001 * $speedMod;
      }
      else if(this.movie._y < this.groundY - 1)
      {
         this.motionY += Math.abs(this.movie._y - this.groundY) * 0.001 * $speedMod;
      }
      if(this.shrinking == true)
      {
         this.motionR += 4;
         this.movie._xscale *= 0.9;
         this.movie._yscale *= 0.9;
         if(this.movie._xscale < 1)
         {
            removeMovieClip(this.movie);
            false;
         }
      }
      this.motionX *= 1 - 0.1 * $speedMod;
      this.motionY *= 1 - 0.1 * $speedMod;
      this.motionR *= 1 - 0.1 * $speedMod;
      this.movie._x += this.motionX * $speedMod;
      this.movie._y += this.motionY * $speedMod;
      this.movie._rotation += this.motionR;
   }
}
