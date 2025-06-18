class com.clubpenguin.games.cannon.GiantPuffleO
{
   var grabbed;
   var game;
   var iconHolder;
   var movie;
   var startX;
   var startY;
   var motionX;
   var motionY;
   var moveSpeed;
   var offsetX;
   var offsetY;
   var hasBox;
   function GiantPuffleO($game, $iconHolder, $posX, $posY)
   {
      this.grabbed = false;
      this.game = $game;
      this.iconHolder = $iconHolder;
      this.movie = this.iconHolder.attachMovie("giantPuffleO","giantPuffleO",2);
      this.movie._x = $posX;
      this.movie._y = $posY;
      this.startX = $posX;
      this.startY = $posY;
      this.motionX = 0;
      this.motionY = 0;
      this.moveSpeed = 0.01;
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
      this.hasBox = false;
   }
   function updateEditor()
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
   function updateGameplay()
   {
      if(this.game.playerObj.inCannon == false)
      {
         var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
         if(_loc2_ < 50)
         {
            this.game.forceSlowMode = false;
            this.game.exitSloMo();
            if(this.hasBox == true)
            {
               this.movie.gotoAndStop("completebox");
            }
            else
            {
               this.movie.gotoAndStop("complete");
            }
            this.movie.game = this.game;
            this.game.gamePaused = true;
            this.game.playerObj.movie._visible = false;
         }
      }
      if(this.movie._x > this.startX)
      {
         this.motionX -= Math.abs(this.movie._x - this.startX) * this.moveSpeed;
      }
      else if(this.movie._x < this.startX)
      {
         this.motionX += Math.abs(this.movie._x - this.startX) * this.moveSpeed;
      }
      if(this.movie._y > this.startY)
      {
         this.motionY -= Math.abs(this.movie._y - this.startY) * this.moveSpeed;
      }
      else if(this.movie._y < this.startY)
      {
         this.motionY += Math.abs(this.movie._y - this.startY) * this.moveSpeed;
      }
      this.motionX *= 0.9;
      this.motionY *= 0.9;
      this.movie._x += this.motionX;
      this.movie._y += this.motionY;
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
   function destroy()
   {
      this.movie.removeMovieClip();
   }
}
