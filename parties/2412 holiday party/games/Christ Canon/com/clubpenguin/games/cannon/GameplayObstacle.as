class com.clubpenguin.games.cannon.GameplayObstacle
{
   var game;
   var gameplayWorld;
   var gameplayHolder;
   var obstacleHolder;
   var idNumber;
   var settingN;
   var movie;
   function GameplayObstacle($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      this.game = $game;
      this.gameplayWorld = $gameplayWorld;
      this.gameplayHolder = $gameplayHolder;
      this.obstacleHolder = $obstacleHolder;
      this.idNumber = $idn;
      this.settingN = $settingN;
      this.movie = this.obstacleHolder.attachMovie("obstacle","Obj" + $idn,$idn);
      this.movie._x = $posX;
      this.movie._y = $posY;
      this.movie._rotation = $posR;
   }
   function destroy()
   {
      this.movie.removeMovieClip();
   }
}
