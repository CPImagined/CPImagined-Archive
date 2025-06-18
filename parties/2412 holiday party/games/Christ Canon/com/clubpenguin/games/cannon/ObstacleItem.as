class com.clubpenguin.games.cannon.ObstacleItem
{
   var game;
   var gameplayWorld;
   var gameplayHolder;
   var grabbed;
   var offsetX;
   var offsetY;
   var obstacleHolder;
   var idNumber;
   var settingN;
   var movie;
   function ObstacleItem($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      this.game = $game;
      this.gameplayWorld = $gameplayWorld;
      this.gameplayHolder = $gameplayHolder;
      this.grabbed = false;
      this.offsetX = 0;
      this.offsetY = 0;
      this.obstacleHolder = $obstacleHolder;
      this.idNumber = $idn;
      this.settingN = $settingN;
      this.movie = this.obstacleHolder.attachMovie("obstacle","Obj" + $idn,$idn);
      this.movie._x = $posX;
      this.movie._y = $posY;
      this.movie._rotation = $posR;
      this.movie.gotoAndStop($settingN);
   }
   function updateEditor()
   {
      this.movie.hint.gotoAndStop("show");
      if(this.grabbed == true)
      {
         if(this.game.brushObj.getGrabMode() == "drag")
         {
            this.movie._x = this.gameplayHolder._xmouse + this.offsetX;
            this.movie._y = this.gameplayHolder._ymouse + this.offsetY;
            this.movie._x = Math.round(this.movie._x / 10) * 10;
            this.movie._y = Math.round(this.movie._y / 10) * 10;
         }
         else if(this.game.brushObj.getGrabMode() == "rotate")
         {
            if(this.settingN == 30)
            {
               var _loc2_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie._x,this.movie._y,this.gameplayHolder._xmouse,this.gameplayHolder._ymouse);
               this.movie._rotation = _loc2_;
               this.movie.hint._rotation = - _loc2_;
            }
         }
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
                  this.game.removeObject(this,this.game.level1obstacleArray);
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
