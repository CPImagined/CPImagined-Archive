class com.clubpenguin.games.cannon.BossOwl extends com.clubpenguin.games.cannon.GameplayObstacle
{
   var groundX;
   var movie;
   var groundY;
   var startX;
   var startY;
   var motionX;
   var motionY;
   var alive;
   var hp;
   var moveSpeed;
   var collidable;
   var spinN;
   var game;
   var settingN;
   var gameplayHolder;
   var countdown;
   function BossOwl($game, $gameplayWorld, $gameplayHolder, $obstacleHolder, $idn, $posX, $posY, $settingN)
   {
      super($game,$gameplayWorld,$gameplayHolder,$obstacleHolder,$idn,$posX,$posY,$settingN);
      this.groundX = this.movie._x;
      this.groundY = this.movie._y;
      this.startX = this.groundX;
      this.startY = this.groundY;
      this.motionX = 0;
      this.motionY = 0;
      this.movie.master = this;
      this.alive = true;
      this.hp = 8;
      this.moveSpeed = 0.003;
      this.collidable = true;
      this.spinN = 2;
      if(this.game.gameMode == "standardGameplay")
      {
         this.movie.art.gotoAndStop("gameplay");
         this.movie.art.art.gotoAndStop("still");
         this.movie.art.art.art.gotoAndStop(this.hp + 1);
      }
   }
   function startIntro()
   {
      this.game.inCutscene = true;
      this.game.forceSlowMode = true;
   }
   function endIntro()
   {
      this.alive = false;
      this.game.inCutscene = false;
      this.game.forceSlowMode = false;
      removeMovieClip(this.movie);
      false;
   }
   function updateGameplay($speedMod)
   {
      if(this.settingN == 7)
      {
      }
      if(this.settingN == 8)
      {
         var _loc6_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.getPosX(),this.game.playerObj.getPosY());
         if(this.game.playerObj.inCannon == false)
         {
            if(this.collidable == true)
            {
               if(_loc6_ < 70)
               {
                  var _loc4_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.playerObj.getPosX(),this.game.playerObj.getPosY(),this.movie._x,this.movie._y);
                  var _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc4_,30);
                  var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc4_,30);
                  this.motionX += _loc5_;
                  this.motionY += _loc3_;
                  this.game.playerObj.motionY = Math.abs(_loc3_) * -1.2;
                  this.game.playerObj.motionR = Math.abs(_loc5_) + Math.abs(_loc3_);
                  if(this.hp > 0)
                  {
                     this.hp = this.hp - 1;
                     this.moveSpeed += 0.002;
                     this.movie.art.art.gotoAndStop("still");
                     this.movie.art.art.gotoAndStop("damage");
                     this.movie.art.art.art.gotoAndStop(this.hp + 1);
                     this.collidable = false;
                     this.movie.art.master = this;
                     this.gameplayHolder.particleHolder.attachMovie("biff","biff",1);
                     this.gameplayHolder.particleHolder.biff._x = this.game.playerObj.movie._x;
                     this.gameplayHolder.particleHolder.biff._y = this.game.playerObj.movie._y;
                     this.motionX = 0;
                     this.motionY = 0;
                  }
               }
            }
         }
         if(this.collidable == true)
         {
            if(this.movie._x > this.groundX)
            {
               this.motionX -= Math.abs(this.movie._x - this.groundX) * this.moveSpeed * $speedMod;
               this.movie.art._xscale = -100;
            }
            else if(this.movie._x < this.groundX)
            {
               this.motionX += Math.abs(this.movie._x - this.groundX) * this.moveSpeed * $speedMod;
               this.movie.art._xscale = 100;
            }
            if(this.movie._y > this.groundY)
            {
               this.motionY -= Math.abs(this.movie._y - this.groundY) * this.moveSpeed * $speedMod;
            }
            else if(this.movie._y < this.groundY)
            {
               this.motionY += Math.abs(this.movie._y - this.groundY) * this.moveSpeed * $speedMod;
            }
         }
         this.motionX *= 1 - 0.1 * $speedMod;
         this.motionY *= 1 - 0.1 * $speedMod;
         this.movie._x += this.motionX * $speedMod;
         this.movie._y += this.motionY * $speedMod;
         if(this.countdown > 0)
         {
            this.countdown = this.countdown - 1;
         }
         else
         {
            this.countdown = 40;
            if(this.groundX > this.startX)
            {
               this.groundX = this.startX - 300;
            }
            else
            {
               this.groundX = this.startX + 300;
            }
         }
      }
   }
   function recover()
   {
      if(this.spinN > 0)
      {
         this.spinN = this.spinN - 1;
      }
      else
      {
         this.spinN = 2;
         if(this.hp == 0)
         {
            this.movie.art.art.gotoAndStop("finish");
         }
         else
         {
            this.collidable = true;
            this.movie.art.art.gotoAndStop("still");
            this.movie.art.art.art.gotoAndStop(this.hp + 1);
         }
      }
   }
   function finishChallenge1()
   {
      this.game.giantPuffleOObj.movie._x = this.movie._x - 11;
      this.game.giantPuffleOObj.movie._y = this.movie._y + 101;
   }
   function destroy()
   {
      this.movie.removeMovieClip();
   }
}
