class com.clubpenguin.games.cannon.SlingShot extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var motionX;
   var motionY;
   var inCannon;
   var groundX;
   var movie;
   var cannon;
   var groundY;
   var pullX;
   var pullY;
   var pullingX;
   var pullingY;
   var noFire;
   var settingN;
   var sizeX;
   var sizeY;
   var hidden;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function SlingShot($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.motionX = 0;
      this.motionY = 0;
      this.inCannon = false;
      this.groundX = this.movie._x + this.cannon._x;
      this.groundY = this.movie._y + this.cannon._y;
      this.pullX = 0;
      this.pullY = 0;
      this.pullingX = false;
      this.pullingY = false;
      this.noFire = true;
      this.movie.gotoAndStop(this.settingN);
      this.cannon = this.movie.art.cannon;
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
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
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
      }
      if(this.game.playerObj.inCannon == false)
      {
         if(this.inCannon == false)
         {
            var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x + this.cannon._x,this.movie._y + this.cannon._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
            if(_loc2_ < 40)
            {
               this.game.playerObj.inCannon = true;
               this.inCannon = true;
               this.motionX += this.game.playerObj.motionX;
               this.motionY += this.game.playerObj.motionY;
               if(this.motionY < -10)
               {
                  this.motionY = -10;
               }
               this.game.playerObj.motionX = 0;
               this.game.playerObj.motionY = 0;
               this.game.playerObj.movie._x = this.movie._x + this.cannon._x;
               this.game.playerObj.movie._y = this.movie._y + this.cannon._y;
               this.movie.art.gotoAndStop("still");
               this.cannon.window.puffle.gotoAndStop(this.game.playerColor);
               this.game.playerObj.isIn = this;
            }
         }
      }
      this.pullingX = false;
      this.pullingY = false;
      if(this.inCannon == true)
      {
         if(Key.isDown(40))
         {
            if(this.cannon._y < 166)
            {
               this.pullY += 3;
            }
            else
            {
               this.motionY = 0;
            }
            this.pullingY = true;
         }
         if(Key.isDown(37))
         {
            if(this.cannon._x > -98)
            {
               this.pullX -= 2;
            }
            else
            {
               this.motionX = 0;
            }
            this.pullingX = true;
         }
         if(Key.isDown(39))
         {
            if(this.cannon._x < 98)
            {
               this.pullX += 2;
            }
            else
            {
               this.motionX = 0;
            }
            this.pullingX = true;
         }
      }
      if(this.cannon._x > 4)
      {
         this.motionX -= Math.abs(this.cannon._x) * 0.5;
      }
      else if(this.cannon._x < -4)
      {
         this.motionX += Math.abs(this.cannon._x) * 0.5;
      }
      if(this.cannon._y > 4)
      {
         this.motionY -= Math.abs(this.cannon._y) * 0.5;
      }
      else if(this.cannon._y < -4)
      {
         this.motionY += Math.abs(this.cannon._y) * 0.5;
      }
      if(this.pullingX == true)
      {
         this.pullX *= 0.98;
         this.motionX += this.pullX;
      }
      else
      {
         this.pullX = 0;
      }
      if(this.pullingY == true)
      {
         this.pullY *= 0.98;
         this.motionY += this.pullY;
      }
      else
      {
         this.pullY = 0;
      }
      this.motionX *= 0.8;
      this.motionY *= 0.8;
      this.cannon._x += this.motionX;
      this.cannon._y += this.motionY;
      if(this.cannon._x > 98)
      {
         this.cannon._x = 98;
      }
      if(this.cannon._x < -98)
      {
         this.cannon._x = -98;
      }
      if(this.cannon._y > 166)
      {
         this.cannon._y = 166;
      }
      var _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie.art.ropeL._x,this.movie.art.ropeL._y,this.cannon._x,this.cannon._y - 15);
      this.movie.art.ropeL._rotation = _loc3_;
      _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie.art.ropeL._x,this.movie.art.ropeL._y,this.cannon._x,this.cannon._y - 15);
      this.movie.art.ropeL._xscale = _loc2_;
      _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie.art.ropeR._x,this.movie.art.ropeR._y,this.cannon._x,this.cannon._y - 15);
      this.movie.art.ropeR._rotation = _loc3_;
      _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie.art.ropeR._x,this.movie.art.ropeR._y,this.cannon._x,this.cannon._y - 15);
      this.movie.art.ropeR._xscale = _loc2_;
      if(this.inCannon == true)
      {
         this.game.playerObj.movie._x = this.movie._x + this.cannon._x;
         this.game.playerObj.movie._y = this.movie._y + this.cannon._y;
      }
      if(this.inCannon == true)
      {
         if(this.motionY < -20)
         {
            if(this.cannon._y < -4)
            {
               this.inCannon = false;
               this.game.playerObj.inCannon = false;
               this.cannon.window.puffle.gotoAndStop("none");
               this.game.playerObj.motionX = this.motionX / 5;
               this.game.playerObj.motionY = this.motionY;
               this.game.playerObj.movie._x += this.motionX;
               this.game.playerObj.movie._y += this.motionY;
               this.game.playerObj.motionR = Math.abs(this.motionX) + Math.abs(this.motionY);
               this.game.playerObj.skipNextBlur = true;
               this.game.playerObj.blurCharged = true;
            }
         }
      }
   }
}
