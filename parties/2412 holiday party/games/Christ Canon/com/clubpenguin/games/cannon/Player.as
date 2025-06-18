class com.clubpenguin.games.cannon.Player
{
   var game;
   var gameplayWorld;
   var gameplayHolder;
   var blurHolder;
   var playerColor;
   var spaceUp;
   var spaceDown;
   var spacePress;
   var leftKeyUp;
   var leftKeyDown;
   var leftKeyPress;
   var rightKeyUp;
   var rightKeyDown;
   var rightKeyPress;
   var inCannon;
   var blurN;
   var blurMax;
   var blurCharged;
   var skipNextBlur;
   var alive;
   var pushX;
   var pushY;
   var motionX;
   var motionY;
   var motionR;
   var movie;
   var startX;
   var startY;
   var halfPosX;
   var halfPosY;
   var ground;
   var skyN;
   var camLocked;
   var camMotionX;
   var camMotionY;
   var camChasePull;
   var camChaseFriction;
   var camTarget;
   var tap0FrameBack;
   var tap1FrameBack;
   var tap2FrameBack;
   var tap3FrameBack;
   var tap4FrameBack;
   var tap5FrameBack;
   var shareFrame;
   var isIn;
   var onethirdPosX;
   var onethirdPosY;
   var camTargetTimeN;
   var shareFrameTarget;
   function Player($game, $gameplayWorld, $gameplayHolder, $blurHolder, $posX, $posY, $playerColor, $ground, $skyN)
   {
      this.game = $game;
      this.gameplayWorld = $gameplayWorld;
      this.gameplayHolder = $gameplayHolder;
      this.gameplayHolder._x = 0;
      this.gameplayHolder._y = 0;
      this.blurHolder = $blurHolder;
      this.playerColor = $playerColor;
      this.spaceUp = true;
      this.spaceDown = false;
      this.spacePress = false;
      this.leftKeyUp = true;
      this.leftKeyDown = false;
      this.leftKeyPress = false;
      this.rightKeyUp = true;
      this.rightKeyDown = false;
      this.rightKeyPress = false;
      this.inCannon = false;
      this.blurN = 2;
      this.blurMax = 20;
      this.blurCharged = false;
      this.skipNextBlur = true;
      this.alive = true;
      this.pushX = 0;
      this.pushY = 0;
      this.motionX = 0;
      this.motionY = 0;
      this.motionR = 0;
      this.movie = this.gameplayHolder.attachMovie("player","player",9);
      this.startX = $posX;
      this.startY = $posY;
      this.movie._x = this.startX;
      this.movie._y = this.startY;
      this.halfPosX = this.startX;
      this.halfPosY = this.startY;
      this.movie.gotoAndStop(this.playerColor);
      this.ground = $ground;
      this.skyN = $skyN;
      this.camLocked = true;
      this.camMotionX = 0;
      this.camMotionY = 0;
      this.camChasePull = 20;
      this.camChaseFriction = 0.7;
      this.camTarget = this.movie;
      this.tap0FrameBack = false;
      this.tap1FrameBack = false;
      this.tap2FrameBack = false;
      this.tap3FrameBack = false;
      this.tap4FrameBack = false;
      this.tap5FrameBack = false;
      this.shareFrame = false;
   }
   function getPosX()
   {
      return this.movie._x;
   }
   function getPosY()
   {
      return this.movie._y;
   }
   function fire($speedMod)
   {
      if(this.isIn.noFire != true)
      {
         this.inCannon = false;
         var _loc2_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(this.isIn.movie._rotation,50);
         var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(this.isIn.movie._rotation,50);
         this.motionX = _loc2_ * 0.8;
         this.motionY = _loc3_ * 0.8;
         this.motionR = Math.abs(_loc2_) + Math.abs(_loc3_);
         this.movie._x += _loc2_;
         this.movie._y += _loc3_;
         this.skipNextBlur = true;
         this.blurCharged = true;
         this.isIn.shoot();
      }
   }
   function resetYar()
   {
      this.movie._x = this.startX;
      this.movie._y = this.startY;
      this.movie._rotation = 0;
      this.motionX = 0;
      this.motionY = 0;
      this.motionR = 0;
      this.gameplayHolder._x = 0;
      this.gameplayHolder._y = 0;
      this.inCannon = false;
      this.movie._visible = true;
      this.alive = true;
      this.skipNextBlur = true;
      this.blurCharged = false;
      this.camLocked = true;
      this.game.gravityInverted == false;
   }
   function updateGameplay($speedMod)
   {
      this.tap5FrameBack = this.tap4FrameBack;
      this.tap4FrameBack = this.tap3FrameBack;
      this.tap3FrameBack = this.tap2FrameBack;
      this.tap2FrameBack = this.tap1FrameBack;
      this.tap1FrameBack = this.tap0FrameBack;
      this.tap0FrameBack = false;
      if(Key.isDown(32))
      {
         if(this.spaceUp == true)
         {
            this.spacePress = true;
         }
         this.spaceUp = false;
         this.spaceDown = true;
      }
      else
      {
         this.spaceUp = true;
         this.spaceDown = false;
         this.spacePress = false;
      }
      if(Key.isDown(37))
      {
         if(this.leftKeyUp == true)
         {
            this.leftKeyPress = true;
            this.tap0FrameBack = true;
         }
         this.leftKeyUp = false;
         this.leftKeyDown = true;
      }
      else
      {
         this.leftKeyUp = true;
         this.leftKeyDown = false;
         this.leftKeyPress = false;
      }
      if(Key.isDown(39))
      {
         if(this.rightKeyUp == true)
         {
            this.rightKeyPress = true;
            this.tap0FrameBack = true;
         }
         this.rightKeyUp = false;
         this.rightKeyDown = true;
      }
      else
      {
         this.rightKeyUp = true;
         this.rightKeyDown = false;
         this.rightKeyPress = false;
      }
      if(this.inCannon == false)
      {
         if(Math.abs(this.motionX) < 5 && Math.abs(this.motionY) < 5)
         {
            this.blurCharged = false;
         }
         if(this.game.gravityInverted == false)
         {
            this.motionY += 1 * $speedMod;
         }
         else if(this.game.gravityInverted == true)
         {
            this.motionY -= 1 * $speedMod;
         }
         this.motionX *= 1 - 0.02 * $speedMod;
         this.motionY *= 1 - 0.02 * $speedMod;
         this.motionR *= 1 - 0.02 * $speedMod;
         if(this.leftKeyDown == true)
         {
            if(this.game.inCutscene == false)
            {
               if(this.leftKeyPress == true)
               {
                  if(this.tap0FrameBack == true || this.tap1FrameBack == true || this.tap2FrameBack == true || this.tap3FrameBack == true || this.tap4FrameBack == true || this.tap5FrameBack == true)
                  {
                     if(this.game.inCutscene == false)
                     {
                        this.motionX -= 0.9 / $speedMod;
                        this.movie._xscale = -100;
                     }
                  }
               }
               this.motionX -= 0.8 / $speedMod;
               this.movie._xscale = -100;
               this.motionR += 0.4;
            }
         }
         if(this.rightKeyDown == true)
         {
            if(this.game.inCutscene == false)
            {
               if(this.rightKeyPress == true)
               {
                  if(this.tap0FrameBack == true || this.tap1FrameBack == true || this.tap2FrameBack == true || this.tap3FrameBack == true || this.tap4FrameBack == true || this.tap5FrameBack == true)
                  {
                     this.motionX += 0.9 / $speedMod;
                     this.movie._xscale = 100;
                  }
               }
               this.motionX += 0.8 / $speedMod;
               this.movie._xscale = 100;
               this.motionR += 0.4;
            }
         }
         if(this.alive == true)
         {
            if(this.game.gravityInverted == false)
            {
               if(this.movie._y > this.ground)
               {
                  this.fallout("down");
               }
            }
            else if(this.movie._y < this.game.ceilingY)
            {
               if(this.game.skyN == 3)
               {
                  this.fallout("up");
               }
               else
               {
                  this.game.gravityInverted = false;
               }
            }
         }
      }
      else if(this.inCannon == true)
      {
         if(this.spacePress == true)
         {
            if(this.game.inCutscene == false)
            {
               this.fire($speedMod);
            }
         }
      }
      this.halfPosX = this.movie._x + this.motionX * $speedMod / 2;
      this.halfPosY = this.movie._y + this.motionY * $speedMod / 2;
      this.onethirdPosX = this.movie._x + this.motionX * $speedMod / 2 + this.motionX * $speedMod / 3;
      this.onethirdPosY = this.movie._y + this.motionY * $speedMod / 2 + this.motionY * $speedMod / 3;
      this.movie._rotation += this.motionR * $speedMod;
      this.movie._x += this.motionX * $speedMod;
      this.movie._y += this.motionY * $speedMod;
      var _loc3_ = this.gameplayHolder._x;
      var _loc4_ = this.gameplayHolder._y;
      if(this.camTargetTimeN > 0)
      {
         this.camTargetTimeN = this.camTargetTimeN - 1;
         if(this.camTargetTimeN == 0)
         {
            this.camTarget = this.movie;
            this.camLocked = false;
            this.camChasePull = 20;
            this.camChaseFriction = 0.7;
         }
      }
      if(this.camTarget._y + _loc4_ + this.gameplayWorld._y > 280)
      {
         _loc4_ += 280 - (this.camTarget._y + _loc4_ + this.gameplayWorld._y);
      }
      else if(this.camTarget._y + _loc4_ + this.gameplayWorld._y < 200)
      {
         _loc4_ += 200 - (this.camTarget._y + _loc4_ + this.gameplayWorld._y);
      }
      if(this.camTarget._x + _loc3_ + this.gameplayWorld._x > 460)
      {
         _loc3_ += 460 - (this.camTarget._x + _loc3_ + this.gameplayWorld._x);
      }
      else if(this.camTarget._x + _loc3_ + this.gameplayWorld._x < 300)
      {
         _loc3_ += 300 - (this.camTarget._x + _loc3_ + this.gameplayWorld._x);
      }
      if(this.shareFrame == true)
      {
         if(this.shareFrameTarget._y + _loc4_ + this.gameplayWorld._y > 380)
         {
            _loc4_ += 380 - (this.shareFrameTarget._y + _loc4_ + this.gameplayWorld._y);
         }
         else if(this.shareFrameTarget._y + _loc4_ + this.gameplayWorld._y < 100)
         {
            _loc4_ += 100 - (this.shareFrameTarget._y + _loc4_ + this.gameplayWorld._y);
         }
         if(this.shareFrameTarget._x + _loc3_ + this.gameplayWorld._x > 560)
         {
            _loc3_ += 560 - (this.shareFrameTarget._x + _loc3_ + this.gameplayWorld._x);
         }
         else if(this.shareFrameTarget._x + _loc3_ + this.gameplayWorld._x < 200)
         {
            _loc3_ += 200 - (this.shareFrameTarget._x + _loc3_ + this.gameplayWorld._x);
         }
      }
      if(this.camLocked == true)
      {
         if(this.alive == true)
         {
            this.gameplayHolder._x = _loc3_;
            this.gameplayHolder._y = _loc4_;
            this.camMotionX = 0;
            this.camMotionY = 0;
         }
      }
      else
      {
         var _loc5_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.gameplayHolder._x,this.gameplayHolder._y,_loc3_,_loc4_);
         if(_loc5_ > 10)
         {
            var _loc7_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.gameplayHolder._x,this.gameplayHolder._y,_loc3_,_loc4_);
            var _loc8_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc7_,_loc5_ * 2 / this.camChasePull);
            var _loc9_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc7_,_loc5_ * 2 / this.camChasePull);
            this.camMotionX += _loc8_;
            this.camMotionY += _loc9_;
         }
         this.camMotionX *= this.camChaseFriction;
         this.camMotionY *= this.camChaseFriction;
         this.gameplayHolder._x += this.camMotionX;
         this.gameplayHolder._y += this.camMotionY;
         if(this.camChasePull > 2)
         {
            this.camChasePull -= 0.375;
         }
         if(this.camChaseFriction > 0.4)
         {
            this.camChaseFriction -= 0.00625;
         }
         _loc5_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.gameplayHolder._x,this.gameplayHolder._y,_loc3_,_loc4_);
         if(_loc5_ <= 10)
         {
            this.camLocked = true;
         }
      }
      if(this.blurCharged == true)
      {
         if(this.blurN >= this.blurMax)
         {
            this.blurN = 1;
            var _loc6_ = this.blurMax - 1;
         }
         else
         {
            _loc6_ = this.blurN;
         }
         if(this.inCannon == false)
         {
            this.blurN = this.blurN + 1;
            this.blurHolder.attachMovie("blur","blur" + this.blurN,this.blurN);
            this.blurHolder["blur" + this.blurN]._x = this.movie._x;
            this.blurHolder["blur" + this.blurN]._y = this.movie._y;
            this.blurHolder["blur" + this.blurN].art.gotoAndStop(this.playerColor);
            _loc7_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.blurHolder["blur" + this.blurN]._x,this.blurHolder["blur" + this.blurN]._y,this.blurHolder["blur" + _loc6_]._x,this.blurHolder["blur" + _loc6_]._y);
            this.blurHolder["blur" + this.blurN]._rotation = _loc7_;
            _loc5_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.blurHolder["blur" + this.blurN]._x,this.blurHolder["blur" + this.blurN]._y,this.blurHolder["blur" + _loc6_]._x,this.blurHolder["blur" + _loc6_]._y);
            this.blurHolder["blur" + this.blurN]._xscale *= _loc5_ / 6;
            if(this.skipNextBlur == true)
            {
               this.skipNextBlur = false;
               this.blurHolder["blur" + this.blurN]._visible = false;
               this.blurHolder["blur" + this.blurN]._x = this.movie._x;
               this.blurHolder["blur" + this.blurN]._y = this.movie._y;
            }
         }
      }
      this.spacePress = false;
      this.rightKeyPress = false;
      this.leftKeyPress = false;
   }
   function fallout($direction)
   {
      this.alive = false;
      this.game.forceSlowMode = false;
      this.game.gravityInverted = false;
      this.motionX = 0;
      this.motionY = 0;
      this.movie._visible = false;
      this.gameplayHolder.particleHolder.attachMovie("splash","splash",1);
      this.gameplayHolder.particleHolder.splash.player = this;
      this.gameplayHolder.particleHolder.splash._x = this.movie._x;
      this.gameplayHolder.particleHolder.splash._y = this.movie._y;
      if($direction == "up")
      {
         this.gameplayHolder.particleHolder.splash._yscale = -100;
      }
      this.gameplayHolder.particleHolder.splash.gotoAndStop(this.skyN);
   }
   function destroy()
   {
      this.movie.removeMovieClip();
   }
}
