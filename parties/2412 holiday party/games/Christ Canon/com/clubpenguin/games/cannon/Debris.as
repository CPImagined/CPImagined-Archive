class com.clubpenguin.games.cannon.Debris
{
   var game;
   var gameplayWorld;
   var gameplayHolder;
   var particleHolder;
   var idNumber;
   var settingN;
   var movie;
   var motionX;
   var motionY;
   var motionR;
   function Debris($game, $gameplayWorld, $gameplayHolder, $particleHolder, $idn, $posX, $posY, $settingN, $motionX, $motionY)
   {
      super($game,$gameplayWorld,$gameplayHolder,$particleHolder,$idn,$posX,$posY,$settingN);
      this.game = $game;
      this.gameplayWorld = $gameplayWorld;
      this.gameplayHolder = $gameplayHolder;
      this.particleHolder = $particleHolder;
      this.idNumber = $idn;
      this.settingN = $settingN;
      this.movie = this.particleHolder.attachMovie("debris","Obj" + $idn,$idn);
      this.movie._x = $posX;
      this.movie._y = $posY;
      this.movie.gotoAndStop(this.settingN);
      this.motionX = $motionX;
      this.motionY = $motionY;
      this.motionX *= random(15) / 10;
      this.motionY *= random(15) / 10;
      this.motionR = Math.abs(this.motionX) + Math.abs(this.motionY);
   }
   function updateGameplay()
   {
      this.motionY += 1;
      this.motionX *= 0.98;
      this.motionY *= 0.98;
      this.motionR *= 0.98;
      this.movie._x += this.motionX;
      this.movie._y += this.motionY;
      this.movie._rotation += this.motionR;
      if(this.movie._y > this.game.fallZoneObj.movie._y)
      {
         this.game.removeObject(this,this.game.debrisArray);
      }
   }
}
