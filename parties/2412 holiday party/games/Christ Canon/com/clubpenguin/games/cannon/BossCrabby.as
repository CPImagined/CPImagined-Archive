class com.clubpenguin.games.cannon.BossCrabby
{
   var game;
   var gameplayWorld;
   var gameplayHolder;
   var bossHolder;
   var idNumber;
   var settingN;
   var movie;
   var debrisN;
   var groundX;
   var groundY;
   var startX;
   var startY;
   var motionX;
   var motionY;
   var alive;
   var hp;
   var moveSpeed;
   var collidable;
   var leaving;
   var pathTargetN;
   var targetSet;
   var timeN;
   var engineLoopN;
   var engineLoopDefault;
   var pathFollowing;
   var goingForward;
   var pathWayArray;
   var chase;
   var chaseStartN;
   var phase;
   var motionRArm;
   var armAngle;
   var attacking;
   var armRotationN;
   var playerFellDuring;
   var changingGravity;
   var tooClose;
   var box0X;
   var box0Y;
   var box1X;
   var box1Y;
   var box2X;
   var box2Y;
   var box3X;
   var box3Y;
   var box4X;
   var box4Y;
   var box5X;
   var box5Y;
   var box6X;
   var box6Y;
   var box7X;
   var box7Y;
   var orbitR0;
   var orbitR1;
   var orbitR2;
   var orbitR3;
   var orbitR4;
   var orbitR5;
   var orbitR6;
   var orbitR7;
   var box8X;
   var box8Y;
   var box9X;
   var box9Y;
   var box10X;
   var box10Y;
   var box11X;
   var box11Y;
   var box12X;
   var box12Y;
   var box13X;
   var box13Y;
   var box14X;
   var box14Y;
   var box15X;
   var box15Y;
   var orbitR8;
   var orbitR9;
   var orbitR10;
   var orbitR11;
   var orbitR12;
   var orbitR13;
   var orbitR14;
   var orbitR15;
   var box16X;
   var box16Y;
   var box17X;
   var box17Y;
   var box18X;
   var box18Y;
   var box19X;
   var box19Y;
   var box20X;
   var box20Y;
   var box21X;
   var box21Y;
   var box22X;
   var box22Y;
   var box23X;
   var box23Y;
   var orbitR16;
   var orbitR17;
   var orbitR18;
   var orbitR19;
   var orbitR20;
   var orbitR21;
   var orbitR22;
   var orbitR23;
   var dragonFlyX;
   var speedMod;
   var countdown;
   var attackEnd;
   var anvilXL;
   var anvilX;
   var anvilYL;
   var anvilY;
   var pushX;
   var pushY;
   var debrisObj;
   function BossCrabby($game, $gameplayWorld, $gameplayHolder, $bossHolder, $idn, $posX, $posY, $posR, $settingN)
   {
      this.game = $game;
      this.gameplayWorld = $gameplayWorld;
      this.gameplayHolder = $gameplayHolder;
      this.bossHolder = $bossHolder;
      this.idNumber = $idn;
      this.settingN = $settingN;
      this.movie = this.bossHolder.attachMovie("obstacle","Obj" + $idn,$idn);
      this.movie._x = $posX;
      this.movie._y = $posY;
      this.movie.gotoAndStop(this.settingN);
      this.debrisN = 1;
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
      this.leaving = false;
      this.pathTargetN = -1;
      this.targetSet = false;
      this.timeN = 0;
      this.engineLoopN = 35;
      this.engineLoopDefault = this.engineLoopN;
      if(this.game.gameMode == "standardGameplay")
      {
         this.movie.art.gotoAndStop("gameplay");
         if(this.settingN == 23)
         {
            this.pathFollowing = false;
         }
         else if(this.settingN == 24)
         {
            this.pathFollowing = false;
         }
         else if(this.settingN == 25)
         {
            this.pathFollowing = false;
         }
         if(this.settingN == 26)
         {
            this.pathFollowing = true;
            this.goingForward = true;
            this.pathWayArray = [[-1900,250],[-1800,250],[-1600,250],[-1200,250],[-1000,250],[-800,250],[-400,250],[-100,200],[-100,15],[490,15],[912,15],[1503,48],[1823,52],[2193,30],[2528,68],[2968,-47],[3448,0],[3598,-378],[3397,-630],[3286,-853],[3428,-1086],[3325,-1301],[3511,-1545],[3316,-1893],[3735,-2151],[4237,-2150],[4703,-2146],[4750,-1000],[4750,0],[4750,1000]];
            this.game.magnetism = true;
            this.game.magnet = this;
            this.game.magnetOffsetX = 0;
            this.game.magnetOffsetY = 120;
         }
         if(this.settingN == 27)
         {
            this.chase = false;
            this.chaseStartN = 0;
            this.phase = 1;
            this.pathFollowing = true;
            this.goingForward = true;
            this.pathWayArray = [[653,-1540],[-665,-1603],[-675.05,-1325]];
            this.movie._x = 2020;
            this.movie._y = -1740;
            this.motionRArm = 0;
            this.armAngle = 0;
            this.attacking = true;
            this.armRotationN = 0;
         }
         if(this.settingN == 28)
         {
            this.pathFollowing = false;
            this.playerFellDuring = false;
            this.changingGravity = false;
            this.tooClose = false;
         }
         if(this.settingN == 29)
         {
            this.hp = 9;
            this.phase = 1;
            this.pathFollowing = false;
            this.box0X = 0;
            this.box0Y = 0;
            this.box1X = 0;
            this.box1Y = 0;
            this.box2X = 0;
            this.box2Y = 0;
            this.box3X = 0;
            this.box3Y = 0;
            this.box4X = 0;
            this.box4Y = 0;
            this.box5X = 0;
            this.box5Y = 0;
            this.box6X = 0;
            this.box6Y = 0;
            this.box7X = 0;
            this.box7Y = 0;
            this.orbitR0 = 0;
            this.orbitR1 = 45;
            this.orbitR2 = 90;
            this.orbitR3 = 135;
            this.orbitR4 = 180;
            this.orbitR5 = 225;
            this.orbitR6 = 270;
            this.orbitR7 = 315;
            this.box8X = 0;
            this.box8Y = 0;
            this.box9X = 0;
            this.box9Y = 0;
            this.box10X = 0;
            this.box10Y = 0;
            this.box11X = 0;
            this.box11Y = 0;
            this.box12X = 0;
            this.box12Y = 0;
            this.box13X = 0;
            this.box13Y = 0;
            this.box14X = 0;
            this.box14Y = 0;
            this.box15X = 0;
            this.box15Y = 0;
            this.orbitR8 = 23;
            this.orbitR9 = 68;
            this.orbitR10 = 113;
            this.orbitR11 = 158;
            this.orbitR12 = 203;
            this.orbitR13 = 248;
            this.orbitR14 = 293;
            this.orbitR15 = 338;
            this.box16X = 0;
            this.box16Y = 0;
            this.box17X = 0;
            this.box17Y = 0;
            this.box18X = 0;
            this.box18Y = 0;
            this.box19X = 0;
            this.box19Y = 0;
            this.box20X = 0;
            this.box20Y = 0;
            this.box21X = 0;
            this.box21Y = 0;
            this.box22X = 0;
            this.box22Y = 0;
            this.box23X = 0;
            this.box23Y = 0;
            this.orbitR16 = 0;
            this.orbitR17 = 45;
            this.orbitR18 = 90;
            this.orbitR19 = 135;
            this.orbitR20 = 180;
            this.orbitR21 = 225;
            this.orbitR22 = 270;
            this.orbitR23 = 315;
         }
         if(this.settingN == 38)
         {
            this.phase = 1;
            this.pathFollowing = false;
            this.dragonFlyX = 0;
         }
      }
   }
   function startIntro()
   {
      trace("start intro");
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
      this.speedMod = $speedMod;
      if(this.alive == true)
      {
         if(this.engineLoopN > 0)
         {
            this.engineLoopN = this.engineLoopN - 1;
         }
         else
         {
            this.engineLoopN = this.engineLoopDefault;
            this.playSFX("vroom");
         }
      }
      if(this.settingN == 23)
      {
         if(this.game.playerObj.inCannon == false)
         {
            if(this.alive == true)
            {
               var _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.game.playerObj.movie._x,this.game.playerObj.movie._y,this.game.giantPuffleOObj.movie._x,this.game.giantPuffleOObj.movie._y);
               if(_loc4_ < 50)
               {
                  this.movie.art.art.gotoAndStop("lose");
               }
               if(this.collidable == true)
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc4_ < 50)
                  {
                     this.leaving = true;
                     this.movie.art.art.gotoAndStop(1);
                     this.movie.art.art.gotoAndStop("hit");
                     this.bumpPuffle();
                     this.takeDamage();
                  }
               }
            }
         }
         if(this.alive == false)
         {
            this.collidable = false;
            this.motionY += 0.4;
         }
         if(this.leaving == true && this.alive == true)
         {
            this.motionY -= 0.2;
            this.motionX -= 0.2;
         }
         if(this.leaving == false)
         {
            this.pullTowardsTarget();
         }
         this.updatePosition();
         if(this.alive == true)
         {
            if(this.leaving == false)
            {
               if(this.countdown > 0)
               {
                  this.countdown = this.countdown - 1;
               }
               else
               {
                  this.countdown = 40;
                  if(this.groundX > this.startX)
                  {
                     this.groundX = this.startX - 100;
                  }
                  else
                  {
                     this.groundX = this.startX + 100;
                  }
               }
            }
         }
      }
      else if(this.settingN == 24)
      {
         if(this.alive == true)
         {
            this.game.inCutscene = true;
         }
      }
      if(this.settingN == 25)
      {
         if(this.game.playerObj.inCannon == false)
         {
            if(this.alive == true)
            {
               if(this.collidable == true)
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc4_ < 50)
                  {
                     this.movie.art.art.gotoAndStop(1);
                     this.movie.art.art.gotoAndStop("hit");
                     this.bumpPuffle();
                     this.takeDamage();
                  }
               }
            }
         }
         if(this.alive == false)
         {
            this.collidable = false;
            this.motionY += 0.4;
         }
         this.pullTowardsTarget();
         this.updatePosition();
         if(this.alive == true)
         {
            if(this.countdown > 0)
            {
               this.countdown = this.countdown - 1;
            }
            else
            {
               this.countdown = 40;
               if(this.groundX > this.startX)
               {
                  this.groundX = this.startX - 500;
               }
               else
               {
                  this.groundX = this.startX + 500;
               }
            }
         }
      }
      if(this.settingN == 26)
      {
         if(this.game.playerObj.inCannon == false)
         {
            if(this.alive == true)
            {
               if(this.collidable == true)
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc4_ < 50)
                  {
                     this.movie.art.art.gotoAndStop(1);
                     this.movie.art.art.gotoAndStop("hit");
                     this.bumpPuffle();
                     this.takeDamage();
                  }
               }
            }
         }
         if(this.alive == false)
         {
            this.collidable = false;
            this.motionY += 0.4;
         }
         if(this.alive == true)
         {
            if(this.pathFollowing == true)
            {
               if(this.targetSet == false)
               {
                  if(this.pathTargetN < this.pathWayArray.length)
                  {
                     this.pathTargetN = this.pathTargetN + 1;
                     this.groundX = this.pathWayArray[this.pathTargetN][0];
                     this.groundY = this.pathWayArray[this.pathTargetN][1];
                     this.targetSet = true;
                  }
                  else
                  {
                     this.pathFollowing = false;
                  }
               }
               else
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.groundX,this.groundY);
                  if(_loc4_ < 100)
                  {
                     this.targetSet = false;
                  }
               }
            }
         }
         this.pullTowardsTarget();
         this.updatePosition();
      }
      if(this.settingN == 27)
      {
         this.timeN = this.timeN + 1;
         if(this.phase == 1)
         {
            if(this.timeN == 1)
            {
               this.game.inCutscene = true;
               this.game.playerObj.motionX = 0;
               this.game.playerObj.movie._x = this.game.playerObj.startX;
            }
            if(this.timeN == 72)
            {
               this.startIntro();
               this.game.playMusic("none");
            }
            if(this.timeN == 96)
            {
               this.game.playMusic("boss");
            }
            if(this.timeN == 240)
            {
               this.game.inCutscene = false;
               this.game.forceSlowMode = false;
            }
            if(this.timeN == 336)
            {
               this.phase = 2;
               this.pathTargetN = 0;
               this.groundX = this.pathWayArray[this.pathTargetN][0];
               this.groundY = this.pathWayArray[this.pathTargetN][1];
               this.pathWayArray = [[130,-325],[460.05,-320],[760.05,-310],[985.05,-80],[1135.05,200],[950.05,430],[625.05,505],[300,500],[-10,490],[-320,490],[-635,480],[-810,230],[-680,-55],[-510,-280],[-210,-335]];
               this.attacking = false;
            }
         }
         if(this.game.playerObj.inCannon == false)
         {
            if(this.alive == true)
            {
               if(this.collidable == true)
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc4_ < 50)
                  {
                     this.movie.art.art.gotoAndStop(1);
                     this.movie.art.art.gotoAndStop("hit");
                     this.bumpPuffle();
                     this.takeDamage();
                  }
               }
            }
         }
         if(this.alive == false)
         {
            this.collidable = false;
            this.motionY += 0.4;
            this.attacking = false;
         }
         if(this.alive == true)
         {
            if(this.pathFollowing == true)
            {
               if(this.targetSet == false)
               {
                  if(this.goingForward == true)
                  {
                     this.pathTargetN = this.pathTargetN + 1;
                     if(this.pathTargetN >= this.pathWayArray.length)
                     {
                        this.pathTargetN = 0;
                     }
                  }
                  else
                  {
                     this.pathTargetN = this.pathTargetN - 1;
                     if(this.pathTargetN < 0)
                     {
                        this.pathTargetN = this.pathWayArray.length - 1;
                     }
                  }
                  if(this.pathTargetN == this.attackEnd)
                  {
                     this.attacking = false;
                  }
                  this.groundX = this.pathWayArray[this.pathTargetN][0];
                  this.groundY = this.pathWayArray[this.pathTargetN][1];
                  this.targetSet = true;
               }
               else
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.groundX,this.groundY);
                  if(_loc4_ < 100)
                  {
                     this.targetSet = false;
                  }
               }
            }
         }
         if(this.phase == 2)
         {
            if(this.alive == true)
            {
               _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
               if(_loc4_ > 1500)
               {
                  this.moveSpeed = 0.02;
               }
               else if(_loc4_ > 1000)
               {
                  this.moveSpeed = 0.01;
               }
               else if(_loc4_ > 600)
               {
                  this.moveSpeed = 0.006;
               }
               else
               {
                  this.moveSpeed = 0.003;
               }
               if(this.game.playerObj.alive == false)
               {
                  this.attacking = true;
                  this.attackEnd = this.pathTargetN;
               }
               if(this.chase == true)
               {
                  if(this.chaseStartN + 120 < this.timeN)
                  {
                     this.chase = false;
                  }
                  var _loc10_ = this.pathTargetN + 1;
                  if(_loc10_ == this.pathWayArray.length)
                  {
                     _loc10_ = 0;
                  }
                  var _loc15_ = this.pathWayArray[_loc10_][0];
                  var _loc16_ = this.pathWayArray[_loc10_][1];
                  var _loc18_ = com.clubpenguin.math.AaronsPhysics.findDistance(_loc15_,_loc16_,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  var _loc11_ = this.pathTargetN - 1;
                  if(_loc11_ == -1)
                  {
                     _loc11_ = this.pathWayArray.length - 1;
                  }
                  var _loc20_ = this.pathWayArray[_loc11_][0];
                  var _loc21_ = this.pathWayArray[_loc11_][1];
                  var _loc19_ = com.clubpenguin.math.AaronsPhysics.findDistance(_loc20_,_loc21_,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc18_ < _loc19_)
                  {
                     this.goingForward = true;
                  }
                  else
                  {
                     this.goingForward = false;
                  }
               }
            }
         }
         this.pullTowardsTarget();
         this.updatePosition();
         if(this.attacking == true)
         {
            if(this.motionX > 0)
            {
               this.motionRArm += 4;
            }
            else
            {
               this.motionRArm -= 4;
            }
         }
         this.motionRArm += this.motionX / 10;
         this.armRotationN += Math.abs(this.motionRArm);
         if(this.armRotationN > 360)
         {
            this.armRotationN = 0;
            if(Math.abs(this.motionRArm) > 10)
            {
               this.swingSFX();
            }
         }
         if(this.armAngle != 0)
         {
            if(this.attacking == false)
            {
               this.motionRArm -= this.armAngle / 10;
            }
         }
         this.motionRArm *= 0.9;
         this.armAngle += this.motionRArm;
         if(this.armAngle > 360)
         {
            this.armAngle -= 360;
         }
         if(this.armAngle < -360)
         {
            this.armAngle += 360;
         }
         this.movie.art.art.arm._rotation = this.armAngle + 90;
         this.anvilXL = this.anvilX;
         this.anvilYL = this.anvilY;
         this.anvilX = com.clubpenguin.math.AaronsPhysics.findPositionXAfterParentRotation(200,0,this.movie._x,this.movie._y,this.movie.art.art.arm._rotation);
         this.anvilY = com.clubpenguin.math.AaronsPhysics.findPositionYAfterParentRotation(200,0,this.movie._x,this.movie._y,this.movie.art.art.arm._rotation);
         var _loc9_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.anvilXL,this.anvilYL,this.anvilX,this.anvilY);
         if(this.alive == true)
         {
            if(this.collidable == true)
            {
               var _loc2_ = 0;
               while(_loc2_ < this.game.sodaBalloonArray.length)
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.anvilX,this.anvilY,this.game.sodaBalloonArray[_loc2_].movie._x,this.game.sodaBalloonArray[_loc2_].movie._y);
                  if(_loc4_ < 120)
                  {
                     if(this.attacking == false)
                     {
                        if(this.game.sodaBalloonArray[_loc2_].movie._y > this.anvilY - 50)
                        {
                           var _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.anvilX,this.anvilY,this.game.sodaBalloonArray[_loc2_].movie._x,this.game.sodaBalloonArray[_loc2_].movie._y);
                           var _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,50);
                           var _loc6_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,50);
                           this.game.sodaBalloonArray[_loc2_].motionX = _loc5_;
                           this.game.sodaBalloonArray[_loc2_].motionY = _loc6_;
                           this.game.sodaBalloonArray[_loc2_].setElasticPull(0.001);
                        }
                     }
                     if(this.attacking == true)
                     {
                        _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.anvilX,this.anvilY,this.game.sodaBalloonArray[_loc2_].movie._x,this.game.sodaBalloonArray[_loc2_].movie._y);
                        _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,50);
                        _loc6_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,50);
                        var _loc7_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc9_,100);
                        var _loc8_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc9_,100);
                        this.game.sodaBalloonArray[_loc2_].motionX = _loc5_ + _loc7_;
                        this.game.sodaBalloonArray[_loc2_].motionY = _loc6_ + _loc8_;
                        this.game.sodaBalloonArray[_loc2_].setElasticPull(0.001);
                     }
                  }
                  _loc2_ += 1;
               }
               if(this.game.playerObj.inCannon == false)
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.anvilX,this.anvilY,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc4_ < 120)
                  {
                     if(this.attacking == false)
                     {
                        if(this.game.playerObj.movie._y > this.anvilY - 50)
                        {
                           _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.anvilX,this.anvilY,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                           _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,25);
                           _loc6_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,25);
                           this.game.playerObj.motionX = _loc5_;
                           this.game.playerObj.motionY = _loc6_;
                           this.game.sfx.anvil100.gotoAndPlay("on");
                        }
                     }
                     if(this.attacking == true)
                     {
                        _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.anvilX,this.anvilY,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                        _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,25);
                        _loc6_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,25);
                        _loc7_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc9_,50);
                        _loc8_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc9_,50);
                        this.game.playerObj.motionX = _loc5_ + _loc7_;
                        this.game.playerObj.motionY = _loc6_ + _loc8_;
                        this.game.sfx.anvil100.gotoAndPlay("on");
                     }
                  }
               }
            }
         }
      }
      if(this.settingN == 28)
      {
         if(this.game.playerObj.alive == false)
         {
            this.playerFellDuring = true;
         }
         this.tooClose = false;
         if(this.movie._x < this.game.playerObj.movie._x)
         {
            this.groundX = this.game.playerObj.movie._x - 260;
            if(this.game.playerObj.movie._x - this.movie._x < 200)
            {
               this.groundX -= 400;
               this.tooClose = true;
            }
         }
         else
         {
            this.groundX = this.game.playerObj.movie._x - 260;
            if(this.movie._x - this.game.playerObj.movie._x < 200)
            {
               this.groundX += 400;
               this.tooClose = true;
            }
         }
         if(this.tooClose == false)
         {
            if(this.collidable == true)
            {
               if(this.changingGravity == false)
               {
                  var _loc22_ = 16;
                  var _loc13_ = this.game.playerObj.movie._y + this.game.playerObj.motionY * 16;
                  if(this.game.gravityInverted == false)
                  {
                     if(_loc13_ > this.movie._y)
                     {
                        trace("start changing gravity to up");
                        this.movie.art.art.gotoAndStop(1);
                        this.movie.art.art.gotoAndStop("invert");
                        this.playerFellDuring = false;
                        this.changingGravity = true;
                     }
                  }
                  if(this.game.gravityInverted == true)
                  {
                     if(_loc13_ < this.movie._y)
                     {
                        trace("start changing gravity to down");
                        this.movie.art.art.gotoAndStop(1);
                        this.movie.art.art.gotoAndStop("invert");
                        this.playerFellDuring = false;
                        this.changingGravity = true;
                     }
                  }
               }
               else
               {
                  trace("currently changing gravity " + this.changingGravity);
               }
            }
         }
         if(this.game.playerObj.inCannon == false)
         {
            if(this.alive == true)
            {
               if(this.collidable == true)
               {
                  _loc2_ = 0;
                  while(_loc2_ < this.game.shatterBoxArray.length)
                  {
                     if(this.game.shatterBoxArray[_loc2_].breakN < 4)
                     {
                        _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.shatterBoxArray[_loc2_].movie._x,this.game.shatterBoxArray[_loc2_].movie._y);
                        if(_loc4_ < 120)
                        {
                           _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.shatterBoxArray[_loc2_].movie._x,this.game.shatterBoxArray[_loc2_].movie._y,this.movie._x,this.movie._y);
                           _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,20);
                           _loc6_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,20);
                           this.motionX = _loc5_;
                           this.motionY = _loc6_;
                           this.game.shatterBoxArray[_loc2_].shatter();
                        }
                     }
                     _loc2_ += 1;
                  }
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc4_ < 50)
                  {
                     this.movie.art.art.gotoAndStop(1);
                     this.movie.art.art.gotoAndStop("hit");
                     this.bumpPuffle();
                     this.takeDamage();
                     this.changingGravity = false;
                     trace("changingGravity set to " + this.changingGravity);
                  }
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y + 120,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc4_ < 43)
                  {
                     this.bumpGravityBox(this.movie.art.art.art.box);
                     _loc3_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.playerObj.movie._x,this.game.playerObj.movie._y,this.movie._x + 120,this.movie._y);
                     _loc5_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc3_,20);
                     _loc6_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc3_,20);
                     this.motionX = _loc5_;
                     this.motionY = _loc6_;
                     this.game.playerObj.motionX = _loc5_ * -0.9;
                     this.game.playerObj.motionY = _loc6_ * -1.2;
                     this.game.playerObj.motionR = Math.abs(_loc5_) + Math.abs(_loc6_);
                  }
               }
            }
         }
         if(this.alive == false)
         {
            this.collidable = false;
            this.motionY += 0.4;
         }
         this.pullTowardsTarget();
         this.updatePosition();
      }
      if(this.settingN == 29)
      {
         this.timeN = this.timeN + 1;
         if(this.phase == 1)
         {
            this.groundX += 10;
            if(this.timeN == 1)
            {
               this.movie._x = this.groundX;
               this.movie._y = this.groundY;
               this.game.inCutscene = true;
               this.game.playerObj.motionX = 0;
               this.game.playerObj.movie._x = this.game.playerObj.startX;
            }
            if(this.timeN == 72)
            {
               this.startIntro();
               this.game.playMusic("none");
            }
            if(this.timeN == 96)
            {
               this.game.playMusic("boss");
            }
            if(this.timeN == 240)
            {
               this.game.inCutscene = false;
               this.game.forceSlowMode = false;
            }
            if(this.timeN == 336)
            {
               this.phase = 2;
               this.groundX = 250;
               this.groundY = -940;
               this.startX = this.groundX;
               this.startY = this.groundY;
            }
         }
         if(this.game.playerObj.inCannon == false)
         {
            if(this.alive == true)
            {
               if(this.collidable == true)
               {
                  _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
                  if(_loc4_ < 50)
                  {
                     this.movie.art.art.gotoAndStop(1);
                     this.movie.art.art.gotoAndStop("hit");
                     this.bumpPuffle();
                     this.takeDamage();
                     _loc2_ = 0;
                     while(_loc2_ < 24)
                     {
                        this.game.asteroidArray[_loc2_].motionX = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(this["orbitR" + _loc2_],50);
                        this.game.asteroidArray[_loc2_].motionY = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(this["orbitR" + _loc2_],50);
                        _loc2_ += 1;
                     }
                     if(this.hp < 2)
                     {
                        this.gameplayHolder.particleHolder.attachMovie("bossspinout","bossspinout",2);
                        this.gameplayHolder.particleHolder.bossspinout._x = this.movie._x;
                        this.gameplayHolder.particleHolder.bossspinout._y = this.movie._y;
                        this.game.playerObj.camTarget = this.gameplayHolder.particleHolder.bossspinout;
                        this.game.playerObj.camTargetTimeN = 54;
                        this.game.playerObj.camLocked = false;
                        _loc2_ = 0;
                        while(_loc2_ < 24)
                        {
                           this.game.asteroidArray[_loc2_].motionX = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(this["orbitR" + _loc2_],50);
                           this.game.asteroidArray[_loc2_].motionY = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(this["orbitR" + _loc2_],50);
                           this.game.asteroidArray[_loc2_].shrinking = true;
                           this.game.asteroidArray[_loc2_].collidable = false;
                           _loc2_ += 1;
                        }
                        this.game.level1obstacleArray[25].movie._x = 480;
                        this.game.level1obstacleArray[25].movie._y = -1650;
                        this.game.level1obstacleArray[25].groundX = 480;
                        this.game.level1obstacleArray[25].groundY = -850;
                        this.game.level1obstacleArray[26].movie._x = 610;
                        this.game.level1obstacleArray[26].movie._y = -2260;
                        this.game.level1obstacleArray[26].groundX = 610;
                        this.game.level1obstacleArray[26].groundY = -1460;
                        this.game.level1obstacleArray[27].movie._x = 760;
                        this.game.level1obstacleArray[27].movie._y = -2840;
                        this.game.level1obstacleArray[27].groundX = 760;
                        this.game.level1obstacleArray[27].groundY = -2040;
                        this.game.level1obstacleArray[28].movie._x = 930;
                        this.game.level1obstacleArray[28].movie._y = -3430;
                        this.game.level1obstacleArray[28].groundX = 930;
                        this.game.level1obstacleArray[28].groundY = -2630;
                        this.game.level1obstacleArray[29].movie._x = 1110;
                        this.game.level1obstacleArray[29].movie._y = -4000;
                        this.game.level1obstacleArray[29].groundX = 1110;
                        this.game.level1obstacleArray[29].groundY = -3200;
                        this.game.playerObj.motionX = 0;
                        this.game.playerObj.motionY = -27;
                        this.destroy();
                     }
                  }
               }
            }
         }
         if(this.alive == true)
         {
            _loc2_ = 0;
            while(_loc2_ < 8)
            {
               this["orbitR" + _loc2_] += 1.5 * this.speedMod;
               if(this["orbitR" + _loc2_] >= 360)
               {
                  this["orbitR" + _loc2_] -= 360;
               }
               this["box" + _loc2_ + "X"] = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(this["orbitR" + _loc2_],800);
               this["box" + _loc2_ + "Y"] = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(this["orbitR" + _loc2_],800);
               this["box" + _loc2_ + "X"] = this.movie._x + this["box" + _loc2_ + "X"];
               this["box" + _loc2_ + "Y"] = this.movie._y + this["box" + _loc2_ + "Y"];
               this.game.asteroidArray[_loc2_].groundX = this["box" + _loc2_ + "X"];
               this.game.asteroidArray[_loc2_].groundY = this["box" + _loc2_ + "Y"];
               _loc2_ += 1;
            }
            _loc2_ = 8;
            while(_loc2_ < 16)
            {
               this["orbitR" + _loc2_] -= 1.5 * this.speedMod;
               if(this["orbitR" + _loc2_] <= 0)
               {
                  this["orbitR" + _loc2_] += 360;
               }
               this["box" + _loc2_ + "X"] = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(this["orbitR" + _loc2_],500);
               this["box" + _loc2_ + "Y"] = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(this["orbitR" + _loc2_],500);
               this["box" + _loc2_ + "X"] = this.movie._x + this["box" + _loc2_ + "X"];
               this["box" + _loc2_ + "Y"] = this.movie._y + this["box" + _loc2_ + "Y"];
               this.game.asteroidArray[_loc2_].groundX = this["box" + _loc2_ + "X"];
               this.game.asteroidArray[_loc2_].groundY = this["box" + _loc2_ + "Y"];
               _loc2_ += 1;
            }
            _loc2_ = 16;
            while(_loc2_ < 24)
            {
               this["orbitR" + _loc2_] -= 1.5 * this.speedMod;
               if(this["orbitR" + _loc2_] <= 0)
               {
                  this["orbitR" + _loc2_] += 360;
               }
               this["box" + _loc2_ + "X"] = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(this["orbitR" + _loc2_],1000);
               this["box" + _loc2_ + "Y"] = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(this["orbitR" + _loc2_],1000);
               this["box" + _loc2_ + "X"] = this.movie._x + this["box" + _loc2_ + "X"];
               this["box" + _loc2_ + "Y"] = this.movie._y + this["box" + _loc2_ + "Y"];
               this.game.asteroidArray[_loc2_].groundX = this["box" + _loc2_ + "X"];
               this.game.asteroidArray[_loc2_].groundY = this["box" + _loc2_ + "Y"];
               _loc2_ += 1;
            }
         }
         this.pullTowardsTarget();
         this.updatePosition();
         if(this.phase == 2)
         {
            if(this.alive == true)
            {
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
      }
      if(this.settingN == 38)
      {
         if(this.phase == 1)
         {
            _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
            if(_loc4_ < 320)
            {
               if(this.game.playerObj.movie._y > this.movie._y)
               {
                  this.phase = 2;
                  this.movie.art.art.gotoAndStop("cutscene");
               }
            }
         }
         if(this.phase == 2)
         {
            this.timeN = this.timeN + 1;
            if(this.timeN == 1)
            {
               this.game.inCutscene = true;
               this.startIntro();
            }
            if(this.timeN == 48)
            {
               _loc2_ = 0;
               while(_loc2_ <= this.game.level1cannonArray.length)
               {
                  this.game.level1cannonArray[_loc2_].destroy();
                  _loc2_ += 1;
               }
            }
            if(this.timeN == 192)
            {
               this.game.inCutscene = false;
               this.game.forceSlowMode = false;
               this.phase = 3;
               this.timeN = 0;
               this.dragonFlyX = 6;
            }
         }
         if(this.phase == 3)
         {
            this.timeN = this.timeN + 1;
            if(this.hp > 6)
            {
               if(this.timeN == 24)
               {
                  this.dragonFlyX = 10;
                  this.movie.art.art.art.head.gotoAndStop("still");
                  this.movie.art.art.art.head.gotoAndStop("attackbegin");
               }
               if(this.timeN == 25)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),48,0);
               }
               if(this.timeN == 45)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),48,0);
               }
               if(this.timeN == 55)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),48,0);
                  this.timeN = 26;
               }
            }
            else if(this.hp > 4)
            {
               if(this.timeN == 25)
               {
                  this.dragonFlyX = 10;
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),48,0.1);
               }
               if(this.timeN == 45)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),18,0.1);
               }
               if(this.timeN == 55)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),48,0.1);
                  this.timeN = 26;
               }
            }
            else if(this.hp > 2)
            {
               if(this.timeN == 25)
               {
                  this.dragonFlyX = 11;
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),48,0.2);
               }
               if(this.timeN == 45)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),18,0.2);
               }
               if(this.timeN == 55)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-5,random(12),18,0.2);
                  this.timeN = 26;
               }
            }
            else
            {
               if(this.timeN == 25)
               {
                  this.dragonFlyX = 12;
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-7,random(12),random(10) + 8,0.3);
               }
               if(this.timeN == 35)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-7,random(12),random(10) + 8,0.3);
               }
               if(this.timeN == 45)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-7,random(12),random(10) + 8,0.3);
               }
               if(this.timeN == 50)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-7,random(12),random(10) + 8,0.3);
               }
               if(this.timeN == 55)
               {
                  this.game.generateFireBox(this.movie._x - 80,this.movie._y + 160,-7,random(12),random(10) + 8,0.3);
                  this.timeN = 26;
               }
            }
            if(this.game.fireboxNewest.alive == true)
            {
               this.game.playerObj.startX = this.game.fireboxNewest.movie._x + this.game.fireboxNewest.motionX * 10;
               this.game.playerObj.startY = this.game.fireboxNewest.movie._y - 80;
            }
            _loc4_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x + 33,this.movie._y - 16,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
            var _loc12_ = Math.round(100 - _loc4_ / 10);
            if(_loc12_ < 50)
            {
               _loc12_ = 50;
               this.game.gameplayZoomMotion = 0;
            }
            this.game.gameplayZoomLevel = _loc12_;
            if(this.game.playerObj.inCannon == false)
            {
               if(this.alive == true)
               {
                  if(this.collidable == true)
                  {
                     if(_loc4_ < 70)
                     {
                        this.movie.art.art.art.crab.gotoAndStop("still");
                        this.movie.art.art.art.crab.gotoAndStop("hit");
                        this.bumpDragon();
                        this.dragonDamage();
                     }
                  }
               }
            }
            this.groundX += this.dragonFlyX;
            if(this.game.playerObj.inCannon == false)
            {
               _loc2_ = 1;
               while(_loc2_ <= 4)
               {
                  this.dragonDetectPlayer(_loc2_);
                  _loc2_ += 1;
               }
            }
         }
         else if(this.phase == 4)
         {
            this.timeN = this.timeN + 1;
            var _loc14_ = 380 - this.gameplayHolder._x - this.gameplayWorld._x;
            var _loc17_ = 240 - this.gameplayHolder._y - this.gameplayWorld._y;
            this.gameplayHolder.particleHolder.bossfinaldefeat._x = _loc14_;
            this.gameplayHolder.particleHolder.bossfinaldefeat._y = _loc17_;
            if(this.timeN == 48)
            {
               this.game.gameplayZoomLevel = 100;
               this.game.restoreBoxDragon(this);
               this.movie.gotoAndStop("hide");
            }
         }
         this.pullTowardsTarget();
         this.updatePosition();
      }
      _loc2_ = 0;
      while(_loc2_ < this.game.debrisArray.length)
      {
         this.game.debrisArray[_loc2_].updateGameplay();
         _loc2_ += 1;
      }
      if(this.alive == false)
      {
         if(this.movie._y > this.game.fallZoneObj.movie._y + 100)
         {
            this.game.removeObject(this,this.game.debrisArray);
         }
      }
   }
   function bumpDragon()
   {
      var _loc2_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.playerObj.movie._x,this.game.playerObj.movie._y,this.movie._x,this.movie._y);
      this.pushX = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc2_,40);
      this.pushY = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc2_,20);
      if(this.pushX < 0)
      {
         this.pushX *= -0.5;
      }
      this.pushX += 10;
      this.game.playerObj.motionX = this.pushX * -0.6;
      this.game.playerObj.motionY = this.pushY * -1;
      this.game.playerObj.motionR = Math.abs(this.pushX) + Math.abs(this.pushY);
      if(this.game.playerObj.motionY >= 0)
      {
         this.game.playerObj.motionY = (Math.abs(this.pushY) + Math.abs(this.pushX)) * -0.5;
      }
      this.collidable = false;
   }
   function bumpPuffle()
   {
      var _loc2_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.game.playerObj.movie._x,this.game.playerObj.movie._y,this.movie._x,this.movie._y);
      this.pushX = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc2_,20);
      this.pushY = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc2_,20);
      this.motionX = this.pushX * 1.5;
      this.motionY = this.pushY * 1.5;
      this.game.playerObj.motionX = this.pushX * -0.2;
      this.game.playerObj.motionY = this.pushY * -1;
      this.game.playerObj.motionR = Math.abs(this.pushX) + Math.abs(this.pushY);
      if(this.game.playerObj.motionY >= 0)
      {
         this.game.playerObj.motionY = (Math.abs(this.pushY) + Math.abs(this.pushX)) * -0.5;
      }
      this.collidable = false;
   }
   function pullTowardsTarget()
   {
      if(this.alive == true && this.leaving != true)
      {
         if(this.movie._x > this.groundX)
         {
            this.motionX -= Math.abs(this.movie._x - this.groundX) * this.moveSpeed * this.speedMod;
         }
         else if(this.movie._x < this.groundX)
         {
            this.motionX += Math.abs(this.movie._x - this.groundX) * this.moveSpeed * this.speedMod;
         }
         if(this.movie._y > this.groundY)
         {
            this.motionY -= Math.abs(this.movie._y - this.groundY) * this.moveSpeed * this.speedMod;
         }
         else if(this.movie._y < this.groundY)
         {
            this.motionY += Math.abs(this.movie._y - this.groundY) * this.moveSpeed * this.speedMod;
         }
      }
   }
   function updatePosition()
   {
      this.motionX *= 1 - 0.1 * this.speedMod;
      this.motionY *= 1 - 0.1 * this.speedMod;
      this.movie._x += this.motionX * this.speedMod;
      this.movie._y += this.motionY * this.speedMod;
   }
   function dragonDamage()
   {
      if(this.hp > 0)
      {
         this.hp = this.hp - 1;
         this.gameplayHolder.particleHolder.attachMovie("biff","biff",1);
         this.gameplayHolder.particleHolder.biff._x = this.game.playerObj.movie._x + this.pushX * 3;
         this.gameplayHolder.particleHolder.biff._y = this.game.playerObj.movie._y + this.pushY * 3;
         this.dropDebris(0,0);
         if(this.hp == 0)
         {
            this.alive = false;
            this.phase = 4;
            this.timeN = 0;
            this.dragonFlyX = 0;
            this.movie.art.art.art.head.gotoAndStop("attackend");
            this.movie.art.art.art.crab.gotoAndStop("hide");
            this.game.playerObj.motionX = 0;
            this.game.playerObj.motionY = -27;
            this.game.giantPuffleOObj.movie._x = this.movie._x;
            this.game.giantPuffleOObj.movie._y = this.movie._y + 1000;
            this.game.giantPuffleOObj.startX = this.movie._x + 1500;
            this.game.giantPuffleOObj.startY = this.movie._y;
            this.groundX = this.movie._x;
            this.groundY = this.movie._y;
            this.gameplayHolder.particleHolder.attachMovie("bossfinaldefeat","bossfinaldefeat",2);
            this.gameplayHolder.particleHolder.bossfinaldefeat._x = this.movie._x + 33;
            this.gameplayHolder.particleHolder.bossfinaldefeat._y = this.movie._y - 16;
            this.game.playerObj.startX = this.movie._x;
            this.game.playerObj.startY = this.movie._y - 200;
            this.game.playMusic("win");
            if(this.game["b" + this.settingN + "Defeat"] == false)
            {
               this.game["b" + this.settingN + "Defeat"] = true;
               this.game.bossDefeatsN = this.game.bossDefeatsN + 1;
               if(this.game.bossDefeatsN == 1)
               {
                  this.game.achievementUnlocked("boss1");
               }
               else if(this.game.bossDefeatsN == 3)
               {
                  this.game.achievementUnlocked("boss2");
               }
               else if(this.game.bossDefeatsN == 6)
               {
                  this.game.achievementUnlocked("boss3");
               }
               if(this.game.turboMode == true)
               {
                  this.game.achievementUnlocked("turbo2");
               }
            }
         }
      }
   }
   function takeDamage()
   {
      if(this.hp > 0)
      {
         this.hp = this.hp - 1;
         this.gameplayHolder.particleHolder.attachMovie("biff","biff",1);
         this.gameplayHolder.particleHolder.biff._x = this.game.playerObj.movie._x + this.pushX * 6;
         this.gameplayHolder.particleHolder.biff._y = this.game.playerObj.movie._y + this.pushY * 6;
         this.dropDebris(0,0);
         if(this.hp == 0)
         {
            this.alive = false;
            this.movie.art.art.goingDown = true;
            if(this.game["b" + this.settingN + "Defeat"] == false)
            {
               this.game["b" + this.settingN + "Defeat"] = true;
               this.game.bossDefeatsN = this.game.bossDefeatsN + 1;
               if(this.game.bossDefeatsN == 1)
               {
                  this.game.achievementUnlocked("boss1");
               }
               else if(this.game.bossDefeatsN == 3)
               {
                  this.game.achievementUnlocked("boss2");
               }
               else if(this.game.bossDefeatsN == 6)
               {
                  this.game.achievementUnlocked("boss3");
               }
               if(this.game.turboMode == true)
               {
                  this.game.achievementUnlocked("turbo2");
               }
            }
         }
      }
   }
   function recover()
   {
      trace("hp = " + this.hp);
      if(this.hp <= 0)
      {
         this.alive = false;
         this.movie.art.art.gotoAndStop("finish");
         this.game.giantPuffleOObj.movie._x = this.movie._x;
         this.game.giantPuffleOObj.movie._y = this.movie._y;
         this.game.giantPuffleOObj.startX = this.startX;
         this.game.giantPuffleOObj.startY = this.startY;
         if(this.settingN == 27)
         {
            this.game.giantPuffleOObj.hasBox = true;
         }
      }
      else
      {
         this.collidable = true;
         this.movie.art.art.gotoAndStop("still");
         if(this.settingN == 27)
         {
            this.chase = true;
            this.chaseStartN = this.timeN;
            this.attacking = true;
            this.attackEnd = this.pathTargetN;
         }
      }
   }
   function toggleAttack()
   {
      if(this.attacking == false)
      {
         this.attacking = true;
      }
      else if(this.attacking == true)
      {
         this.attacking = false;
      }
   }
   function dropDebris($offsetX, $offsetY)
   {
      var _loc2_ = 0;
      while(_loc2_ < 5)
      {
         this.debrisN = this.debrisN + 1;
         this.debrisObj = new com.clubpenguin.games.cannon.Debris(this.game,this.gameplayWorld,this.gameplayHolder,this.gameplayHolder.particleHolder,this.debrisN,this.movie._x + $offsetX,this.movie._y + $offsetY,random(5) + 1,this.motionX + (random(41) - 20),this.motionY - 40);
         this.gameplayHolder.particleArray.push(this.debrisObj);
         this.game.debrisArray.push(this.debrisObj);
         _loc2_ += 1;
      }
   }
   function playSFX($sndName)
   {
      var _loc2_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
      if(_loc2_ < 200)
      {
         this.game.sfx[$sndName + 100].gotoAndPlay("on");
      }
      else if(_loc2_ < 300)
      {
         this.game.sfx[$sndName + 80].gotoAndPlay("on");
      }
      else if(_loc2_ < 400)
      {
         this.game.sfx[$sndName + 60].gotoAndPlay("on");
      }
      else if(_loc2_ < 500)
      {
         this.game.sfx[$sndName + 40].gotoAndPlay("on");
      }
      else if(_loc2_ < 600)
      {
         this.game.sfx[$sndName + 20].gotoAndPlay("on");
      }
   }
   function swingSFX()
   {
      var _loc3_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x,this.movie._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
      var _loc2_ = "swing";
      if(_loc3_ >= 400)
      {
         if(this.game.playerObj.movie._x > this.movie._x)
         {
            _loc2_ = "swingL";
         }
         else
         {
            _loc2_ = "swingR";
         }
      }
      if(_loc3_ < 400)
      {
         this.game.sfx[_loc2_ + 100].gotoAndPlay("on");
      }
      else if(_loc3_ < 500)
      {
         this.game.sfx[_loc2_ + 100].gotoAndPlay("on");
      }
      else if(_loc3_ < 600)
      {
         this.game.sfx[_loc2_ + 80].gotoAndPlay("on");
      }
      else if(_loc3_ < 700)
      {
         this.game.sfx[_loc2_ + 60].gotoAndPlay("on");
      }
      else if(_loc3_ < 800)
      {
         this.game.sfx[_loc2_ + 40].gotoAndPlay("on");
      }
      else if(_loc3_ < 900)
      {
         this.game.sfx[_loc2_ + 20].gotoAndPlay("on");
      }
   }
   function invertGravity($boolean)
   {
      trace("SWITCH gravity! to " + $boolean);
      if(this.playerFellDuring == false)
      {
         this.game.gravityInverted = $boolean;
      }
      else
      {
         trace("cancel, cant switch gravity because the player fell since the last time it was switched");
      }
      this.changingGravity = false;
      trace("finished changing gravity");
   }
   function bumpGravityBox($box)
   {
      $box.gotoAndStop("bump");
      if(this.game.gravityInverted == false)
      {
         $box.art.art.gotoAndStop("up");
      }
      else
      {
         $box.art.art.gotoAndStop("down");
      }
   }
   function setBoxArrow()
   {
      if(this.game.gravityInverted == false)
      {
         this.movie.art.art.art.box.art.gotoAndStop("down");
      }
      else
      {
         this.movie.art.art.art.box.art.gotoAndStop("up");
      }
   }
   function dragonDetectPlayer($n)
   {
      var _loc12_ = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie._x + this.movie.art.art._x + this.movie.art.art["c" + $n]._x,this.movie._y + this.movie.art.art._y + this.movie.art.art["c" + $n]._y,this.game.playerObj.movie._x,this.game.playerObj.movie._y);
      var _loc11_ = false;
      var _loc10_ = this.movie._x + this.movie.art.art._x + this.movie.art.art["c" + $n]._x;
      var _loc7_ = this.movie._y + this.movie.art.art._y + this.movie.art.art["c" + $n]._y;
      var _loc2_ = this.game.playerObj.movie._x;
      var _loc3_ = this.game.playerObj.movie._y;
      if($n == 1)
      {
         var _loc8_ = 136;
         var _loc4_ = 136;
         var _loc5_ = 103;
      }
      else if($n == 2)
      {
         _loc8_ = 123;
         _loc4_ = 123;
         _loc5_ = 69;
      }
      else if($n == 3)
      {
         _loc8_ = 188;
         _loc4_ = 188;
         _loc5_ = 139;
      }
      else if($n == 4)
      {
         _loc8_ = 119;
         _loc4_ = 119;
         _loc5_ = 113;
      }
      if(_loc12_ < _loc8_)
      {
         if(_loc2_ > _loc10_ - _loc4_)
         {
            if(_loc2_ < _loc10_ + _loc4_)
            {
               if(_loc3_ > _loc7_ - _loc5_)
               {
                  if(_loc3_ < _loc7_ + _loc5_)
                  {
                     _loc11_ = true;
                  }
               }
            }
         }
      }
      if(_loc11_ == true)
      {
         var _loc13_ = false;
         _loc2_ = this.game.playerObj.halfPosX;
         _loc3_ = this.game.playerObj.halfPosY;
         if(_loc12_ < _loc8_)
         {
            if(_loc2_ > _loc10_ - _loc4_)
            {
               if(_loc2_ < _loc10_ + _loc4_)
               {
                  if(_loc3_ > _loc7_ - _loc5_)
                  {
                     if(_loc3_ < _loc7_ + _loc5_)
                     {
                        _loc13_ = true;
                     }
                  }
               }
            }
         }
      }
      if(_loc13_ == true)
      {
         var _loc14_ = false;
         _loc2_ = this.game.playerObj.onethirdPosX;
         _loc3_ = this.game.playerObj.onethirdPosY;
         if(_loc12_ < _loc8_)
         {
            if(_loc2_ > _loc10_ - _loc4_)
            {
               if(_loc2_ < _loc10_ + _loc4_)
               {
                  if(_loc3_ > _loc7_ - _loc5_)
                  {
                     if(_loc3_ < _loc7_ + _loc5_)
                     {
                        _loc14_ = true;
                     }
                  }
               }
            }
         }
      }
      if(this.alive == true)
      {
         if(_loc11_ == true)
         {
            if(_loc14_ == true)
            {
               _loc2_ = this.game.playerObj.onethirdPosX;
               _loc3_ = this.game.playerObj.onethirdPosY;
            }
            else if(_loc13_ == true)
            {
               _loc2_ = this.game.playerObj.halfPosX;
               _loc3_ = this.game.playerObj.halfPosY;
            }
            else
            {
               _loc2_ = this.game.playerObj.movie._x;
               _loc3_ = this.game.playerObj.movie._y;
            }
            var _loc15_ = com.clubpenguin.math.AaronsPhysics.findAngle(_loc2_,_loc3_,this.movie._x + this.movie.art.art._x + this.movie.art.art["c" + $n]._x,this.movie._y + this.movie.art.art._y + this.movie.art.art["c" + $n]._y);
            var _loc9_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc15_,20);
            if(_loc9_ > 0)
            {
               _loc9_ = 20;
            }
            if(_loc9_ < 0)
            {
               _loc9_ = -20;
            }
            this.pushX = 20;
            this.game.playerObj.motionY = _loc9_ * -1;
            this.game.playerObj.motionX = this.pushX * -1;
            this.game.playerObj.motionR = Math.abs(_loc9_);
         }
      }
   }
   function destroy()
   {
      this.movie.removeMovieClip();
   }
}
