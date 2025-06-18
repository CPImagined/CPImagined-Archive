class com.clubpenguin.game.fish.FishingEngine extends MovieClip
{
   var oj;
   var SHELL;
   var grayFishMode;
   var orangeFishTotal;
   var grayFishTotal;
   var listener;
   var backgroundAudio;
   var mySound;
   var soundInstance;
   var gameDirectory;
   var localeDirectory;
   var loader;
   var start_screen;
   var penguinColor;
   var colorObject;
   var oneup;
   var fish2;
   var gameOverEvent;
   var isBigFishCaught;
   var consecutiveFishCaught;
   var hasLostLife;
   var totalFishCaught;
   var gameRunning;
   var icepoint;
   var hookEmpty;
   var hookPrevPos;
   var hookCurrPos;
   var hookisFalling;
   var lives;
   var level;
   var levelBlock;
   var fishCaught;
   var puffle;
   var sharkActive;
   var crabActive;
   var kickerLeftMove;
   var kickerRightMove;
   var lineisCut;
   var startTime;
   var timer;
   var speedTimer;
   var speed;
   var lineExtra;
   var linesCutByCrab;
   var objArray;
   var fish1;
   var fish3;
   var fish4;
   var fish5;
   var fish6;
   var fish7;
   var fish8;
   var jfish1;
   var jfish2;
   var finLeft;
   var finRight;
   var crab1;
   var crab2;
   var kickerLeft;
   var kickerRight;
   var grayfish1;
   var grayfish2;
   var grayfish3;
   var grayfish4;
   var iceboxArray;
   var iceboxArrayPos;
   var currentFish;
   var greyFishCaught;
   var jellyFishHitCount;
   var sharkLeftMove;
   var sharkRightMove;
   var hook;
   var millisecondsOfTime;
   var minutesGiven;
   var clockTimer;
   var secondsOfTime;
   var minutesOfTime;
   var timeLeft;
   var penguin;
   var line;
   var cutPoint;
   var shark1;
   var shark2;
   var hookFall;
   var groups;
   var icebox;
   var fishblockNum;
   var fishNum;
   var gft;
   var oft;
   var fish;
   var fishflee;
   var grayfishflee;
   var sharkleftDistance;
   var sharkLeft;
   var sharkrightDistance;
   var sharkRight;
   var bigFish;
   var lives_mc;
   var oneupText;
   var prompt;
   var gameOver_mc;
   static var STAMP_SNACK_ATTACK = 372;
   static var STAMP_SHOCK_KING = 374;
   static var STAMP_FISHTASTIC = 376;
   static var STAMP_WORM_WIN = 378;
   static var STAMP_CRAB_CUTS = 380;
   static var STAMP_AFISHIONADO = 382;
   static var STAMP_GRAY_GOODIES = 384;
   static var STAMP_PRIZE_MULLET = 386;
   static var STAMP_FLY_FISHER = 388;
   static var STAMP_ACE_ANGLER = 390;
   static var DEV_STANDALONE = false;
   static var DEV_GRAY_MODE = false;
   function FishingEngine()
   {
      super();
      if(com.clubpenguin.game.fish.FishingEngine.DEV_STANDALONE)
      {
      }
      this.oj = new com.disney.games.fish.OpcodeJournal();
   }
   function frame1()
   {
      this.init();
      this.stop();
      this.createEmptyMovieClip("soundInstance",this.getNextHighestDepth());
   }
   function init()
   {
      this.SHELL = _global.getCurrentShell();
      var _loc3_ = this.SHELL.getMyPlayerId();
      if(_loc3_ == undefined)
      {
         _loc3_ = -1;
      }
      this.oj.init(_loc3_);
      if(this.SHELL.isItemOnMyPlayer(321) || com.clubpenguin.game.fish.FishingEngine.DEV_GRAY_MODE)
      {
         this.grayFishMode = true;
         this.oj.sendEventAction(this.oj.OPCODEGUID_USEFLASHINGLUREFISHINGROD);
      }
      else
      {
         this.grayFishMode = false;
      }
      this.orangeFishTotal = 0;
      this.grayFishTotal = 0;
      if(com.clubpenguin.game.fish.FishingEngine.DEV_STANDALONE)
      {
         com.clubpenguin.util.Loader.setLocaleVersion(undefined);
         com.clubpenguin.util.Loader.setLocale(undefined);
         com.clubpenguin.util.Loader.loadAllMovies(this,[]);
      }
      this.listener = new Object();
      this.listener.onLoadComplete = com.clubpenguin.util.Delegate.create(this,this.onLoadComplete);
      com.clubpenguin.util.Loader.addEventListener(this.listener);
      this.playbackgroundAudio();
   }
   function playbackgroundAudio()
   {
      var _loc2_ = this.createEmptyMovieClip("bgSoundClip",this.getNextHighestDepth());
      var _loc3_ = 45;
      this.backgroundAudio = new Sound(_loc2_);
      this.backgroundAudio.attachSound("backgroundLoop");
      this.backgroundAudio.setVolume(_loc3_);
      this.backgroundAudio.start(0,99);
   }
   function onLoadComplete()
   {
      com.clubpenguin.util.Loader.removeEventListener(this.listener);
      this.gotoAndStop(2);
      this.listener.onLoadComplete = undefined;
   }
   function addSound(clip, volume)
   {
      if(volume == undefined)
      {
         volume = 100;
      }
      this.mySound = new Sound(this.soundInstance);
      this.mySound.setVolume(volume);
      this.mySound.attachSound(clip);
      this.mySound.start();
   }
   function frame2()
   {
      this.stop();
      this.gameDirectory = com.clubpenguin.util.LocaleText.getGameDirectory();
      this.localeDirectory = "lang/" + com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.getLocaleID()) + "/";
      this.loader = new MovieClipLoader();
      this.loader.loadClip(this.gameDirectory + this.localeDirectory + "title.swf",this.start_screen.logo_title);
      this.penguinColor = this.SHELL.getMyPlayerHex();
      this.colorObject = new Color(this.start_screen.penguin_color_screen.penguin_mc);
      this.colorObject.setRGB(this.penguinColor);
   }
   function frame33()
   {
      this.loader.loadClip(this.gameDirectory + this.localeDirectory + "canoworms.swf",this.oneup.obj.canOWorms);
   }
   function frame36()
   {
      this.fish2.play();
   }
   function frame38()
   {
      this.stop();
      this.gameOverEvent;
      this.isBigFishCaught = false;
      this.consecutiveFishCaught = 0;
      this.hasLostLife = false;
      this.totalFishCaught = 0;
      this.gameRunning = true;
      this.icepoint = 122;
      this.hookEmpty = true;
      this.hookPrevPos = this._ymouse;
      this.hookCurrPos = this._ymouse;
      this.hookisFalling = false;
      this.lives = 3;
      this.level = 1;
      this.levelBlock = false;
      this.fishCaught = 0;
      this.puffle._visible = false;
      this.oj.startGame();
      this.sharkActive = false;
      this.crabActive = false;
      this.kickerLeftMove = false;
      this.kickerRightMove = false;
      this.lineisCut = false;
      this.startTime = getTimer();
      this.timer = getTimer();
      this.speedTimer = getTimer();
      this.speed = 4000;
      if(this.grayFishMode == true)
      {
         this.lineExtra = 35;
      }
      else
      {
         this.lineExtra = 0;
      }
      this.linesCutByCrab = 0;
      this.objArray = new Array(this.fish1,this.fish2,this.fish3,this.fish4,this.fish5,this.fish6,this.fish7,this.fish8,this.oneup,this.jfish1,this.jfish2,this.finLeft,this.finRight,this.crab1,this.crab2,this.kickerLeft,this.kickerRight,this.grayfish1,this.grayfish2,this.grayfish3,this.grayfish4);
      this.iceboxArray = new Array(6,8,6,16,18);
      this.iceboxArrayPos = 0;
      this.currentFish = 0;
      this.greyFishCaught = 0;
      this.jellyFishHitCount = 0;
      this.sharkLeftMove = false;
      this.sharkRightMove = false;
      this.hook.isHit = false;
      this.hook.onEnterFrame = com.clubpenguin.util.Delegate.create(this,this.updateHook);
      this.hook.onMouseDown = com.clubpenguin.util.Delegate.create(this,this.hookRelease);
   }
   function updateHook()
   {
      this.hookMove();
      if(this.hook._y > 120)
      {
         this.hazardHit();
      }
   }
   function hookRelease()
   {
      this.fishDrop();
      this.getWorm(0);
   }
   function endOfLevel(curLevel, numberOfFish, tip)
   {
      if(this.fishCaught == numberOfFish)
      {
         if(this.level == curLevel)
         {
            this.puffle.play();
            this.puffle._visible = true;
            this.puffle.obj.levelTip.text = tip;
            this.levelBlock = true;
         }
      }
   }
   function levelUp()
   {
      this.level++;
      this.speed -= 500;
      this.levelBlock = false;
      this.puffle._visible = false;
   }
   function gameSpeed()
   {
      this.speedTimer = getTimer();
      var _loc2_ = undefined;
      _loc2_ = this.speedTimer - this.startTime;
      if(this.speedTimer - this.timer >= this.speed)
      {
         this.timer = this.speedTimer;
         this.groupChoose();
      }
      this.groupPlay();
   }
   function catchFish()
   {
      this.fishCaught++;
      this.speedTimer = getTimer();
      var _loc2_ = undefined;
      _loc2_ = this.speedTimer - this.startTime;
      if(_loc2_ <= 300000 && this.fishCaught == 63)
      {
         com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_FLY_FISHER);
         this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS388_FLYFISHER);
      }
   }
   function countdown()
   {
      this.millisecondsOfTime = this.minutesGiven * 60000 - (this.speedTimer - this.clockTimer);
      this.secondsOfTime = Math.floor(this.millisecondsOfTime / 1000) % 60;
      this.minutesOfTime = Math.floor(this.millisecondsOfTime / 60000);
      this.timeLeft.text = this.minutesOfTime + ":" + (this.secondsOfTime >= 10 ? "" : "0") + this.secondsOfTime;
   }
   function distance(x1, y1, x2, y2)
   {
      var _loc1_ = x2 - x1;
      var _loc2_ = y2 - y1;
      return Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
   }
   function pengCtrl()
   {
      if(this.penguin._currentframe < 10)
      {
         if(this.hook.isHit == true)
         {
            this.penguin.gotoAndStop(3);
         }
         else if(this.hook.isHit == false)
         {
            if(this._ymouse <= this.icepoint)
            {
               this.penguin.gotoAndStop(1);
            }
            else
            {
               this.penguin.gotoAndStop(2);
            }
         }
      }
      if(this.lives < 1)
      {
         this.penguin.wormCan.gotoAndStop(2);
      }
      else
      {
         this.penguin.wormCan.gotoAndStop(1);
      }
   }
   function hookMove()
   {
      if(this._ymouse >= this.line._y + this.lineExtra && this._ymouse < 440)
      {
         this.hook._y = this._ymouse;
      }
      else if(this._ymouse >= 440)
      {
         this.hook._y = 440;
      }
      else
      {
         this.hook._y = this.line._y + this.lineExtra;
      }
      if(this.hookEmpty == true && this.hook.isHit == false)
      {
         this.hookCurrPos = this._ymouse;
         if(this._ymouse <= this.icepoint)
         {
            this.hook.gotoAndStop(2);
         }
         else
         {
            if(this.hookCurrPos < this.hookPrevPos)
            {
               this.hook.gotoAndStop(4);
            }
            else if(this.hookCurrPos > this.hookPrevPos)
            {
               this.hook.gotoAndStop(3);
            }
            else
            {
               this.hook.gotoAndStop(1);
            }
            this.hookPrevPos = this._ymouse;
         }
      }
   }
   function lineScale()
   {
      if(this.line._y < this._ymouse && this._ymouse < 440)
      {
         if(this.lineisCut == false)
         {
            this.line._yscale = this._ymouse - this.line._y;
         }
         else if(this.lineisCut == true)
         {
            if(this._ymouse < this.cutPoint + this.line._y)
            {
               this.line._yscale = this._ymouse - this.line._y;
            }
         }
      }
      else if(this._ymouse >= 440 && !this.lineisCut)
      {
         this.line._yscale = 440 - this.line._y;
      }
      else if(this.line._y > this._ymouse && !this.lineisCut)
      {
         this.line._yscale = 0;
      }
   }
   function lineCut(collider)
   {
      if(collider == this.crab1 || collider == this.crab2)
      {
         if(this.hook._currentframe == 5)
         {
            this.fishFlees();
         }
         if(this.hook._currentframe == 7)
         {
            this.grayfishFlees();
         }
      }
      if(collider != this.shark1 && collider != this.shark2)
      {
         this.hookisFalling = true;
      }
      if(this.hookisFalling == true)
      {
         this.hookFall._x = this.hook._x;
         this.hookFall.mask._y = collider._y - this._ymouse;
      }
      this.lineisCut = true;
      this.hook.isHit = true;
      this.hook._visible = false;
      this.hook.gotoAndStop("empty");
      this.line._yscale = collider._y - this.line._y;
      this.cutPoint = collider._y - this.line._y;
   }
   function lineMask()
   {
      if(this.lineisCut == false)
      {
         if(this.hookisFalling == false)
         {
            this.hookFall._y = this._ymouse;
         }
         else
         {
            this.hookFall.gotoAndStop(1);
            this.hookFall._x = 900;
            this.hookisFalling = false;
         }
      }
      if(this.lineisCut == true)
      {
         if(this.hookFall._y < 800)
         {
            this.hookFall.gotoAndStop(2);
            this.hookFall._y += 20;
         }
         else
         {
            this.hookFall.gotoAndStop(1);
            this.hookFall._x = 900;
            this.hookisFalling = false;
         }
      }
   }
   function objChoose(stopwatch, item)
   {
      if(this.speedTimer - this.timer >= stopwatch && this.speedTimer - this.timer <= stopwatch + 200)
      {
         if(item >= 0 && item <= 7)
         {
            this.objArray[item].play();
         }
         else if(item == 8 && this.lives < 3)
         {
            this.objArray[item].play();
         }
         else if(item == 9 || item == 10)
         {
            this.objArray[item].play();
         }
         else if(item == 11 || item == 12)
         {
            if(!this.sharkActive)
            {
               this.objArray[item].play();
            }
         }
         else if(item == 13 || item == 14)
         {
            if(!this.crabActive)
            {
               this.objArray[item].play();
            }
         }
         else if(item == 15)
         {
            if(!this.kickerLeftMove)
            {
               this.kickerLeft.obj.gotoAndStop(Math.round(Math.random() * 1 + 1));
               this.kickerLeft._y = Math.random() * 200 + 235;
               this.kickerLeftMove = true;
            }
         }
         else if(item == 16)
         {
            if(!this.kickerRightMove)
            {
               this.kickerRight.obj.gotoAndStop(Math.round(Math.random() * 1 + 1));
               this.kickerRight._y = Math.random() * 200 + 235;
               this.kickerRightMove = true;
            }
         }
         else if(item >= 17 && item <= 20)
         {
            if(this.fishCaught < 56 && this.grayFishMode)
            {
               this.objArray[item].play();
            }
         }
      }
   }
   function groupChoose()
   {
      if(this.level == 1)
      {
         this.groups = Math.floor(Math.random() * 10 + 1);
      }
      else if(this.level == 2)
      {
         this.groups = Math.floor(Math.random() * 20 + 1);
      }
      else if(this.level == 3)
      {
         this.groups = Math.floor(Math.random() * 30 + 1);
      }
      else if(this.level == 4)
      {
         this.groups = Math.floor(Math.random() * 30 + 11);
      }
   }
   function groupPlay()
   {
      if(this.groups == 0)
      {
         this.objChoose(100,18);
         this.objChoose(800,20);
         this.objChoose(1200,5);
      }
      else if(this.groups == 1)
      {
         this.objChoose(100,0);
         this.objChoose(400,15);
         this.objChoose(800,18);
         this.objChoose(1500,6);
      }
      else if(this.groups == 2)
      {
         this.objChoose(300,7);
         this.objChoose(1400,3);
      }
      else if(this.groups == 3)
      {
         this.objChoose(1200,5);
         this.objChoose(1900,16);
      }
      else if(this.groups == 4)
      {
         this.objChoose(100,15);
         this.objChoose(600,1);
         this.objChoose(900,5);
         this.objChoose(1500,18);
      }
      else if(this.groups == 5)
      {
         this.objChoose(300,4);
         this.objChoose(800,3);
         this.objChoose(900,15);
      }
      else if(this.groups == 6)
      {
         this.objChoose(200,7);
         this.objChoose(300,15);
         this.objChoose(1900,6);
      }
      else if(this.groups == 7)
      {
         this.objChoose(300,4);
         this.objChoose(800,2);
      }
      else if(this.groups == 8)
      {
         this.objChoose(300,7);
         this.objChoose(400,16);
         this.objChoose(800,20);
      }
      else if(this.groups == 9)
      {
         this.objChoose(500,2);
         this.objChoose(800,20);
      }
      else if(this.groups == 10)
      {
         this.objChoose(100,16);
         this.objChoose(200,2);
         this.objChoose(900,3);
      }
      else if(this.groups == 11)
      {
         this.objChoose(100,15);
         this.objChoose(200,16);
         this.objChoose(800,3);
         this.objChoose(1200,19);
      }
      else if(this.groups == 12)
      {
         this.objChoose(100,6);
         this.objChoose(2000,3);
         this.objChoose(2200,9);
      }
      else if(this.groups == 13)
      {
         this.objChoose(500,8);
      }
      else if(this.groups == 14)
      {
         this.objChoose(800,6);
         this.objChoose(1200,10);
      }
      else if(this.groups == 15)
      {
         this.objChoose(400,3);
         this.objChoose(1000,6);
         this.objChoose(1100,10);
      }
      else if(this.groups == 16)
      {
         this.objChoose(100,17);
         this.objChoose(800,20);
         this.objChoose(1600,1);
      }
      else if(this.groups == 17)
      {
         this.objChoose(900,10);
         this.objChoose(1200,9);
      }
      else if(this.groups == 18)
      {
         this.objChoose(900,9);
         this.objChoose(1200,10);
         this.objChoose(1300,7);
      }
      else if(this.groups == 19)
      {
         this.objChoose(200,9);
         this.objChoose(400,4);
         this.objChoose(1300,3);
      }
      else if(this.groups == 20)
      {
         this.objChoose(900,10);
         this.objChoose(1200,17);
         this.objChoose(2400,9);
      }
      else if(this.groups == 21)
      {
         this.objChoose(100,11);
      }
      else if(this.groups == 22)
      {
         this.objChoose(100,12);
      }
      else if(this.groups == 23)
      {
         this.objChoose(200,11);
         this.objChoose(400,6);
         this.objChoose(1300,9);
      }
      else if(this.groups == 24)
      {
         this.objChoose(900,12);
         this.objChoose(1000,15);
         this.objChoose(1900,2);
      }
      else if(this.groups == 25)
      {
         this.objChoose(100,10);
         this.objChoose(2000,11);
      }
      else if(this.groups == 26)
      {
         this.objChoose(100,15);
         this.objChoose(500,11);
         this.objChoose(900,7);
      }
      else if(this.groups == 27)
      {
         this.objChoose(100,6);
         this.objChoose(900,12);
      }
      else if(this.groups == 28)
      {
         this.objChoose(200,0);
         this.objChoose(900,12);
         this.objChoose(1900,9);
      }
      else if(this.groups == 29)
      {
         this.objChoose(600,9);
         this.objChoose(1200,17);
      }
      else if(this.groups == 30)
      {
         this.objChoose(500,2);
         this.objChoose(1200,16);
         this.objChoose(1700,12);
      }
      else if(this.groups == 31)
      {
         this.objChoose(400,13);
      }
      else if(this.groups == 32)
      {
         this.objChoose(400,14);
      }
      else if(this.groups == 33)
      {
         this.objChoose(100,13);
         this.objChoose(1900,14);
      }
      else if(this.groups == 34)
      {
         this.objChoose(400,13);
         this.objChoose(800,1);
         this.objChoose(1600,9);
      }
      else if(this.groups == 35)
      {
         this.objChoose(700,14);
         this.objChoose(800,5);
         this.objChoose(1600,12);
         this.objChoose(2400,19);
      }
      else if(this.groups == 36)
      {
         this.objChoose(200,9);
         this.objChoose(1600,10);
         this.objChoose(1700,3);
      }
      else if(this.groups == 37)
      {
         this.objChoose(600,8);
         this.objChoose(1200,10);
         this.objChoose(1900,14);
      }
      else if(this.groups == 38)
      {
         this.objChoose(100,8);
         this.objChoose(200,18);
         this.objChoose(900,4);
         this.objChoose(2200,14);
      }
      else if(this.groups == 39)
      {
         this.objChoose(1000,7);
         this.objChoose(1200,15);
      }
      else if(this.groups == 40)
      {
         this.objChoose(300,17);
         this.objChoose(1400,13);
         this.objChoose(2800,1);
      }
   }
   function yOffset(amt)
   {
      return Math.random() * amt;
   }
   function hazardHit()
   {
      if(this.level > 0)
      {
         this.fishHit();
         this.kickerHit();
         this.grayFishHit();
      }
      if(this.level > 1)
      {
         this.jfishHit();
         this.oneupHit();
      }
      if(this.level > 2)
      {
         this.sharkHit();
      }
   }
   function fishHit()
   {
      if(this.hook._currentframe < 5)
      {
         var _loc3_ = 1;
         while(_loc3_ < 9)
         {
            var _loc2_ = this["fish" + _loc3_];
            if(_loc2_._currentframe > 1)
            {
               if(_loc2_.obj.hotspot.hitTest(this.hook.hotspot))
               {
                  _loc2_.gotoAndStop(1);
                  this.hook.gotoAndStop(5);
                  this.hookEmpty = false;
                  this.addSound("chomp");
               }
            }
            _loc3_ += 1;
         }
      }
   }
   function addFish(col)
   {
      if(this.currentFish == this.iceboxArray[this.iceboxArrayPos])
      {
         this.currentFish = 1;
         this.iceboxArrayPos += 1;
         this.icebox.nextFrame();
      }
      else
      {
         this.currentFish += 1;
      }
      this.fishblockNum = "fishblock" + this.iceboxArrayPos;
      this.icebox[this.fishblockNum].nextFrame();
      this.fishNum = "fish" + this.currentFish;
      if(col == "gray")
      {
         this.icebox[this.fishblockNum][this.fishNum].gotoAndStop(2);
         this.grayFishTotal += 1;
         this.gft.text = this.grayFishTotal.toString();
      }
      else
      {
         this.orangeFishTotal += 1;
         this.oft.text = this.orangeFishTotal.toString();
      }
   }
   function fishDrop()
   {
      if(this.hook._currentframe == 5)
      {
         if(this._ymouse <= this.icepoint)
         {
            this.consecutiveFishCaught++;
            if(this.consecutiveFishCaught == 15)
            {
               com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_FISHTASTIC);
               this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS376_FISHTASTIC);
            }
            if(this.consecutiveFishCaught == 45)
            {
               com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_AFISHIONADO);
               this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS382_AFISHIONADO);
            }
            this.hook.gotoAndStop(2);
            this.addFish();
            this.catchFish();
            this.icebox.fishNum.text = this.fishCaught;
            if(this.fishCaught == 1)
            {
               this.icebox.fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fish",[""]) + " ";
            }
            else
            {
               this.icebox.fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fishies",[""]) + " ";
               if(this.fishCaught == 0 && com.clubpenguin.util.LocaleText.getLocaleID() == com.clubpenguin.util.LocaleText.LANG_ID_FR)
               {
                  this.fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fish",[""]) + " ";
               }
            }
            this.addSound("fishicebox");
         }
         else
         {
            this.hook.gotoAndStop(1);
            this.fishFlees();
         }
         this.hookEmpty = true;
      }
      else if(this.hook._currentframe == 7)
      {
         if(this._ymouse <= this.icepoint)
         {
            this.consecutiveFishCaught++;
            this.greyFishCaught++;
            if(this.greyFishCaught == 15)
            {
               com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_GRAY_GOODIES);
               this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS384_GRAYGOODIES);
            }
            if(this.consecutiveFishCaught == 15)
            {
               com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_FISHTASTIC);
               this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS376_FISHTASTIC);
            }
            if(this.consecutiveFishCaught == 45)
            {
               com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_AFISHIONADO);
               this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS382_AFISHIONADO);
            }
            this.hook.gotoAndStop(2);
            this.addFish("gray");
            this.catchFish();
            this.icebox.fishNum.text = this.fishCaught;
            if(this.fishCaught == 1)
            {
               this.icebox.fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fish",[""]) + " ";
            }
            else if(this.fishCaught == 0 && com.clubpenguin.util.LocaleText.getLocaleID() == com.clubpenguin.util.LocaleText.LANG_ID_FR)
            {
               this.fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fish",[""]) + " ";
            }
            this.addSound("fishicebox");
         }
         else
         {
            this.hook.gotoAndStop(1);
            this.grayfishFlees();
         }
         this.hookEmpty = true;
      }
   }
   function fishFlees()
   {
      this.consecutiveFishCaught = 0;
      this.addSound("fishfleesound");
      this.fishflee._x = this.hook._x;
      this.fishflee._y = this.hook._y;
      this.fishflee.gotoAndPlay(2);
   }
   function grayfishFlees()
   {
      this.consecutiveFishCaught = 0;
      this.addSound("fishfleesound");
      this.grayfishflee._x = this.hook._x;
      this.grayfishflee._y = this.hook._y;
      this.grayfishflee.gotoAndPlay(2);
   }
   function jfishHit()
   {
      if(this.hook.isHit == false)
      {
         var _loc3_ = 1;
         while(_loc3_ < 3)
         {
            var _loc2_ = this["jfish" + _loc3_];
            if(_loc2_._currentframe > 1)
            {
               if(_loc2_.obj.hotspot.hitTest(this.hook.hotspot) || _loc2_.obj.hotspot.hitTest(this.line))
               {
                  this.hook.isHit = true;
                  if(this.hook._currentframe == 5)
                  {
                     this.fishFlees();
                  }
                  else if(this.hook._currentframe == 7)
                  {
                     this.grayfishFlees();
                  }
                  this.jellyFishHitCount++;
                  this.oj.sendEventAction(this.oj.OPCODEGUID_STUNGBYJELLYFISH);
                  this.hook.gotoAndStop(6);
                  this.line.gotoAndStop(2);
                  this.penguin.gotoAndStop("electro");
               }
            }
            _loc3_ += 1;
         }
      }
   }
   function sharkLeftDist()
   {
      this.sharkleftDistance = this.distance(this.sharkLeft._x,this.sharkLeft._y,this.hook._x,this.hook._y);
      if(this.sharkleftDistance < 150)
      {
         if(this.lineisCut == false)
         {
            this.sharkLeft.gotoAndStop(2);
         }
         else
         {
            this.sharkLeft.gotoAndStop(1);
         }
      }
      else
      {
         this.sharkLeft.gotoAndStop(1);
      }
   }
   function sharkRightDist()
   {
      this.sharkrightDistance = this.distance(this.sharkRight._x,this.sharkRight._y,this.hook._x,this.hook._y);
      if(this.sharkrightDistance < 150)
      {
         if(this.lineisCut == false)
         {
            this.sharkRight.gotoAndStop(2);
         }
         else
         {
            this.sharkRight.gotoAndStop(1);
         }
      }
      else
      {
         this.sharkRight.gotoAndStop(1);
      }
   }
   function sharkHit()
   {
      if(this.hook.isHit == false)
      {
         if(this.sharkLeft.hotspot.hitTest(this.hook.hotspot))
         {
            if(!this.hookEmpty)
            {
               this.feedTheShark();
            }
            this.lineCut(this.sharkLeft);
         }
         if(this.sharkRight.hotspot.hitTest(this.hook.hotspot))
         {
            if(!this.hookEmpty)
            {
               this.feedTheShark();
            }
            this.lineCut(this.sharkRight);
         }
      }
   }
   function feedTheShark()
   {
      this.consecutiveFishCaught = 0;
      com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_SNACK_ATTACK);
      this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS372_SNACKATTACK);
      this.addSound("shark");
      this.oj.sendEventAction(this.oj.OPCODEGUID_ATEBYSHARK);
   }
   function crabHit()
   {
      if(this.hook.isHit == false)
      {
         if(this.crab1.hotspot.hitTest(this.line))
         {
            this.crabCutTheLine(this.crab1);
         }
         if(this.crab2.hotspot.hitTest(this.line))
         {
            this.crabCutTheLine(this.crab2);
         }
      }
   }
   function crabCutTheLine(_targetCrab)
   {
      this.linesCutByCrab++;
      this.lineCut(_targetCrab);
      this.oj.sendEventAction(this.oj.OPCODEGUID_CLIPPEDBYCRAB);
   }
   function kickerHit()
   {
      if(this.kickerLeft.obj.hotspot.hitTest(this.hook.hotspot))
      {
         if(this.hook._currentframe == 5)
         {
            this.hook.gotoAndStop(1);
            this.fishFlees();
            this.hookMove();
            this.hookEmpty = true;
            if(this.kickerLeft.obj._currentframe == 1)
            {
               this.oj.sendEventAction(this.oj.OPCODEGUID_KICKEDBYBOOT);
            }
            else if(this.kickerLeft.obj._currentframe == 2)
            {
               this.oj.sendEventAction(this.oj.OPCODEGUID_HITBYBARREL);
            }
         }
         if(this.hook._currentframe == 7)
         {
            this.hook.gotoAndStop(1);
            this.grayfishFlees();
            this.hookMove();
            this.hookEmpty = true;
            if(this.kickerLeft.obj._currentframe == 1)
            {
               this.oj.sendEventAction(this.oj.OPCODEGUID_KICKEDBYBOOT);
            }
            else if(this.kickerLeft.obj._currentframe == 2)
            {
               this.oj.sendEventAction(this.oj.OPCODEGUID_HITBYBARREL);
            }
         }
      }
      if(this.kickerRight.obj.hotspot.hitTest(this.hook.hotspot))
      {
         if(this.hook._currentframe == 5)
         {
            this.hook.gotoAndStop(1);
            this.fishFlees();
            this.hookMove();
            this.hookEmpty = true;
            if(this.kickerRight.obj._currentframe == 1)
            {
               this.oj.sendEventAction(this.oj.OPCODEGUID_KICKEDBYBOOT);
            }
            else if(this.kickerRight.obj._currentframe == 2)
            {
               this.oj.sendEventAction(this.oj.OPCODEGUID_HITBYBARREL);
            }
         }
         if(this.hook._currentframe == 7)
         {
            this.hook.gotoAndStop(1);
            this.grayfishFlees();
            if(this.kickerRight.obj._currentframe == 1)
            {
               this.oj.sendEventAction(this.oj.OPCODEGUID_KICKEDBYBOOT);
            }
            else if(this.kickerRight.obj._currentframe == 2)
            {
               this.oj.sendEventAction(this.oj.OPCODEGUID_HITBYBARREL);
            }
         }
         this.hookMove();
         this.hookEmpty = true;
      }
   }
   function grayFishHit()
   {
      if(this.hook._currentframe < 5)
      {
         var _loc3_ = 1;
         while(_loc3_ < 5)
         {
            var _loc2_ = this["grayfish" + _loc3_];
            if(_loc2_._currentframe > 1)
            {
               if(_loc2_.obj.hotspot.hitTest(this.hook.hotspot))
               {
                  _loc2_.gotoAndStop(1);
                  this.hook.gotoAndStop(7);
                  this.hookEmpty = false;
                  this.addSound("chomp");
               }
            }
            _loc3_ += 1;
         }
      }
   }
   function bigFishHit()
   {
      if(this.bigFish._currentframe < 165)
      {
         if(this.bigFish.obj.disthotspot.hitTest(this.hook.hotspot))
         {
            this.bigFish.obj.gotoAndStop(2);
         }
         else
         {
            this.bigFish.obj.gotoAndStop(1);
         }
      }
      if(this.bigFish.obj.hotspot.hitTest(this.hook.hotspot))
      {
         this.oj.sendEventAction(this.oj.OPCODEGUID_CATCHMULLET);
         this.isBigFishCaught = true;
         this.nextFrame();
      }
   }
   function oneupHit()
   {
      if(this.oneup.obj.hotspot.hitTest(this.hook.hotspot) && this.oneup._alpha == 100 && this.hook._currentframe < 50)
      {
         this.oneup._alpha -= 10;
         this.lives++;
         this.lives_mc.lives.text = this.lives;
         this.oneupText.mc.label.text = com.clubpenguin.util.LocaleText.getText("ingame_1UP");
         this.oneupText._x = 367;
         this.oneupText._y = 330;
         this.oneupText.play();
         this.addSound("ding");
         this.oj.sendEventAction(this.oj.OPCODEGUID_CATCHCANOFWORMS);
      }
      if(this.oneup._alpha < 100)
      {
         this.oneup._alpha -= 10;
      }
      if(this.oneup._alpha < 10)
      {
         this.oneup.gotoAndStop(1);
         this.oneup._alpha = 100;
      }
   }
   function needWorm()
   {
      this.prompt.gotoAndStop(2);
   }
   function getWorm(yvar)
   {
      if(this.lives > 0)
      {
         if(this.prompt._currentframe == 2 && this._ymouse <= this.icepoint + yvar)
         {
            this.hook.gotoAndStop(2);
            this.prompt.gotoAndStop(1);
            this.hook._visible = true;
            this.hook.isHit = false;
            this.hookEmpty = true;
            this.loseLife();
            this.lineisCut = false;
         }
      }
   }
   function loseLife()
   {
      this.hook.isHit = false;
      this.hasLostLife = true;
      this.lives--;
      this.lives_mc.lives.text = this.lives;
      this.hook._visible = true;
   }
   function gameOver()
   {
      if(!this.isBigFishCaught)
      {
         this.oj.sendEventAction(this.oj.OPCODEGUID_DIDNTCATCHMULLET);
      }
      this.gameRunning = false;
      this.hook._visible = false;
      this.gameOver_mc._visible = true;
      if(this.grayFishMode)
      {
         this.gameOver_mc.gotoAndStop(2);
         this.gameOver_mc.fishNum.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_yellowfishscore",["" + this.orangeFishTotal,"" + this.orangeFishTotal * 4]) + "\n" + com.clubpenguin.util.LocaleText.getTextReplaced("ingame_grayfishscore",["" + this.grayFishTotal,"" + this.grayFishTotal * 8]);
      }
      else
      {
         this.gameOver_mc.fishNum.text = com.clubpenguin.util.LocaleText.getTextReplaced("ui_fishcaught",["" + this.fishCaught]);
      }
   }
   function getCoins(bonus)
   {
      var _loc3_ = new Object();
      _loc3_.coins = this.orangeFishTotal * 4 + this.grayFishTotal * 8 + bonus;
      _loc3_.score = _loc3_.coins;
      this.oj.sendGameScore(this.gameOverEvent,this.orangeFishTotal + this.grayFishTotal,_loc3_.coins);
      this.oj.stopGame();
      _root.showWindow("Game Over",_loc3_);
   }
   function frame39()
   {
      com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_PRIZE_MULLET);
      this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS386_PRIZEMULLET);
      if(this.jellyFishHitCount >= 3)
      {
         com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_SHOCK_KING);
         this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS374_SHOCKKING);
      }
      if(this.linesCutByCrab >= 3)
      {
         com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_CRAB_CUTS);
         this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS380_CRABCUTS);
      }
      if(this.greyFishCaught >= 15 && !this.hasLostLife)
      {
         com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_ACE_ANGLER);
         this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS390_ACEANGLER);
      }
      if(!this.hasLostLife)
      {
         com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.game.fish.FishingEngine.STAMP_WORM_WIN);
         this.oj.sendStampOpcodes(this.oj.OPCODEGUID_STAMPS378_WORMWIN);
      }
      this.stop();
   }
}
