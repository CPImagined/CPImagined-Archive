class com.clubpenguin.games.cannon.BgArtItem
{
   var game;
   var gameplayWorld;
   var gameplayHolder;
   var grabbed;
   var offsetX;
   var offsetY;
   var bgArtHolder;
   var idNumber;
   var settingN;
   var movie;
   var sizeX;
   var sizeY;
   var hidden;
   function BgArtItem($game, $gameplayWorld, $gameplayHolder, $bgArtHolder, $idn, $posX, $posY, $settingN)
   {
      this.game = $game;
      this.gameplayWorld = $gameplayWorld;
      this.gameplayHolder = $gameplayHolder;
      this.grabbed = false;
      this.offsetX = 0;
      this.offsetY = 0;
      this.bgArtHolder = $bgArtHolder;
      this.idNumber = $idn;
      this.settingN = $settingN;
      this.movie = this.bgArtHolder.attachMovie("bgArt","Obj" + $idn,$idn);
      this.movie._x = $posX;
      this.movie._y = $posY;
      this.movie.cacheAsBitmap = true;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      if(this.settingN == 51)
      {
         this.sizeX = 100000;
         this.sizeY = 100000;
      }
   }
   function updateEditor()
   {
      this.movie.gotoAndStop(this.settingN);
      if(this.grabbed == true)
      {
         if(this.game.brushObj.getGrabMode() == "drag")
         {
            this.movie._x = this.gameplayHolder._xmouse + this.offsetX;
            this.movie._y = this.gameplayHolder._ymouse + this.offsetY;
            this.movie._x = Math.round(this.movie._x / 10) * 10;
            this.movie._y = Math.round(this.movie._y / 10) * 10;
         }
      }
   }
   function updateGameplay()
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
   }
   function mouseClick()
   {
      if(this.game.brushObj.grabValid())
      {
         if(this.movie.hitTest(_xmouse,_ymouse,true))
         {
            if(this.game.brushObj.getSettingN() == 0)
            {
               if(this.game.brushObj.getGrabMode() == "drag" || this.game.brushObj.getGrabMode() == "rotate")
               {
                  if(this.game.brushObj.getGrabbing() == false)
                  {
                     this.game.brushObj.setGrabbing(true);
                     this.grabbed = true;
                     if(this.movie._x > this.gameplayHolder._xmouse)
                     {
                        this.offsetX = this.movie._x - this.gameplayHolder._xmouse;
                     }
                     else if(this.movie._x < this.gameplayHolder._xmouse)
                     {
                        this.offsetX = (this.gameplayHolder._xmouse - this.movie._x) * -1;
                     }
                     else
                     {
                        this.offsetX = 0;
                     }
                     if(this.movie._y > this.gameplayHolder._ymouse)
                     {
                        this.offsetY = this.movie._y - this.gameplayHolder._ymouse;
                     }
                     else if(this.movie._y < this.gameplayHolder._ymouse)
                     {
                        this.offsetY = (this.gameplayHolder._ymouse - this.movie._y) * -1;
                     }
                     else
                     {
                        this.offsetY = 0;
                     }
                  }
               }
               else if(this.game.brushObj.getGrabMode() == "erase")
               {
                  this.game.removeObject(this,this.game.level1bgArtArray);
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
