class com.clubpenguin.games.cannon.FallZone
{
   var grabbed;
   var game;
   var skyN;
   var movie;
   var offsetY;
   function FallZone($game, $posY, $sky, $d)
   {
      this.grabbed = false;
      this.game = $game;
      this.skyN = $sky;
      this.movie = this.game.gameplayHolder.fallZoneHolder.attachMovie("fallZone","fallZone",$d);
      this.movie._y = $posY;
      if($posY * 0 != 0)
      {
         this.movie._y = 0;
      }
      this.offsetY = 0;
      this.movie.gotoAndStop(this.game.gameMode);
      this.movie.art.gotoAndStop(this.skyN);
   }
   function updateEditor()
   {
      if(this.grabbed == true)
      {
         if(this.game.brushObj.getGrabMode() == "drag")
         {
            this.movie._y = this.game.gameplayHolder._ymouse + this.offsetY;
            this.movie._y = Math.round(this.movie._y / 10) * 10;
         }
      }
   }
   function updateGameplay($speedMod)
   {
      this.game.gameplayHolder.fallZoneHolder._x = this.game.gameplayHolder._x * -1;
   }
   function hidden()
   {
      this.movie._visible = false;
   }
   function mouseClick()
   {
      if(this.game.brushObj.grabValid())
      {
         if(this.movie.hitTest(_xmouse,_ymouse,true))
         {
            if(this.game.brushObj.getSettingN() == 0)
            {
               if(this.game.brushObj.getGrabMode() == "drag")
               {
                  if(this.game.brushObj.getGrabbing() == false)
                  {
                     this.game.brushObj.setGrabbing(true);
                     this.grabbed = true;
                     if(this.movie._y > this.game.gameplayHolder._ymouse)
                     {
                        this.offsetY = this.movie._y - this.game.gameplayHolder._ymouse;
                     }
                     else if(this.movie._y < this.game.gameplayHolder._ymouse)
                     {
                        this.offsetY = (this.game.gameplayHolder._ymouse - this.movie._y) * -1;
                     }
                     else
                     {
                        this.offsetY = 0;
                     }
                  }
               }
            }
         }
      }
   }
   function mouseRelease()
   {
      if(this.grabbed == true)
      {
         this.grabbed = false;
         this.game.brushObj.setGrabbing(false);
      }
   }
   function destroy()
   {
      this.movie.removeMovieClip();
   }
}
