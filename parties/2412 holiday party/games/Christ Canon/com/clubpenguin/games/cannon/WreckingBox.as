class com.clubpenguin.games.cannon.WreckingBox extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var groundX;
   var movie;
   var groundY;
   var defaultGroundY;
   var motionX;
   var motionY;
   var elasticMultiplier;
   var elasticMultiplierDefault;
   var settingN;
   var sizeX;
   var sizeY;
   var hidden;
   var defaultSwingX;
   var swingX;
   var swingCountDefault;
   var swingCount;
   var game;
   var gameplayHolder;
   var gameplayWorld;
   function WreckingBox($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.defaultGroundY = this.movie._y;
      this.motionX = 0;
      this.motionY = 0;
      this.elasticMultiplier = 0.02;
      this.elasticMultiplierDefault = 0.02;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height + 700;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.movie.master = this;
      this.defaultSwingX = 2;
      this.swingX = this.defaultSwingX;
      this.swingCountDefault = 100;
      this.swingCount = this.swingCountDefault;
   }
   function updateGameplay($speedMod)
   {
      if(this.swingCount > 0)
      {
         this.swingCount = this.swingCount - 1;
      }
      else
      {
         this.swingCount = this.swingCountDefault;
         this.swingX *= -1;
      }
      this.motionX += this.swingX;
      if(this.game.gravityInverted == false)
      {
         this.motionY += 2;
      }
      else if(this.game.gravityInverted == true)
      {
         this.motionY -= 2;
      }
      var _loc8_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc8_ = true;
               }
            }
         }
      }
      if(_loc8_ == true)
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
      var _loc6_ = this.movie._x + this.movie.art._x + this.movie.art.box._x;
      var _loc7_ = this.movie._y + this.movie.art._y + this.movie.art.box._y;
      if(this.game.playerObj.inCannon == false)
      {
         var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(_loc6_,_loc7_,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
         if(_loc2_ < 56)
         {
            var _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.playerObj.movie._x,this.game.playerObj.movie._y,_loc6_,_loc7_);
            var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,30);
            var _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,30);
            this.motionX += _loc4_ * 2;
            this.motionY += _loc5_ * 2;
            this.game.playerObj.motionX = _loc4_ * -1;
            this.game.playerObj.motionY = _loc5_ * -1;
            this.game.playerObj.motionR = Math.abs(_loc4_) + Math.abs(_loc5_);
         }
      }
      _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(_loc6_,_loc7_,this.groundX,this.groundY);
      if(_loc2_ > 1)
      {
         _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.groundX,this.groundY,_loc6_,_loc7_);
         _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,_loc2_ / 100);
         _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,_loc2_ / 100);
         this.motionX -= _loc4_;
         this.motionY -= _loc5_;
      }
      this.motionX *= 1 - 0.2 * $speedMod;
      this.motionY *= 1 - 0.2 * $speedMod;
      this.movie.art.box._x += this.motionX * $speedMod;
      this.movie.art.box._y += this.motionY * $speedMod;
      _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie.art.rope._x,this.movie.art.rope._y,this.movie.art.box._x,this.movie.art.box._y - 15);
      this.movie.art.rope._rotation = _loc3_;
      _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie.art.rope._x,this.movie.art.rope._y,this.movie.art.box._x,this.movie.art.box._y - 15);
      this.movie.art.rope._xscale = _loc2_;
   }
}
