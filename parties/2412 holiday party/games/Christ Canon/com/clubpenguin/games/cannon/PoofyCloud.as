class com.clubpenguin.games.cannon.PoofyCloud extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var groundX;
   var movie;
   var groundY;
   var dissipated;
   var settingN;
   var sizeX;
   var sizeY;
   var hidden;
   var gameplayHolder;
   var gameplayWorld;
   var game;
   function PoofyCloud($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$posR,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.dissipated = false;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
   }
   function updateGameplay($speedMod)
   {
      var _loc2_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc2_ = true;
               }
            }
         }
      }
      if(_loc2_ == true)
      {
         if(this.dissipated == false)
         {
            if(this.hidden == true)
            {
               this.movie.gotoAndStop(this.settingN);
               this.movie.art.gotoAndStop("gameplay");
               this.hidden = false;
            }
         }
      }
      else if(this.hidden == false)
      {
         this.movie.gotoAndStop("hide");
         this.hidden = true;
      }
      if(this.game.playerObj.inCannon == false)
      {
         var _loc3_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
         if(_loc3_ < 90)
         {
            this.movie.art.art.master = this;
            this.movie.art.art.gotoAndStop("poof");
            this.dissipated = true;
         }
      }
   }
   function destroy()
   {
      this.movie.removeMovieClip();
   }
}
