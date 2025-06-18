class com.clubpenguin.games.cannon.Menus
{
   var game;
   var hud;
   var movie;
   var screenType;
   var motionX;
   var motionY;
   var motionXscale;
   var motionYscale;
   var targetDistance;
   var rewardBarIconOver;
   var rewardPopupOpen;
   var popupShowing;
   var popupDone;
   var popupPhaseN;
   var popupPaused;
   var nextPhase;
   var nextPhaseWait;
   var existingLevels;
   var gamePlayerPuffleOs;
   var gameTotalPuffleOs;
   var gameBestTimeN;
   var availableLevels;
   var playerPuffleOs;
   var totalPuffleOs;
   var timeN;
   var minuteN;
   var secondN;
   var popupNeeded;
   var selectingEnabled;
   var currButton;
   var targetXpos;
   var targetYpos;
   function Menus($game, $hud, $movie, $screenType)
   {
      trace("Creating a menu0");
      this.game = $game;
      this.hud = $hud;
      this.movie = $movie;
      this.movie._x = 0;
      this.movie._y = 0;
      this.screenType = $screenType;
      this.movie.gotoAndStop(this.screenType);
      this.movie.art.game = this.game;
      this.motionX = 0;
      this.motionY = 0;
      this.motionXscale = 0;
      this.motionYscale = 0;
      this.targetDistance = 100;
      this.rewardBarIconOver = false;
      this.rewardPopupOpen = false;
   }
   function setup($area, $levelJustCompleted)
   {
      this.game.inGameplay = false;
      if($area == 2 || $area == 3)
      {
         var _loc8_ = false;
         var _loc7_ = _global.getCurrentShell();
         var _loc9_ = _global.getCurrentInterface();
         if(_loc7_.isMyPlayerMember != undefined)
         {
            _loc8_ = _loc7_.isMyPlayerMember();
            if(!_loc8_)
            {
               _loc9_.showContent("oops_game_puffle_launch");
               $area = 1;
            }
         }
      }
      this.popupShowing = false;
      this.popupDone = false;
      this.popupPhaseN = 0;
      this.popupPaused = false;
      this.nextPhase = 0;
      this.nextPhaseWait = 48;
      this.movie.art.gotoAndStop($area);
      this.game.areaNum = $area;
      this.existingLevels = this.game.existingLevels;
      var _loc3_ = 1;
      while(_loc3_ <= this.existingLevels)
      {
         this.movie.art["level" + _loc3_].box.gotoAndStop("area" + $area);
         _loc3_ += 1;
      }
      this.gamePlayerPuffleOs = 0;
      this.gameTotalPuffleOs = 0;
      this.gameBestTimeN = 0;
      this.availableLevels = this.game.availableLevels;
      _loc3_ = 1;
      while(_loc3_ <= this.availableLevels)
      {
         this.movie.art["level" + _loc3_].box.lock.gotoAndStop("circle");
         this.movie.art["level" + _loc3_].stats.gotoAndStop("show");
         this.movie.art["level" + _loc3_].stats.levelNum = _loc3_;
         this.movie.art["level" + _loc3_].stats.icons.gotoAndStop("scores");
         this.playerPuffleOs = this.game["level" + _loc3_ + "playerPuffleOs"];
         this.totalPuffleOs = this.game["level" + _loc3_ + "totalPuffleOs"];
         this.gamePlayerPuffleOs += this.playerPuffleOs;
         this.gameTotalPuffleOs += this.totalPuffleOs;
         this.game.gamePlayerPuffleOs = this.gamePlayerPuffleOs;
         if(this.playerPuffleOs == 0)
         {
            this.movie.art["level" + _loc3_].stats.ratingScore = " ";
            var _loc5_ = true;
         }
         else
         {
            this.movie.art["level" + _loc3_].stats.ratingScore = this.playerPuffleOs + " / " + this.totalPuffleOs;
         }
         this.movie.art["level" + _loc3_].puffleo.gotoAndStop(this.game["level" + _loc3_ + "ranking"]);
         if(this.game["level" + _loc3_ + "bestTime"] * 0 == 0 && this.game.area1LevelsMastered == true && this.game.area2LevelsMastered == true && this.game.area3LevelsMastered == true)
         {
            this.timeN = this.game["level" + _loc3_ + "bestTime"];
            this.gameBestTimeN += this.timeN;
            this.minuteN = Math.floor(this.timeN / 60);
            this.secondN = this.timeN - this.minuteN * 60;
            if(this.secondN < 10)
            {
               this.movie.art["level" + _loc3_].stats.bestTime = this.minuteN + " :0" + this.secondN;
            }
            else
            {
               this.movie.art["level" + _loc3_].stats.bestTime = this.minuteN + " : " + this.secondN;
            }
         }
         else
         {
            this.movie.art["level" + _loc3_].stats.bestTime = " ";
            var _loc4_ = true;
            this.movie.art["level" + _loc3_].stats.icons.clock.gotoAndStop("hide");
         }
         if(_loc4_ == true && _loc5_ == true)
         {
            this.movie.art["level" + _loc3_].stats.icons.gotoAndStop("new");
         }
         _loc3_ += 1;
      }
      if(this.gameBestTimeN > 0)
      {
         this.minuteN = Math.floor(this.gameBestTimeN / 60);
         this.secondN = this.gameBestTimeN - this.minuteN * 60;
         if(this.secondN < 10)
         {
            this.movie.art.gameBestTime = this.minuteN + ":0" + this.secondN;
         }
         else
         {
            this.movie.art.gameBestTime = this.minuteN + ":" + this.secondN;
         }
      }
      else
      {
         this.movie.art.gameBestTime = " ";
      }
      this.updateRewardProgressBar();
      this.updateRewardIcon();
      this.updateTurboArt(this.game.turboMode);
      if($levelJustCompleted == true)
      {
         this.popupNeeded = true;
         this.popupPhaseN = 0;
         this.selectingEnabled = false;
         this.movie.art.popup.gotoAndStop("show");
         this.movie.art.fadebox.gotoAndStop("show");
         this.game.levelJustCompleted = false;
         if(this.game.gameMode == "standardGameplay")
         {
            if(this.game.anyImprovement == true)
            {
               if(this.game.saveDataOn == true)
               {
                  _loc8_ = false;
                  _loc7_ = _global.getCurrentShell();
                  if(_loc7_.isMyPlayerMember != undefined)
                  {
                     _loc8_ = _loc7_.isMyPlayerMember();
                     if(_loc8_)
                     {
                        trace("[Menus] game.savePlayerData");
                        this.game.savePlayerData();
                     }
                  }
               }
            }
         }
      }
      else if($levelJustCompleted == false)
      {
         this.popupNeeded = false;
         this.popupDone = true;
         this.finishSetup();
      }
   }
   function update()
   {
      if(this.popupNeeded == true)
      {
         if(this.popupDone == false)
         {
            if(this.popupPaused == false)
            {
               if(this.nextPhaseWait > 0)
               {
                  this.nextPhaseWait = this.nextPhaseWait - 1;
               }
               else
               {
                  this.nextPhaseWait = 48;
                  this.popupPaused = true;
                  if(this.nextPhase == 0)
                  {
                     this.popupPhaseN = this.popupPhaseN + 1;
                  }
                  else
                  {
                     this.popupPhaseN = this.nextPhase;
                     this.nextPhase = 0;
                  }
               }
            }
            else
            {
               this["popupPhase" + this.popupPhaseN]();
            }
         }
      }
      if(this.rewardPopupOpen == true || this.selectingEnabled == false)
      {
         var _loc3_ = 1;
         while(_loc3_ <= this.availableLevels)
         {
            this.currButton = this.movie.art["level" + _loc3_];
            this.currButton.useHandCursor = false;
            _loc3_ += 1;
         }
         this.movie.art.areabtns.gotoAndStop("hide");
      }
      else
      {
         _loc3_ = 1;
         while(_loc3_ <= this.availableLevels)
         {
            this.currButton = this.movie.art["level" + _loc3_];
            this.currButton.useHandCursor = true;
            _loc3_ += 1;
         }
         this.movie.art.areabtns.gotoAndStop("show");
      }
      if(this.rewardBarIconOver == true)
      {
         if(this.selectingEnabled == true)
         {
            this.movie.art.rewardProgressBar.icons.gotoAndStop("big");
            this.movie.art.rewardProgressBar.icons.blueprint.gotoAndStop(this.game.targetRewardN);
            this.rewardPopupOpen = true;
            if(this.game.targetRewardN >= 11)
            {
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.slomotxt,"txt_slomo");
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.art.gamecompletetxt,"txt_gamecomplete");
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.besttimetxt,"txt_besttime");
            }
            else if(this.game.targetRewardN >= 10)
            {
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.dareturbotxt,"txt_dareturbo");
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.besttimetxt,"txt_besttime");
            }
            else if(this.game.targetRewardN >= 7)
            {
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.timetrialtxt,"txt_timetrial");
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.theclocktxt,"txt_theclock");
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.besttimetxt,"txt_besttime");
               if(this.game.targetRewardN == 7)
               {
                  com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.time1txt,"txt_time1");
               }
               else if(this.game.targetRewardN == 8)
               {
                  com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.time2txt,"txt_time2");
               }
               else if(this.game.targetRewardN == 9)
               {
                  com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.time3txt,"txt_time3");
               }
            }
            else if(this.game.targetRewardN >= 4)
            {
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.buildcannonepictxt,"txt_buildcannonepic");
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.nextparttxt,"txt_nextpart");
            }
            else
            {
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.buildcannontxt,"txt_buildcannon");
               com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.nextparttxt,"txt_nextpart");
            }
            if(this.game.targetRewardN >= 10)
            {
               this.updateTurboArt(this.game.turboMode);
            }
         }
      }
      else if(this.rewardPopupOpen == true)
      {
         var _loc5_ = true;
         if(this.game._ymouse < 140)
         {
            _loc5_ = false;
         }
         if(this.game._ymouse < 180)
         {
            if(this.game._xmouse < 320 || this.game._xmouse > 450)
            {
               _loc5_ = false;
            }
         }
         if(this.game._xmouse < 200 || this.game._xmouse > 580)
         {
            _loc5_ = false;
         }
         if(_loc5_ == false)
         {
            this.movie.art.rewardProgressBar.icons.gotoAndStop("small");
            this.rewardPopupOpen = false;
            this.updateRewardIcon();
         }
      }
      if(this.game.targetRewardN == 2)
      {
         this.game.achievementUnlocked("buildCannon1");
      }
      if(this.game.targetRewardN == 4)
      {
         this.game.achievementUnlocked("buildCannon2");
         if(this.game.wonNormalCannon == false)
         {
            var _loc4_ = _global.getCurrentShell();
            if(_loc4_.isFurnitureInMyInventory(683) == false)
            {
               _loc4_.sendBuyFurniture(683,false);
               this.game.wonNormalCannon = true;
            }
         }
      }
      if(this.game.targetRewardN == 7)
      {
         this.game.achievementUnlocked("buildCannon3");
         if(this.game.wonEpicCannon == false)
         {
            _loc4_ = _global.getCurrentShell();
            if(_loc4_.isFurnitureInMyInventory(684) == false)
            {
               _loc4_.sendBuyFurniture(684,false);
               this.game.wonEpicCannon = true;
            }
         }
      }
      if(this.game.targetRewardN == 8)
      {
         this.game.achievementUnlocked("timeTrial1");
      }
      if(this.game.targetRewardN == 9)
      {
         this.game.achievementUnlocked("timeTrial2");
      }
      if(this.game.targetRewardN == 10)
      {
         this.game.achievementUnlocked("timeTrial3");
      }
      if(this.game.targetRewardN == 11)
      {
         this.game.achievementUnlocked("turbo3");
      }
   }
   function popupPhase1()
   {
      this.movie.art.popup.art.art.statbar1.gotoAndStop("show");
      this.movie.art.popup.art.art.statbar1.art.art.gotoAndStop("currentPuffleOs");
      this.movie.art.popup.art.art.statbar1.art.art.tallyN = this.game.puffleOsFoundDisplay;
      if(this.game.puffleOsFoundDisplay < this.game.puffleOsFound)
      {
         if(this.movie.art.popup.art.art.statbar1.art.ready == true)
         {
            this.game.puffleOsFoundDisplay = this.game.puffleOsFoundDisplay + 1;
            this.movie.art.popup.art.art.statbar1.art.art.tallyN = this.game.puffleOsFoundDisplay;
            this.movie.art.popup.art.art.progressbar.gotoAndStop(Math.floor(this.game.puffleOsFoundDisplay / this.game.puffleOsAround * 100));
            if(this.game.area1LevelsMastered == true && this.game.area2LevelsMastered == true && this.game.area3LevelsMastered == true)
            {
               this.nextPhase = 2;
            }
            else
            {
               this.nextPhase = 3;
            }
         }
      }
      else
      {
         if(this.game.improved == true)
         {
            this.movie.art.popup.art.art.statbar1.art.art.recordtxt.gotoAndStop("show");
         }
         this.popupPaused = false;
      }
   }
   function popupPhase2()
   {
      this.movie.art.popup.art.art.statbar2.gotoAndStop("show");
      this.movie.art.popup.art.art.statbar2.art.art.gotoAndStop("currentTime");
      this.game.timeEarnedDisplay = this.game.currentTimeDisplay;
      this.minuteN = Math.floor(this.game.timeEarnedDisplay / 60);
      this.secondN = this.game.timeEarnedDisplay - this.minuteN * 60;
      if(this.secondN < 10)
      {
         this.game.timeEarnedDisplay = this.minuteN + " :0" + this.secondN;
      }
      else
      {
         this.game.timeEarnedDisplay = this.minuteN + " : " + this.secondN;
      }
      this.movie.art.popup.art.art.statbar2.art.art.tallyN = this.game.timeEarnedDisplay;
      if(this.game.improvedTime == true)
      {
         this.movie.art.popup.art.art.statbar2.art.art.recordtxt.gotoAndStop("show");
      }
      this.popupPaused = false;
   }
   function popupPhase3()
   {
      if(this.gamePlayerPuffleOs >= this.game["reward" + this.game.targetRewardN + "Required"] && this.game.targetRewardN < 7)
      {
         this.movie.art.popup.art.art.statbar1.gotoAndStop("hide");
         this.movie.art.popup.art.art.statbar2.gotoAndStop("hide");
         this.movie.art.popup.art.art.reward.gotoAndStop(this.game.targetRewardN + 1);
      }
      else
      {
         this.nextPhaseWait = 0;
      }
      this.popupPaused = false;
   }
   function popupPhase4()
   {
      this.targetXpos = this.hud.menus.art["level" + this.game.levelNum]._x + 40;
      this.targetYpos = this.hud.menus.art["level" + this.game.levelNum]._y + 40;
      this.targetDistance = com.clubpenguin.math.AaronsPhysics.findDistance(this.movie.art.popup._x,this.movie.art.popup._y,this.targetXpos,this.targetYpos);
      var _loc2_ = com.clubpenguin.math.AaronsPhysics.findAngle(this.movie.art.popup._x,this.movie.art.popup._y,this.targetXpos,this.targetYpos);
      var _loc3_ = com.clubpenguin.math.AaronsPhysics.findMotionXFromAngle(_loc2_,this.targetDistance / 20);
      var _loc4_ = com.clubpenguin.math.AaronsPhysics.findMotionYFromAngle(_loc2_,this.targetDistance / 20);
      this.motionX += _loc3_;
      this.motionY += _loc4_;
      this.motionXscale -= 1;
      this.motionX *= 0.9;
      this.motionY *= 0.9;
      this.motionXscale *= 0.9;
      this.movie.art.popup._x += this.motionX;
      this.movie.art.popup._y += this.motionY;
      this.movie.art.popup._xscale += this.motionXscale;
      if(this.movie.art.popup._xscale < 10)
      {
         this.movie.art.popup._xscale = 10;
      }
      this.movie.art.popup._yscale = this.movie.art.popup._xscale;
      if(this.movie.art.popup._xscale < 20 && this.targetDistance < 30)
      {
         this.movie.art.levelSplosion.gotoAndStop("show");
         this.movie.art.levelSplosion._x = this.targetXpos - 40;
         this.movie.art.levelSplosion._y = this.targetYpos - 40;
         this.popupPaused = false;
         this.nextPhaseWait = 0;
      }
   }
   function popupPhase5()
   {
      this.popupDone = true;
      this.popupNeeded = false;
      this.finishSetup();
   }
   function finishSetup()
   {
      this.popupDone = true;
      this.movie.art.popup.gotoAndStop("hide");
      this.movie.art.fadebox.gotoAndStop("hide");
      this.selectingEnabled = true;
      this.movie.art["level" + this.game.levelNum].highlite.gotoAndStop("show");
      if(this.game.targetRewardN < 7)
      {
         if(this.gamePlayerPuffleOs >= this.game["reward" + this.game.targetRewardN + "Required"])
         {
            this.game.targetRewardN = this.game.targetRewardN + 1;
         }
      }
      else if(this.game.targetRewardN < 10)
      {
         if(this.gameBestTimeN <= this.game["reward" + this.game.targetRewardN + "Required"])
         {
            this.game.targetRewardN = this.game.targetRewardN + 1;
         }
      }
      else if(this.game.targetRewardN == 10)
      {
         if(this.game.totalTurbosDone >= this.game["reward" + this.game.targetRewardN + "Required"])
         {
            this.game.targetRewardN = this.game.targetRewardN + 1;
            this.switchTurbo(false);
         }
      }
      this.updateRewardProgressBar();
      this.updateRewardIcon();
      if(this.selectingEnabled == true)
      {
         if(this.rewardPopupOpen == false)
         {
            if(this.game.QAMode == true)
            {
               var _loc2_ = 1;
               while(_loc2_ <= this.existingLevels)
               {
                  this.currButton = this.movie.art["level" + _loc2_];
                  this.currButton.onPress = com.clubpenguin.util.Delegate.create(this,this["selectLevel" + _loc2_]);
                  this.currButton.onRollOver = com.clubpenguin.util.Delegate.create(this,this["hoverLevel" + _loc2_]);
                  this.currButton.onRollOut = com.clubpenguin.util.Delegate.create(this,this["outLevel" + _loc2_]);
                  _loc2_ += 1;
               }
            }
            else
            {
               _loc2_ = 1;
               while(_loc2_ <= this.availableLevels)
               {
                  this.currButton = this.movie.art["level" + _loc2_];
                  this.currButton.onPress = com.clubpenguin.util.Delegate.create(this,this["selectLevel" + _loc2_]);
                  this.currButton.onRollOver = com.clubpenguin.util.Delegate.create(this,this["hoverLevel" + _loc2_]);
                  this.currButton.onRollOut = com.clubpenguin.util.Delegate.create(this,this["outLevel" + _loc2_]);
                  _loc2_ += 1;
               }
            }
         }
      }
   }
   function selectLevel($num)
   {
      if(this.selectingEnabled == true)
      {
         if(this.rewardPopupOpen == false)
         {
            var _loc3_ = undefined;
            _loc3_ = $num;
            if(this.availableLevels >= _loc3_ || this.game.QAMode == true)
            {
               var _loc2_ = 1;
               while(_loc2_ <= 30)
               {
                  this.movie.art["level" + _loc2_].highlite.gotoAndStop("hide");
                  _loc2_ += 1;
               }
               this.hud.menus.art["level" + this.game.levelNum].highlite.gotoAndStop("hide");
               this.game.levelNum = _loc3_;
               this.hud.menus.art["level" + this.game.levelNum].highlite.gotoAndStop("show");
               if(Key.isDown(32))
               {
                  if(this.game.QAMode == true)
                  {
                     this.game.gameMode = "levelEditor";
                  }
                  else
                  {
                     this.game.gameMode = "standardGameplay";
                  }
               }
               else
               {
                  this.game.gameMode = "standardGameplay";
               }
               this.game.gotoAndStop("gameplay");
            }
         }
      }
   }
   function hoverLevel($num)
   {
      if(this.selectingEnabled == true)
      {
         if(this.rewardPopupOpen == false)
         {
            var _loc2_ = undefined;
            _loc2_ = $num;
            this.hud.menus.art["level" + _loc2_].box.gotoAndStop("area" + this.game.areaNum);
            this.hud.menus.art["level" + _loc2_].box.gotoAndStop("area" + this.game.areaNum + "hover");
         }
      }
   }
   function outLevel($num)
   {
      if(this.selectingEnabled == true)
      {
         if(this.rewardPopupOpen == false)
         {
            var _loc2_ = undefined;
            _loc2_ = $num;
            this.hud.menus.art["level" + _loc2_].box.gotoAndStop("area" + this.game.areaNum);
         }
      }
   }
   function updateRewardProgressBar()
   {
      if(this.game.targetRewardN < 7)
      {
         var _loc2_ = this.game["reward" + (this.game.targetRewardN - 1) + "Required"];
         var _loc4_ = this.game["reward" + this.game.targetRewardN + "Required"];
         var _loc3_ = this.gamePlayerPuffleOs;
         var _loc6_ = _loc3_ - _loc2_;
         var _loc5_ = _loc4_ - _loc2_;
         var _loc7_ = Math.floor(_loc6_ / _loc5_ * 100) + 1;
         this.movie.art.rewardProgressBar.fillbars.gotoAndStop("puffleO");
         this.movie.art.rewardProgressBar.smallicon.gotoAndStop("puffleO");
      }
      else if(this.game.targetRewardN >= 10)
      {
         _loc2_ = 0;
         _loc4_ = this.game["reward" + this.game.targetRewardN + "Required"];
         _loc3_ = this.game.totalTurbosDone;
         if(this.game.targetRewardN == 11)
         {
            _loc3_ = 100;
            _loc4_ = 100;
         }
         _loc6_ = _loc3_ - _loc2_;
         _loc5_ = _loc4_ - _loc2_;
         _loc7_ = Math.floor(_loc6_ / _loc5_ * 100) + 1;
         this.movie.art.rewardProgressBar.fillbars.gotoAndStop("turbo");
         this.movie.art.rewardProgressBar.smallicon.gotoAndStop("turbo");
         if(this.game.targetRewardN == 11)
         {
            this.movie.art.rewardProgressBar.smallicon.gotoAndStop("hide");
         }
      }
      else if(this.game.targetRewardN >= 7)
      {
         _loc2_ = this.game["reward" + (this.game.targetRewardN - 1) + "Required"];
         _loc4_ = this.game["reward" + this.game.targetRewardN + "Required"];
         _loc3_ = this.gameBestTimeN;
         if(this.game.targetRewardN == 7)
         {
            _loc2_ = 21000;
         }
         if(_loc3_ > _loc2_)
         {
            _loc3_ = _loc2_;
         }
         _loc6_ = _loc3_ - _loc2_;
         _loc5_ = _loc4_ - _loc2_;
         _loc7_ = Math.floor(_loc6_ / _loc5_ * 100) + 1;
         this.movie.art.rewardProgressBar.fillbars.gotoAndStop("time");
         this.movie.art.rewardProgressBar.smallicon.gotoAndStop("time");
      }
      this.movie.art.rewardProgressBar.fillbars.fillbar.gotoAndStop(_loc7_);
   }
   function updateRewardIcon()
   {
      this.movie.art.rewardProgressBar.icons.gotoAndStop("small");
      this.movie.art.rewardProgressBar.icons.art.gotoAndStop(this.game.targetRewardN);
      com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.art.gamecompletetxt,"txt_gamecomplete");
   }
   function switchTurbo($on)
   {
      this.game.turboMode = $on;
      this.updateTurboArt($on);
   }
   function updateTurboArt($on)
   {
      if($on == true)
      {
         this.movie.art.rewardProgressBar.icons.blueprint.art.gotoAndStop("on");
         com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.art.turbotxt,"txt_turbo");
         com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.art.ontxt,"txt_on");
      }
      else
      {
         this.movie.art.rewardProgressBar.icons.blueprint.art.gotoAndStop("off");
         com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.art.turbotxt,"txt_turbo");
         com.clubpenguin.util.LocaleText.localizeField(this.movie.art.rewardProgressBar.icons.blueprint.art.offtxt,"txt_off");
      }
   }
   function selectLevel1()
   {
      this.selectLevel(1);
   }
   function hoverLevel1()
   {
      this.hoverLevel(1);
   }
   function outLevel1()
   {
      this.outLevel(1);
   }
   function selectLevel2()
   {
      this.selectLevel(2);
   }
   function hoverLevel2()
   {
      this.hoverLevel(2);
   }
   function outLevel2()
   {
      this.outLevel(2);
   }
   function selectLevel3()
   {
      this.selectLevel(3);
   }
   function hoverLevel3()
   {
      this.hoverLevel(3);
   }
   function outLevel3()
   {
      this.outLevel(3);
   }
   function selectLevel4()
   {
      this.selectLevel(4);
   }
   function hoverLevel4()
   {
      this.hoverLevel(4);
   }
   function outLevel4()
   {
      this.outLevel(4);
   }
   function selectLevel5()
   {
      this.selectLevel(5);
   }
   function hoverLevel5()
   {
      this.hoverLevel(5);
   }
   function outLevel5()
   {
      this.outLevel(5);
   }
   function selectLevel6()
   {
      this.selectLevel(6);
   }
   function hoverLevel6()
   {
      this.hoverLevel(6);
   }
   function outLevel6()
   {
      this.outLevel(6);
   }
   function selectLevel7()
   {
      this.selectLevel(7);
   }
   function hoverLevel7()
   {
      this.hoverLevel(7);
   }
   function outLevel7()
   {
      this.outLevel(7);
   }
   function selectLevel8()
   {
      this.selectLevel(8);
   }
   function hoverLevel8()
   {
      this.hoverLevel(8);
   }
   function outLevel8()
   {
      this.outLevel(8);
   }
   function selectLevel9()
   {
      this.selectLevel(9);
   }
   function hoverLevel9()
   {
      this.hoverLevel(9);
   }
   function outLevel9()
   {
      this.outLevel(9);
   }
   function selectLevel10()
   {
      this.selectLevel(10);
   }
   function hoverLevel10()
   {
      this.hoverLevel(10);
   }
   function outLevel10()
   {
      this.outLevel(10);
   }
   function selectLevel11()
   {
      this.selectLevel(11);
   }
   function hoverLevel11()
   {
      this.hoverLevel(11);
   }
   function outLevel11()
   {
      this.outLevel(11);
   }
   function selectLevel12()
   {
      this.selectLevel(12);
   }
   function hoverLevel12()
   {
      this.hoverLevel(12);
   }
   function outLevel12()
   {
      this.outLevel(12);
   }
   function selectLevel13()
   {
      this.selectLevel(13);
   }
   function hoverLevel13()
   {
      this.hoverLevel(13);
   }
   function outLevel13()
   {
      this.outLevel(13);
   }
   function selectLevel14()
   {
      this.selectLevel(14);
   }
   function hoverLevel14()
   {
      this.hoverLevel(14);
   }
   function outLevel14()
   {
      this.outLevel(14);
   }
   function selectLevel15()
   {
      this.selectLevel(15);
   }
   function hoverLevel15()
   {
      this.hoverLevel(15);
   }
   function outLevel15()
   {
      this.outLevel(15);
   }
   function selectLevel16()
   {
      this.selectLevel(16);
   }
   function hoverLevel16()
   {
      this.hoverLevel(16);
   }
   function outLevel16()
   {
      this.outLevel(16);
   }
   function selectLevel17()
   {
      this.selectLevel(17);
   }
   function hoverLevel17()
   {
      this.hoverLevel(17);
   }
   function outLevel17()
   {
      this.outLevel(17);
   }
   function selectLevel18()
   {
      this.selectLevel(18);
   }
   function hoverLevel18()
   {
      this.hoverLevel(18);
   }
   function outLevel18()
   {
      this.outLevel(18);
   }
   function selectLevel19()
   {
      this.selectLevel(19);
   }
   function hoverLevel19()
   {
      this.hoverLevel(19);
   }
   function outLevel19()
   {
      this.outLevel(19);
   }
   function selectLevel20()
   {
      this.selectLevel(20);
   }
   function hoverLevel20()
   {
      this.hoverLevel(20);
   }
   function outLevel20()
   {
      this.outLevel(20);
   }
   function selectLevel21()
   {
      this.selectLevel(21);
   }
   function hoverLevel21()
   {
      this.hoverLevel(21);
   }
   function outLevel21()
   {
      this.outLevel(21);
   }
   function selectLevel22()
   {
      this.selectLevel(22);
   }
   function hoverLevel22()
   {
      this.hoverLevel(22);
   }
   function outLevel22()
   {
      this.outLevel(22);
   }
   function selectLevel23()
   {
      this.selectLevel(23);
   }
   function hoverLevel23()
   {
      this.hoverLevel(23);
   }
   function outLevel23()
   {
      this.outLevel(23);
   }
   function selectLevel24()
   {
      this.selectLevel(24);
   }
   function hoverLevel24()
   {
      this.hoverLevel(24);
   }
   function outLevel24()
   {
      this.outLevel(24);
   }
   function selectLevel25()
   {
      this.selectLevel(25);
   }
   function hoverLevel25()
   {
      this.hoverLevel(25);
   }
   function outLevel25()
   {
      this.outLevel(25);
   }
   function selectLevel26()
   {
      this.selectLevel(26);
   }
   function hoverLevel26()
   {
      this.hoverLevel(26);
   }
   function outLevel26()
   {
      this.outLevel(26);
   }
   function selectLevel27()
   {
      this.selectLevel(27);
   }
   function hoverLevel27()
   {
      this.hoverLevel(27);
   }
   function outLevel27()
   {
      this.outLevel(27);
   }
   function selectLevel28()
   {
      this.selectLevel(28);
   }
   function hoverLevel28()
   {
      this.hoverLevel(28);
   }
   function outLevel28()
   {
      this.outLevel(28);
   }
   function selectLevel29()
   {
      this.selectLevel(29);
   }
   function hoverLevel29()
   {
      this.hoverLevel(29);
   }
   function outLevel29()
   {
      this.outLevel(29);
   }
   function selectLevel30()
   {
      this.selectLevel(30);
   }
   function hoverLevel30()
   {
      this.hoverLevel(30);
   }
   function outLevel30()
   {
      this.outLevel(30);
   }
   function selectLevel31()
   {
      this.selectLevel(31);
   }
   function hoverLevel31()
   {
      this.hoverLevel(31);
   }
   function outLevel31()
   {
      this.outLevel(31);
   }
   function selectLevel32()
   {
      this.selectLevel(32);
   }
   function hoverLevel32()
   {
      this.hoverLevel(32);
   }
   function outLevel32()
   {
      this.outLevel(32);
   }
   function selectLevel33()
   {
      this.selectLevel(33);
   }
   function hoverLevel33()
   {
      this.hoverLevel(33);
   }
   function outLevel33()
   {
      this.outLevel(33);
   }
   function selectLevel34()
   {
      this.selectLevel(34);
   }
   function hoverLevel34()
   {
      this.hoverLevel(34);
   }
   function outLevel34()
   {
      this.outLevel(34);
   }
   function selectLevel35()
   {
      this.selectLevel(35);
   }
   function hoverLevel35()
   {
      this.hoverLevel(35);
   }
   function outLevel35()
   {
      this.outLevel(35);
   }
   function selectLevel36()
   {
      this.selectLevel(36);
   }
   function hoverLevel36()
   {
      this.hoverLevel(36);
   }
   function outLevel36()
   {
      this.outLevel(36);
   }
   function toString()
   {
      return "I am a Menu class instance";
   }
}
