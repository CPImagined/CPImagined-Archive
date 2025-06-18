class com.clubpenguin.games.cannon.FattyBirdRed extends com.clubpenguin.games.cannon.GameplayObstacle
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
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function FattyBirdRed($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.motionX = 0;
      this.motionY = 0;
      this.elasticMultiplier = 0.15;
      this.elasticMultiplierDefault = 0.15;
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
            var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc5_,20);
            var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc5_,20);
            this.motionX += _loc3_;
            this.motionY += _loc4_;
            this.movie.art.gotoAndStop("still");
            this.movie.art.gotoAndStop("shake");
            this.game.playerObj.motionX = _loc3_ * -0.5;
            this.game.playerObj.motionY = _loc4_ * -1.5;
            this.game.playerObj.motionR = Math.abs(_loc3_) + Math.abs(_loc4_);
         }
      }
      if(this.elasticMultiplier < this.elasticMultiplierDefault)
      {
         var _loc8_ = 100 - this.elasticMultiplier / this.elasticMultiplierDefault * 100;
         if(_loc8_ > 10)
         {
            this.elasticMultiplier *= 1.05;
         }
      }
      else if(this.elasticMultiplier > this.elasticMultiplierDefault)
      {
         this.elasticMultiplier = this.elasticMultiplierDefault;
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
   function setElasticPull($newN)
   {
      this.elasticMultiplier = $newN;
   }
}
