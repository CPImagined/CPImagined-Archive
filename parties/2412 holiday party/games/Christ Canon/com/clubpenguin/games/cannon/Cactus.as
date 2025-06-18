class com.clubpenguin.games.cannon.Cactus extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var settingN;
   var movie;
   var sizeX;
   var sizeY;
   var hidden;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function Cactus($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
   }
   function updateGameplay()
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
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
      }
      var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
      if(this.game.playerObj.inCannon == false)
      {
         _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
         if(_loc2_ < 50)
         {
            this.movie.art.gotoAndStop("bump");
            var _loc4_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
            var _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc4_,50);
            var _loc6_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc4_,50);
            this.game.playerObj.motionX = _loc5_ * 0.8;
            this.game.playerObj.motionY = _loc6_ * 0.8;
         }
      }
   }
}
