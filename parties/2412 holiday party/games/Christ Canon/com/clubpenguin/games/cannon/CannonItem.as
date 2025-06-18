class com.clubpenguin.games.cannon.CannonItem
{
   var game;
   var gameplayWorld;
   var gameplayHolder;
   var offsetX;
   var offsetY;
   var grabbed;
   var cannonHolder;
   var idNumber;
   var settingN;
   var inCannon;
   var movie;
   var rotClockwise;
   var cannonballMotionX;
   var cannonballMotionY;
   var sizeX;
   var sizeY;
   var hidden;
   var cannonballHolder;
   var puffleON;
   var wait;
   var waitDefault;
   var holdsTotal;
   var currentHold;
   var hold1;
   var hold2;
   var rot;
   var hold3;
   var hold4;
   var groundX;
   var groundY;
   var motionR;
   function CannonItem($game, $gameplayWorld, $gameplayHolder, $cannonHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      this.game = $game;
      this.gameplayWorld = $gameplayWorld;
      this.gameplayHolder = $gameplayHolder;
      this.offsetX = 0;
      this.offsetY = 0;
      this.grabbed = false;
      this.cannonHolder = $cannonHolder;
      this.idNumber = $idn;
      this.settingN = $settingN;
      this.inCannon = false;
      this.movie = this.cannonHolder.attachMovie("cannon","Obj" + $idn,$idn);
      this.movie._x = $posX;
      this.movie._y = $posY;
      this.movie._rotation = $posR;
      this.rotClockwise = true;
      this.cannonballMotionX = 0;
      this.cannonballMotionY = 0;
      this.movie.gotoAndStop(this.settingN);
      this.sizeX = this.movie._width;
      this.sizeY = this.movie._height;
      this.movie.gotoAndStop("hide");
      this.hidden = true;
      this.cannonballHolder = this.cannonHolder.createEmptyMovieClip("cannonballHolder",1000);
      this.puffleON = 0;
      if(this.settingN == 2)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 2;
         this.currentHold = 2;
         this.hold1 = -90;
         this.hold2 = 0;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 3)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 2;
         this.currentHold = 2;
         this.hold1 = -90;
         this.hold2 = -180;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 4)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 2;
         this.currentHold = 2;
         this.hold1 = 90;
         this.hold2 = 0;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 5)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 2;
         this.currentHold = 2;
         this.hold1 = 90;
         this.hold2 = 180;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 6)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 4;
         this.currentHold = 3;
         this.hold1 = -90;
         this.hold2 = 0;
         this.hold3 = 90;
         this.hold4 = 180;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 7)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 3;
         this.currentHold = 3;
         this.hold1 = -180;
         this.hold2 = -90;
         this.hold3 = 0;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 8)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 3;
         this.currentHold = 1;
         this.hold1 = 0;
         this.hold2 = 90;
         this.hold3 = 180;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 9)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 3;
         this.currentHold = 1;
         this.hold1 = 90;
         this.hold2 = 180;
         this.hold3 = 270;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 10)
      {
         this.wait = 0;
         this.waitDefault = 10;
         this.holdsTotal = 3;
         this.currentHold = 1;
         this.hold1 = -90;
         this.hold2 = 0;
         this.hold3 = 90;
         this.rot = this["hold" + this.currentHold];
         this.movie._rotation = this.rot;
      }
      else if(this.settingN == 12)
      {
         this.groundX = $posX;
         this.wait = 0;
         this.waitDefault = 0;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundX;
         this.hold2 = this.groundX + 240;
      }
      else if(this.settingN == 13)
      {
         this.groundY = $posY;
         this.wait = 0;
         this.waitDefault = 0;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundY;
         this.hold2 = this.groundY + 240;
      }
      else if(this.settingN == 14)
      {
         this.sizeY = this.sizeX;
      }
      else if(this.settingN == 15)
      {
         this.motionR = 0;
         this.sizeY = this.sizeX;
      }
      else if(this.settingN == 17)
      {
         this.groundX = $posX;
         this.wait = 0;
         this.waitDefault = 0;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundX;
         this.hold2 = this.groundX - 240;
      }
      else if(this.settingN == 18)
      {
         this.groundY = $posY;
         this.wait = 0;
         this.waitDefault = 0;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundY;
         this.hold2 = this.groundY - 240;
      }
      else if(this.settingN == 19)
      {
         this.groundX = $posX;
         this.wait = 0;
         this.waitDefault = 0;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundX;
         this.hold2 = this.groundX - 240;
      }
      else if(this.settingN == 20)
      {
         this.groundY = $posY;
         this.wait = 0;
         this.waitDefault = 0;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundY;
         this.hold2 = this.groundY - 240;
      }
      else if(this.settingN == 21)
      {
         this.groundX = $posX;
         this.wait = 0;
         this.waitDefault = 0;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundX;
         this.hold2 = this.groundX + 240;
      }
      else if(this.settingN == 22)
      {
         this.groundY = $posY;
         this.wait = 0;
         this.waitDefault = 0;
         this.holdsTotal = 2;
         this.currentHold = 1;
         this.hold1 = this.groundY;
         this.hold2 = this.groundY + 240;
      }
   }
   function updateEditor()
   {
      this.movie.gotoAndStop(this.settingN);
      this.movie.hint.gotoAndStop("show");
      this.movie.hint._rotation = - this.movie._rotation;
      if(this.grabbed == true)
      {
         if(this.game.brushObj.getGrabMode() == "drag")
         {
            this.movie._x = this.gameplayHolder._xmouse + this.offsetX;
            this.movie._y = this.gameplayHolder._ymouse + this.offsetY;
            this.movie._x = Math.round(this.movie._x / 10) * 10;
            this.movie._y = Math.round(this.movie._y / 10) * 10;
            this.estimatePath();
         }
         else if(this.game.brushObj.getGrabMode() == "rotate")
         {
            var _loc2_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie._x,this.movie._y,this.gameplayHolder._xmouse,this.gameplayHolder._ymouse);
            this.movie._rotation = _loc2_;
            this.movie.hint._rotation = - _loc2_;
            this.estimatePath();
         }
      }
   }
   function estimatePath()
   {
      var _loc2_ = 1;
      while(_loc2_ < 100)
      {
         this.cannonballHolder.attachMovie("cannonball","can" + _loc2_,_loc2_);
         var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(this.movie._rotation,50);
         var _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(this.movie._rotation,50);
         this.cannonballMotionX = _loc4_ * 0.8;
         this.cannonballMotionY = _loc5_ * 0.8;
         this.cannonballHolder["can" + _loc2_]._x = this.movie._x;
         this.cannonballHolder["can" + _loc2_]._y = this.movie._y;
         this.cannonballHolder["can" + _loc2_]._x += this.cannonballMotionX;
         this.cannonballHolder["can" + _loc2_]._y += this.cannonballMotionY;
         this.cannonballHolder["can" + _loc2_]._x += this.cannonballMotionX;
         this.cannonballHolder["can" + _loc2_]._y += this.cannonballMotionY;
         var _loc3_ = 1;
         while(_loc3_ < _loc2_)
         {
            this.cannonballMotionY += 1;
            this.cannonballMotionX *= 0.98;
            this.cannonballMotionY *= 0.98;
            this.cannonballHolder["can" + _loc2_]._x += this.cannonballMotionX;
            this.cannonballHolder["can" + _loc2_]._y += this.cannonballMotionY;
            _loc3_ += 1;
         }
         _loc2_ += 2;
      }
      if(Key.isDown(32))
      {
         this.puffleON = this.puffleON + 1;
         if(this.cannonballHolder["can" + this.puffleON]._x * 0 == 0)
         {
            this.game.generatePuffleO(Math.round(this.cannonballHolder["can" + this.puffleON]._x),Math.round(this.cannonballHolder["can" + this.puffleON]._y));
         }
      }
   }
   function updateGameplay($speedMod)
   {
      var _loc4_ = false;
      if(this.movie._x + this.sizeX > - this.gameplayHolder._x - this.gameplayWorld._x)
      {
         if(this.movie._x - this.sizeX < - this.gameplayHolder._x - this.gameplayWorld._x + 760)
         {
            if(this.movie._y + this.sizeY > - this.gameplayHolder._y - this.gameplayWorld._y)
            {
               if(this.movie._y - this.sizeY < - this.gameplayHolder._y - this.gameplayWorld._y + 480)
               {
                  _loc4_ = true;
               }
            }
         }
      }
      if(_loc4_ == true)
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
      var _loc6_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
      if(this.settingN == 1)
      {
         if(this.inCannon == false)
         {
            this.detectPuffle();
         }
         else if(this.inCannon == true)
         {
            this.game.playerObj.fire($speedMod);
         }
      }
      else if(this.settingN >= 2 && this.settingN <= 10)
      {
         if(this.inCannon == false)
         {
            this.detectPuffle();
         }
         else if(this.inCannon == true)
         {
            if(this.wait > 0)
            {
               this.wait = this.wait - 1;
            }
            else if(this.rot == this["hold" + this.currentHold])
            {
               this.wait = this.waitDefault;
               if(this.rotClockwise == true && this.currentHold < this.holdsTotal)
               {
                  this.currentHold = this.currentHold + 1;
               }
               else if(this.rotClockwise == false && this.currentHold > 1)
               {
                  this.currentHold = this.currentHold - 1;
               }
               else if(this.holdsTotal == 3)
               {
                  if(this.rotClockwise == true)
                  {
                     this.rotClockwise = false;
                     this.currentHold = this.currentHold - 1;
                  }
                  else
                  {
                     this.rotClockwise = true;
                     this.currentHold = this.currentHold + 1;
                  }
               }
               else if(this.holdsTotal == 4)
               {
                  this.rot *= -1;
                  this.currentHold = 1;
               }
               else
               {
                  this.currentHold = 1;
               }
            }
            else if(this.rot < this["hold" + this.currentHold])
            {
               this.rot += 10 * $speedMod;
               if(this.rot > this["hold" + this.currentHold])
               {
                  this.rot = this["hold" + this.currentHold];
               }
               this.movie._rotation = this.rot;
            }
            else if(this.rot > this["hold" + this.currentHold])
            {
               this.rot -= 10 * $speedMod;
               if(this.rot < this["hold" + this.currentHold])
               {
                  this.rot = this["hold" + this.currentHold];
               }
               this.movie._rotation = this.rot;
            }
         }
      }
      else if(this.settingN == 11)
      {
         if(this.inCannon == false)
         {
            this.detectPuffle();
         }
      }
      else if(this.settingN == 12 || this.settingN == 17 || this.settingN == 19 || this.settingN == 21)
      {
         if(this.settingN == 19 || this.settingN == 21)
         {
            var _loc2_ = true;
         }
         if(this.inCannon == false)
         {
            this.detectPuffle();
            if(_loc2_ != true)
            {
               if(this.movie._x != this.hold1)
               {
                  if(this.movie._x == this["hold" + this.currentHold])
                  {
                     if(this.currentHold < this.holdsTotal)
                     {
                        this.currentHold = this.currentHold + 1;
                     }
                     else
                     {
                        this.currentHold = 1;
                     }
                  }
                  else if(this.movie._x < this["hold" + this.currentHold])
                  {
                     this.movie._x += 10;
                     if(this.movie._x > this["hold" + this.currentHold])
                     {
                        this.movie._x = this["hold" + this.currentHold];
                     }
                  }
                  else if(this.movie._x > this["hold" + this.currentHold])
                  {
                     this.movie._x -= 10;
                     if(this.movie._x < this["hold" + this.currentHold])
                     {
                        this.movie._x = this["hold" + this.currentHold];
                     }
                  }
               }
            }
            if(_loc2_ == true)
            {
               if(this.movie._x == this["hold" + this.currentHold])
               {
                  if(this.currentHold < this.holdsTotal)
                  {
                     this.currentHold = this.currentHold + 1;
                  }
                  else
                  {
                     this.currentHold = 1;
                  }
               }
               else if(this.movie._x < this["hold" + this.currentHold])
               {
                  this.movie._x += 10;
                  if(this.movie._x > this["hold" + this.currentHold])
                  {
                     this.movie._x = this["hold" + this.currentHold];
                  }
               }
               else if(this.movie._x > this["hold" + this.currentHold])
               {
                  this.movie._x -= 10;
                  if(this.movie._x < this["hold" + this.currentHold])
                  {
                     this.movie._x = this["hold" + this.currentHold];
                  }
               }
            }
         }
         else if(this.inCannon == true)
         {
            if(this.movie._x == this["hold" + this.currentHold])
            {
               if(this.currentHold < this.holdsTotal)
               {
                  this.currentHold = this.currentHold + 1;
               }
               else
               {
                  this.currentHold = 1;
               }
            }
            else
            {
               if(this.movie._x < this["hold" + this.currentHold])
               {
                  this.movie._x += 10;
                  if(this.movie._x > this["hold" + this.currentHold])
                  {
                     this.movie._x = this["hold" + this.currentHold];
                  }
               }
               else if(this.movie._x > this["hold" + this.currentHold])
               {
                  this.movie._x -= 10;
                  if(this.movie._x < this["hold" + this.currentHold])
                  {
                     this.movie._x = this["hold" + this.currentHold];
                  }
               }
               this.game.playerObj.movie._x = this.movie._x;
            }
         }
      }
      else if(this.settingN == 13 || this.settingN == 18 || this.settingN == 20 || this.settingN == 22)
      {
         if(this.settingN == 20 || this.settingN == 22)
         {
            _loc2_ = true;
         }
         if(this.inCannon == false)
         {
            this.detectPuffle();
            if(_loc2_ != true)
            {
               if(this.movie._y != this.hold1)
               {
                  if(this.movie._y == this["hold" + this.currentHold])
                  {
                     if(this.currentHold < this.holdsTotal)
                     {
                        this.currentHold = this.currentHold + 1;
                     }
                     else
                     {
                        this.currentHold = 1;
                     }
                  }
                  else if(this.movie._y < this["hold" + this.currentHold])
                  {
                     this.movie._y += 10;
                     if(this.movie._y > this["hold" + this.currentHold])
                     {
                        this.movie._y = this["hold" + this.currentHold];
                     }
                  }
                  else if(this.movie._y > this["hold" + this.currentHold])
                  {
                     this.movie._y -= 10;
                     if(this.movie._y < this["hold" + this.currentHold])
                     {
                        this.movie._y = this["hold" + this.currentHold];
                     }
                  }
               }
            }
            if(_loc2_ == true)
            {
               if(this.movie._y == this["hold" + this.currentHold])
               {
                  if(this.currentHold < this.holdsTotal)
                  {
                     this.currentHold = this.currentHold + 1;
                  }
                  else
                  {
                     this.currentHold = 1;
                  }
               }
               else if(this.movie._y < this["hold" + this.currentHold])
               {
                  this.movie._y += 10;
                  if(this.movie._y > this["hold" + this.currentHold])
                  {
                     this.movie._y = this["hold" + this.currentHold];
                  }
               }
               else if(this.movie._y > this["hold" + this.currentHold])
               {
                  this.movie._y -= 10;
                  if(this.movie._y < this["hold" + this.currentHold])
                  {
                     this.movie._y = this["hold" + this.currentHold];
                  }
               }
            }
         }
         else if(this.inCannon == true)
         {
            if(this.movie._y == this["hold" + this.currentHold])
            {
               if(this.currentHold < this.holdsTotal)
               {
                  this.currentHold = this.currentHold + 1;
               }
               else
               {
                  this.currentHold = 1;
               }
            }
            else
            {
               if(this.movie._y < this["hold" + this.currentHold])
               {
                  this.movie._y += 10;
                  if(this.movie._y > this["hold" + this.currentHold])
                  {
                     this.movie._y = this["hold" + this.currentHold];
                  }
               }
               else if(this.movie._y > this["hold" + this.currentHold])
               {
                  this.movie._y -= 10;
                  if(this.movie._y < this["hold" + this.currentHold])
                  {
                     this.movie._y = this["hold" + this.currentHold];
                  }
               }
               this.game.playerObj.movie._y = this.movie._y;
            }
         }
      }
      else if(this.settingN == 14)
      {
         if(this.inCannon == false)
         {
            this.detectPuffle();
         }
         else if(this.inCannon == true)
         {
            this.movie._rotation += 8;
         }
      }
      else if(this.settingN == 15)
      {
         if(this.inCannon == false)
         {
            this.detectPuffle();
         }
         else if(this.inCannon == true)
         {
            var _loc3_ = false;
            if(Key.isDown(37))
            {
               this.motionR -= 2;
               _loc3_ = true;
            }
            if(Key.isDown(39))
            {
               this.motionR += 2;
               _loc3_ = true;
            }
         }
         if(_loc3_ == true)
         {
            this.motionR *= 0.8;
         }
         else
         {
            this.motionR *= 0.7;
         }
         this.movie._rotation += this.motionR;
      }
      else if(this.settingN == 16)
      {
         if(this.inCannon == false)
         {
            this.detectPuffle();
         }
         else if(this.inCannon == true)
         {
            this.game.playerObj.startX = this.movie._x;
            this.game.playerObj.startY = this.movie._y - 60;
            this.movie.art.flaggy.gotoAndStop("show");
            this.game.playerObj.fire($speedMod);
         }
      }
      else if(this.settingN == 23)
      {
         if(this.inCannon == false)
         {
            this.detectPuffle();
         }
         else if(this.inCannon == true)
         {
            this.movie.art.art.charge.gotoAndStop("charge");
         }
      }
   }
   function shoot()
   {
      this.inCannon = false;
      this.movie.art.gotoAndStop("still");
      this.movie.art.gotoAndStop("fire");
      if(this.settingN == 23)
      {
         this.game.forceSlowMode = true;
      }
   }
   function detectPuffle()
   {
      if(this.game.playerObj.inCannon == false)
      {
         var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
         if(_loc2_ < 40)
         {
            this.game.playerObj.inCannon = true;
            this.inCannon = true;
            this.game.forceSlowMode = false;
            this.game.playerObj.motionX = 0;
            this.game.playerObj.motionY = 0;
            this.game.playerObj.movie._x = this.movie._x;
            this.game.playerObj.movie._y = this.movie._y;
            this.movie.art.gotoAndStop("still");
            this.movie.art.art.window.puffle.gotoAndStop(this.game.playerColor);
            this.game.playerObj.isIn = this;
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
                  this.game.removeObject(this,this.game.level1cannonArray);
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
