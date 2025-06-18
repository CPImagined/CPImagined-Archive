class com.clubpenguin.games.cannon.StartIcon
{
   var grabbed;
   var game;
   var iconHolder;
   var movie;
   var offsetX;
   var offsetY;
   function StartIcon($game, $iconHolder, $posX, $posY)
   {
      this.grabbed = false;
      this.game = $game;
      this.iconHolder = $iconHolder;
      this.movie = this.iconHolder.attachMovie("iconstart","iconstart",1);
      this.movie._x = $posX;
      this.movie._y = $posY;
      if($posX * 0 != 0)
      {
         this.movie._x = 0;
      }
      if($posY * 0 != 0)
      {
         this.movie._y = 0;
      }
      this.offsetX = 0;
      this.offsetY = 0;
   }
   function update()
   {
      if(this.grabbed == true)
      {
         if(this.game.brushObj.getGrabMode() == "drag")
         {
            this.movie._x = this.game.gameplayHolder._xmouse + this.offsetX;
            this.movie._y = this.game.gameplayHolder._ymouse + this.offsetY;
            this.movie._x = Math.round(this.movie._x / 10) * 10;
            this.movie._y = Math.round(this.movie._y / 10) * 10;
         }
      }
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
                     if(this.movie._x > this.game.gameplayHolder._xmouse)
                     {
                        this.offsetX = this.movie._x - this.game.gameplayHolder._xmouse;
                     }
                     else if(this.movie._x < this.game.gameplayHolder._xmouse)
                     {
                        this.offsetX = (this.game.gameplayHolder._xmouse - this.movie._x) * -1;
                     }
                     else
                     {
                        this.offsetX = 0;
                     }
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
}
