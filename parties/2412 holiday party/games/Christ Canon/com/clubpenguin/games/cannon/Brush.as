class com.clubpenguin.games.cannon.Brush
{
   var hud;
   var movie;
   var settingN;
   var itemType;
   var grabMode;
   var grabbing;
   var gameplayWorld;
   var bgArtHolder;
   function Brush($hud, $gameplayWorld, $bgArtHolder)
   {
      this.hud = $hud;
      this.movie = this.hud.attachMovie("brush","brush",100);
      this.movie._x = _xmouse;
      this.movie._y = _ymouse;
      this.settingN = 0;
      this.itemType = "none";
      this.grabMode = "drag";
      this.grabbing = false;
      this.movie.gotoAndStop(this.itemType);
      this.movie.art.gotoAndStop(this.settingN);
      this.gameplayWorld = $gameplayWorld;
      this.bgArtHolder = $bgArtHolder;
   }
   function update()
   {
      this.movie._x = _xmouse;
      this.movie._y = _ymouse;
      this.movie._x = Math.round(this.movie._x / 10) * 10;
      this.movie._y = Math.round(this.movie._y / 10) * 10;
      if(this.movie._x < 615)
      {
         this.movie._alpha = 100;
      }
      else
      {
         this.movie._alpha = 40;
      }
      if(this.movie._xscale < this.gameplayWorld._xscale)
      {
         this.movie._xscale += 5;
         this.movie._yscale += 5;
      }
      else if(this.movie._xscale > this.gameplayWorld._xscale)
      {
         this.movie._xscale = this.gameplayWorld._xscale;
         this.movie._yscale = this.gameplayWorld._yscale;
      }
   }
   function selectItem($item, $settingN)
   {
      if(this.settingN == $settingN && this.itemType == $item)
      {
         this.itemType = "none";
         this.settingN = 0;
      }
      else
      {
         this.settingN = $settingN;
         this.itemType = $item;
      }
      this.movie.gotoAndStop(this.itemType);
      this.movie.art.gotoAndStop(this.settingN);
   }
   function setGrabMode($grabMode)
   {
      this.itemType = "none";
      this.settingN = 0;
      this.grabMode = $grabMode;
      this.movie.gotoAndStop(this.itemType);
      this.movie.art.gotoAndStop(this.settingN);
   }
   function setGrabbing($grabbing)
   {
      this.grabbing = $grabbing;
   }
   function getItemType(Void)
   {
      return this.itemType;
   }
   function getSettingN(Void)
   {
      return this.settingN;
   }
   function getGrabMode(Void)
   {
      return this.grabMode;
   }
   function getGrabbing(Void)
   {
      return this.grabbing;
   }
   function getXpos(Void)
   {
      return this.movie._x;
   }
   function getYpos(Void)
   {
      return this.movie._y;
   }
   function paintValid(Void)
   {
      if(this.movie._x < 615 && this.settingN != 0)
      {
         return true;
      }
      return false;
   }
   function grabValid(Void)
   {
      if(this.movie._x < 615)
      {
         return true;
      }
      return false;
   }
   function mouseClick()
   {
      if(this.paintValid())
      {
         this.movie._xscale *= 0.8;
         this.movie._yscale *= 0.8;
      }
   }
}
