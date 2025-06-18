class com.clubpenguin.games.cannon.PuffleOItem
{
   var game;
   var gameplayWorld;
   var gameplayHolder;
   var grabbed;
   var offsetX;
   var offsetY;
   var puffleOHolder;
   var idNumber;
   var settingN;
   var movie;
   var groundX;
   var groundY;
   var collected;
   var motionX;
   var motionY;
   var sizeX;
   var sizeY;
   var hidden;
   var donePoofing;
   function PuffleOItem($game, $gameplayWorld, $gameplayHolder, $puffleOHolder, $idn, $posX, $posY, $settingN)
   {
      this.game = $game;
      this.gameplayWorld = $gameplayWorld;
      this.gameplayHolder = $gameplayHolder;
      this.grabbed = false;
      this.offsetX = 0;
      this.offsetY = 0;
      this.puffleOHolder = $puffleOHolder;
      this.idNumber = $idn;
      this.settingN = $settingN;
      this.movie = this.puffleOHolder.attachMovie("puffleO","Obj" + $idn,$idn);
      this.movie._x = $posX;
      this.movie._y = $posY;
      this.groundX = $posX;
      this.groundY = $posY;
      this.collected = false;
      this.motionX = 0;
      this.motionY = 0;
      this.movie.master = this;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.donePoofing = false;
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
            this.movie._x = Math.round(this.movie._x / 4) * 4;
            this.movie._y = Math.round(this.movie._y / 4) * 4;
         }
      }
   }
   function updateGameplay()
   {
      var _loc5_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc5_ = true;
               }
            }
         }
      }
      if(_loc5_ == true)
      {
         if(this.collected == false)
         {
            if(this.hidden == true)
            {
               this.movie.gotoAndStop("still");
               this.hidden = false;
            }
         }
         else if(this.donePoofing == true)
         {
            if(this.hidden == true)
            {
               this.movie.gotoAndStop("done");
               this.hidden = false;
            }
         }
      }
      else if(this.collected == false)
      {
         if(this.hidden == false)
         {
            this.movie.gotoAndStop("hide");
            this.hidden = true;
         }
      }
      else if(this.donePoofing == true)
      {
         if(this.hidden == false)
         {
            this.movie.gotoAndStop("hide");
            this.hidden = true;
         }
      }
      if(this.collected == false)
      {
         var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
         if(_loc2_ < 40)
         {
            this.game.collectPuffleO();
            this.movie.gotoAndStop("collected");
            this.collected = true;
         }
      }
      if(this.collected == false)
      {
         if(this.game.magnetism == true)
         {
            if(this.game.magnet.alive == true)
            {
               var _loc4_ = this.game.magnet.movie._x + this.game.magnetOffsetX;
               var _loc6_ = this.game.magnet.movie._y + this.game.magnetOffsetY;
               _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,_loc4_,_loc6_);
               if(_loc2_ < 300)
               {
                  var _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie._x,this.movie._y,_loc4_,_loc6_);
                  var _loc7_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,(300 - _loc2_) / 100);
                  var _loc8_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,(300 - _loc2_) / 100);
                  this.motionX += _loc7_;
                  this.motionY += _loc8_;
               }
               this.motionX *= 0.9;
               this.motionY *= 0.9;
               this.movie._x += this.motionX;
               this.movie._y += this.motionY;
               if(_loc2_ < 40)
               {
                  this.movie.gotoAndStop("collected");
                  this.collected = true;
                  if(this.game.magnet.collidable == true)
                  {
                     this.game.magnet.movie.art.art.gotoAndStop(1);
                     this.game.magnet.movie.art.art.gotoAndStop("laugh");
                  }
               }
            }
         }
      }
   }
   function resetPosition()
   {
      this.movie._x = this.groundX;
      this.movie._y = this.groundY;
      this.donePoofing = true;
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
                  this.game.removeObject(this,this.game.level1puffleOArray);
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
