//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.Menus
    {
        var game, hud, movie, screenType, motionX, motionY, motionXscale, motionYscale, targetDistance, rewardBarIconOver, rewardPopupOpen, popupShowing, popupDone, popupPhaseN, popupPaused, nextPhase, nextPhaseWait, existingLevels, gamePlayerPuffleOs, gameTotalPuffleOs, gameBestTimeN, availableLevels, playerPuffleOs, totalPuffleOs, timeN, minuteN, secondN, popupNeeded, selectingEnabled, currButton, targetXpos, targetYpos;
        function Menus (_arg_4, _arg_2, _arg_3, _arg_5) {
            trace("Creating a menu0");
            game = _arg_4;
            hud = _arg_2;
            movie = _arg_3;
            movie._x = 0;
            movie._y = 0;
            screenType = _arg_5;
            movie.gotoAndStop(screenType);
            movie.art.game = game;
            motionX = 0;
            motionY = 0;
            motionXscale = 0;
            motionYscale = 0;
            targetDistance = 100;
            rewardBarIconOver = false;
            rewardPopupOpen = false;
        }
        function setup(_arg_6, _arg_10) {
            game.inGameplay = false;
            if ((_arg_6 == 2) || (_arg_6 == 3)) {
                var _local_7 = false;
                var _local_8 = _global.getCurrentShell();
                var _local_9 = _global.getCurrentInterface();
                if (_local_8.isMyPlayerMember != undefined) {
                    _local_7 = _local_8.isMyPlayerMember();
                    if (!_local_7) {
                        _local_9.showContent("oops_game_puffle_launch");
                        _arg_6 = 1;
                    }
                }
            }
            popupShowing = false;
            popupDone = false;
            popupPhaseN = 0;
            popupPaused = false;
            nextPhase = 0;
            nextPhaseWait = 48;
            movie.art.gotoAndStop(_arg_6);
            game.areaNum = _arg_6;
            existingLevels = game.existingLevels;
            var _local_3 = 1;
            while (_local_3 <= existingLevels) {
                movie.art["level" + _local_3].box.gotoAndStop("area" + _arg_6);
                _local_3++;
            }
            gamePlayerPuffleOs = 0;
            gameTotalPuffleOs = 0;
            gameBestTimeN = 0;
            availableLevels = game.availableLevels;
            _local_3 = 1;
            while (_local_3 <= availableLevels) {
                movie.art["level" + _local_3].box.lock.gotoAndStop("circle");
                movie.art["level" + _local_3].stats.gotoAndStop("show");
                movie.art["level" + _local_3].stats.levelNum = _local_3;
                movie.art["level" + _local_3].stats.icons.gotoAndStop("scores");
                playerPuffleOs = game[("level" + _local_3) + "playerPuffleOs"];
                totalPuffleOs = game[("level" + _local_3) + "totalPuffleOs"];
                gamePlayerPuffleOs = gamePlayerPuffleOs + playerPuffleOs;
                gameTotalPuffleOs = gameTotalPuffleOs + totalPuffleOs;
                game.gamePlayerPuffleOs = gamePlayerPuffleOs;
                if (playerPuffleOs == 0) {
                    movie.art["level" + _local_3].stats.ratingScore = " ";
                    var _local_4 = true;
                } else {
                    movie.art["level" + _local_3].stats.ratingScore = (playerPuffleOs + " / ") + totalPuffleOs;
                }
                movie.art["level" + _local_3].puffleo.gotoAndStop(game[("level" + _local_3) + "ranking"]);
                if (((((game[("level" + _local_3) + "bestTime"] * 0) == 0) && (game.area1LevelsMastered == true)) && (game.area2LevelsMastered == true)) && (game.area3LevelsMastered == true)) {
                    timeN = game[("level" + _local_3) + "bestTime"];
                    gameBestTimeN = gameBestTimeN + timeN;
                    minuteN = Math.floor(timeN / 60);
                    secondN = timeN - (minuteN * 60);
                    if (secondN < 10) {
                        movie.art["level" + _local_3].stats.bestTime = (minuteN + " :0") + secondN;
                    } else {
                        movie.art["level" + _local_3].stats.bestTime = (minuteN + " : ") + secondN;
                    }
                } else {
                    movie.art["level" + _local_3].stats.bestTime = " ";
                    var _local_5 = true;
                    movie.art["level" + _local_3].stats.icons.clock.gotoAndStop("hide");
                }
                if ((_local_5 == true) && (_local_4 == true)) {
                    movie.art["level" + _local_3].stats.icons.gotoAndStop("new");
                }
                _local_3++;
            }
            if (gameBestTimeN > 0) {
                minuteN = Math.floor(gameBestTimeN / 60);
                secondN = gameBestTimeN - (minuteN * 60);
                if (secondN < 10) {
                    movie.art.gameBestTime = (minuteN + ":0") + secondN;
                } else {
                    movie.art.gameBestTime = (minuteN + ":") + secondN;
                }
            } else {
                movie.art.gameBestTime = " ";
            }
            updateRewardProgressBar();
            updateRewardIcon();
            updateTurboArt(game.turboMode);
            if (_arg_10 == true) {
                popupNeeded = true;
                popupPhaseN = 0;
                selectingEnabled = false;
                movie.art.popup.gotoAndStop("show");
                movie.art.fadebox.gotoAndStop("show");
                game.levelJustCompleted = false;
                if (game.gameMode == "standardGameplay") {
                    if (game.anyImprovement == true) {
                        if (game.saveDataOn == true) {
                            var _local_7 = false;
                            var _local_8 = _global.getCurrentShell();
                            if (_local_8.isMyPlayerMember != undefined) {
                                _local_7 = _local_8.isMyPlayerMember();
                                if (_local_7) {
                                    trace("[Menus] game.savePlayerData");
                                    game.savePlayerData();
                                }
                            }
                        }
                    }
                }
            } else if (_arg_10 == false) {
                popupNeeded = false;
                popupDone = true;
                finishSetup();
            }
        }
        function update() {
            if (popupNeeded == true) {
                if (popupDone == false) {
                    if (popupPaused == false) {
                        if (nextPhaseWait > 0) {
                            nextPhaseWait--;
                        } else {
                            nextPhaseWait = 48;
                            popupPaused = true;
                            if (nextPhase == 0) {
                                popupPhaseN++;
                            } else {
                                popupPhaseN = nextPhase;
                                nextPhase = 0;
                            }
                        }
                    } else {
                        this["popupPhase" + popupPhaseN]();
                    }
                }
            }
            if ((rewardPopupOpen == true) || (selectingEnabled == false)) {
                var _local_3 = 1;
                while (_local_3 <= availableLevels) {
                    currButton = movie.art["level" + _local_3];
                    currButton.useHandCursor = false;
                    _local_3++;
                }
                movie.art.areabtns.gotoAndStop("hide");
            } else {
                var _local_3 = 1;
                while (_local_3 <= availableLevels) {
                    currButton = movie.art["level" + _local_3];
                    currButton.useHandCursor = true;
                    _local_3++;
                }
                movie.art.areabtns.gotoAndStop("show");
            }
            if (rewardBarIconOver == true) {
                if (selectingEnabled == true) {
                    movie.art.rewardProgressBar.icons.gotoAndStop("big");
                    movie.art.rewardProgressBar.icons.blueprint.gotoAndStop(game.targetRewardN);
                    rewardPopupOpen = true;
                    if (game.targetRewardN >= 11) {
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.slomotxt, "txt_slomo");
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.art.gamecompletetxt, "txt_gamecomplete");
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.besttimetxt, "txt_besttime");
                    } else if (game.targetRewardN >= 10) {
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.dareturbotxt, "txt_dareturbo");
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.besttimetxt, "txt_besttime");
                    } else if (game.targetRewardN >= 7) {
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.timetrialtxt, "txt_timetrial");
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.theclocktxt, "txt_theclock");
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.besttimetxt, "txt_besttime");
                        if (game.targetRewardN == 7) {
                            com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.time1txt, "txt_time1");
                        } else if (game.targetRewardN == 8) {
                            com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.time2txt, "txt_time2");
                        } else if (game.targetRewardN == 9) {
                            com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.time3txt, "txt_time3");
                        }
                    } else if (game.targetRewardN >= 4) {
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.buildcannonepictxt, "txt_buildcannonepic");
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.nextparttxt, "txt_nextpart");
                    } else {
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.buildcannontxt, "txt_buildcannon");
                        com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.nextparttxt, "txt_nextpart");
                    }
                    if (game.targetRewardN >= 10) {
                        updateTurboArt(game.turboMode);
                    }
                }
            } else if (rewardPopupOpen == true) {
                var _local_4 = true;
                if (game._ymouse < 140) {
                    _local_4 = false;
                }
                if (game._ymouse < 180) {
                    if ((game._xmouse < 320) || (game._xmouse > 450)) {
                        _local_4 = false;
                    }
                }
                if ((game._xmouse < 200) || (game._xmouse > 580)) {
                    _local_4 = false;
                }
                if (_local_4 == false) {
                    movie.art.rewardProgressBar.icons.gotoAndStop("small");
                    rewardPopupOpen = false;
                    updateRewardIcon();
                }
            }
            if (game.targetRewardN == 2) {
                game.achievementUnlocked("buildCannon1");
            }
            if (game.targetRewardN == 4) {
                game.achievementUnlocked("buildCannon2");
                if (game.wonNormalCannon == false) {
                    var _local_5 = _global.getCurrentShell();
                    if (_local_5.isFurnitureInMyInventory(683) == false) {
                        _local_5.sendBuyFurniture(683, false);
                        game.wonNormalCannon = true;
                    }
                }
            }
            if (game.targetRewardN == 7) {
                game.achievementUnlocked("buildCannon3");
                if (game.wonEpicCannon == false) {
                    var _local_5 = _global.getCurrentShell();
                    if (_local_5.isFurnitureInMyInventory(684) == false) {
                        _local_5.sendBuyFurniture(684, false);
                        game.wonEpicCannon = true;
                    }
                }
            }
            if (game.targetRewardN == 8) {
                game.achievementUnlocked("timeTrial1");
            }
            if (game.targetRewardN == 9) {
                game.achievementUnlocked("timeTrial2");
            }
            if (game.targetRewardN == 10) {
                game.achievementUnlocked("timeTrial3");
            }
            if (game.targetRewardN == 11) {
                game.achievementUnlocked("turbo3");
            }
        }
        function popupPhase1() {
            movie.art.popup.art.art.statbar1.gotoAndStop("show");
            movie.art.popup.art.art.statbar1.art.art.gotoAndStop("currentPuffleOs");
            movie.art.popup.art.art.statbar1.art.art.tallyN = game.puffleOsFoundDisplay;
            if (game.puffleOsFoundDisplay < game.puffleOsFound) {
                if (movie.art.popup.art.art.statbar1.art.ready == true) {
                    game.puffleOsFoundDisplay++;
                    movie.art.popup.art.art.statbar1.art.art.tallyN = game.puffleOsFoundDisplay;
                    movie.art.popup.art.art.progressbar.gotoAndStop(Math.floor((game.puffleOsFoundDisplay / game.puffleOsAround) * 100));
                    if (((game.area1LevelsMastered == true) && (game.area2LevelsMastered == true)) && (game.area3LevelsMastered == true)) {
                        nextPhase = 2;
                    } else {
                        nextPhase = 3;
                    }
                }
            } else {
                if (game.improved == true) {
                    movie.art.popup.art.art.statbar1.art.art.recordtxt.gotoAndStop("show");
                }
                popupPaused = false;
            }
        }
        function popupPhase2() {
            movie.art.popup.art.art.statbar2.gotoAndStop("show");
            movie.art.popup.art.art.statbar2.art.art.gotoAndStop("currentTime");
            game.timeEarnedDisplay = game.currentTimeDisplay;
            minuteN = Math.floor(game.timeEarnedDisplay / 60);
            secondN = game.timeEarnedDisplay - (minuteN * 60);
            if (secondN < 10) {
                game.timeEarnedDisplay = (minuteN + " :0") + secondN;
            } else {
                game.timeEarnedDisplay = (minuteN + " : ") + secondN;
            }
            movie.art.popup.art.art.statbar2.art.art.tallyN = game.timeEarnedDisplay;
            if (game.improvedTime == true) {
                movie.art.popup.art.art.statbar2.art.art.recordtxt.gotoAndStop("show");
            }
            popupPaused = false;
        }
        function popupPhase3() {
            if ((gamePlayerPuffleOs >= game[("reward" + game.targetRewardN) + "Required"]) && (game.targetRewardN < 7)) {
                movie.art.popup.art.art.statbar1.gotoAndStop("hide");
                movie.art.popup.art.art.statbar2.gotoAndStop("hide");
                movie.art.popup.art.art.reward.gotoAndStop(game.targetRewardN + 1);
            } else {
                nextPhaseWait = 0;
            }
            popupPaused = false;
        }
        function popupPhase4() {
            targetXpos = hud.menus.art["level" + game.levelNum]._x + 40;
            targetYpos = hud.menus.art["level" + game.levelNum]._y + 40;
            targetDistance = com.clubpenguin["math"].AaronsPhysics.findDistance(movie.art.popup._x, movie.art.popup._y, targetXpos, targetYpos);
            var _local_2 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie.art.popup._x, movie.art.popup._y, targetXpos, targetYpos);
            var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_2, targetDistance / 20);
            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_2, targetDistance / 20);
            motionX = motionX + _local_4;
            motionY = motionY + _local_3;
            motionXscale = motionXscale - 1;
            motionX = motionX * 0.9;
            motionY = motionY * 0.9;
            motionXscale = motionXscale * 0.9;
            movie.art.popup._x = movie.art.popup._x + motionX;
            movie.art.popup._y = movie.art.popup._y + motionY;
            movie.art.popup._xscale = movie.art.popup._xscale + motionXscale;
            if (movie.art.popup._xscale < 10) {
                movie.art.popup._xscale = 10;
            }
            movie.art.popup._yscale = movie.art.popup._xscale;
            if ((movie.art.popup._xscale < 20) && (targetDistance < 30)) {
                movie.art.levelSplosion.gotoAndStop("show");
                movie.art.levelSplosion._x = targetXpos - 40;
                movie.art.levelSplosion._y = targetYpos - 40;
                popupPaused = false;
                nextPhaseWait = 0;
            }
        }
        function popupPhase5() {
            popupDone = true;
            popupNeeded = false;
            finishSetup();
        }
        function finishSetup() {
            popupDone = true;
            movie.art.popup.gotoAndStop("hide");
            movie.art.fadebox.gotoAndStop("hide");
            selectingEnabled = true;
            movie.art["level" + game.levelNum].highlite.gotoAndStop("show");
            if (game.targetRewardN < 7) {
                if (gamePlayerPuffleOs >= game[("reward" + game.targetRewardN) + "Required"]) {
                    game.targetRewardN++;
                }
            } else if (game.targetRewardN < 10) {
                if (gameBestTimeN <= game[("reward" + game.targetRewardN) + "Required"]) {
                    game.targetRewardN++;
                }
            } else if (game.targetRewardN == 10) {
                if (game.totalTurbosDone >= game[("reward" + game.targetRewardN) + "Required"]) {
                    game.targetRewardN++;
                    switchTurbo(false);
                }
            }
            updateRewardProgressBar();
            updateRewardIcon();
            if (selectingEnabled == true) {
                if (rewardPopupOpen == false) {
                    if (game.QAMode == true) {
                        var _local_2 = 1;
                        while (_local_2 <= existingLevels) {
                            currButton = movie.art["level" + _local_2];
                            currButton.onPress = com.clubpenguin.util.Delegate.create(this, this["selectLevel" + _local_2]);
                            currButton.onRollOver = com.clubpenguin.util.Delegate.create(this, this["hoverLevel" + _local_2]);
                            currButton.onRollOut = com.clubpenguin.util.Delegate.create(this, this["outLevel" + _local_2]);
                            _local_2++;
                        }
                    } else {
                        var _local_2 = 1;
                        while (_local_2 <= availableLevels) {
                            currButton = movie.art["level" + _local_2];
                            currButton.onPress = com.clubpenguin.util.Delegate.create(this, this["selectLevel" + _local_2]);
                            currButton.onRollOver = com.clubpenguin.util.Delegate.create(this, this["hoverLevel" + _local_2]);
                            currButton.onRollOut = com.clubpenguin.util.Delegate.create(this, this["outLevel" + _local_2]);
                            _local_2++;
                        }
                    }
                }
            }
        }
        function selectLevel(_arg_4) {
            if (selectingEnabled == true) {
                if (rewardPopupOpen == false) {
                    var _local_3;
                    _local_3 = _arg_4;
                    if ((availableLevels >= _local_3) || (game.QAMode == true)) {
                        var _local_2 = 1;
                        while (_local_2 <= 30) {
                            movie.art["level" + _local_2].highlite.gotoAndStop("hide");
                            _local_2++;
                        }
                        hud.menus.art["level" + game.levelNum].highlite.gotoAndStop("hide");
                        game.levelNum = _local_3;
                        hud.menus.art["level" + game.levelNum].highlite.gotoAndStop("show");
                        if (Key.isDown(32)) {
                            if (game.QAMode == true) {
                                game.gameMode = "levelEditor";
                            } else {
                                game.gameMode = "standardGameplay";
                            }
                        } else {
                            game.gameMode = "standardGameplay";
                        }
                        game.gotoAndStop("gameplay");
                    }
                }
            }
        }
        function hoverLevel(_arg_3) {
            if (selectingEnabled == true) {
                if (rewardPopupOpen == false) {
                    var _local_2;
                    _local_2 = _arg_3;
                    hud.menus.art["level" + _local_2].box.gotoAndStop("area" + game.areaNum);
                    hud.menus.art["level" + _local_2].box.gotoAndStop(("area" + game.areaNum) + "hover");
                }
            }
        }
        function outLevel(_arg_3) {
            if (selectingEnabled == true) {
                if (rewardPopupOpen == false) {
                    var _local_2;
                    _local_2 = _arg_3;
                    hud.menus.art["level" + _local_2].box.gotoAndStop("area" + game.areaNum);
                }
            }
        }
        function updateRewardProgressBar() {
            if (game.targetRewardN < 7) {
                var _local_2 = game[("reward" + (game.targetRewardN - 1)) + "Required"];
                var _local_7 = game[("reward" + game.targetRewardN) + "Required"];
                var _local_3 = gamePlayerPuffleOs;
                var _local_6 = _local_3 - _local_2;
                var _local_5 = _local_7 - _local_2;
                var _local_4 = Math.floor((_local_6 / _local_5) * 100) + 1;
                movie.art.rewardProgressBar.fillbars.gotoAndStop("puffleO");
                movie.art.rewardProgressBar.smallicon.gotoAndStop("puffleO");
            } else if (game.targetRewardN >= 10) {
                var _local_2 = 0;
                var _local_7 = game[("reward" + game.targetRewardN) + "Required"];
                var _local_3 = game.totalTurbosDone;
                if (game.targetRewardN == 11) {
                    _local_3 = 100;
                    _local_7 = 100;
                }
                var _local_6 = _local_3 - _local_2;
                var _local_5 = _local_7 - _local_2;
                var _local_4 = Math.floor((_local_6 / _local_5) * 100) + 1;
                movie.art.rewardProgressBar.fillbars.gotoAndStop("turbo");
                movie.art.rewardProgressBar.smallicon.gotoAndStop("turbo");
                if (game.targetRewardN == 11) {
                    movie.art.rewardProgressBar.smallicon.gotoAndStop("hide");
                }
            } else if (game.targetRewardN >= 7) {
                var _local_2 = game[("reward" + (game.targetRewardN - 1)) + "Required"];
                var _local_7 = game[("reward" + game.targetRewardN) + "Required"];
                var _local_3 = gameBestTimeN;
                if (game.targetRewardN == 7) {
                    _local_2 = 21000;
                }
                if (_local_3 > _local_2) {
                    _local_3 = _local_2;
                }
                var _local_6 = _local_3 - _local_2;
                var _local_5 = _local_7 - _local_2;
                var _local_4 = Math.floor((_local_6 / _local_5) * 100) + 1;
                movie.art.rewardProgressBar.fillbars.gotoAndStop("time");
                movie.art.rewardProgressBar.smallicon.gotoAndStop("time");
            }
            movie.art.rewardProgressBar.fillbars.fillbar.gotoAndStop(_local_4);
        }
        function updateRewardIcon() {
            movie.art.rewardProgressBar.icons.gotoAndStop("small");
            movie.art.rewardProgressBar.icons.art.gotoAndStop(game.targetRewardN);
            com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.art.gamecompletetxt, "txt_gamecomplete");
        }
        function switchTurbo(_arg_2) {
            game.turboMode = _arg_2;
            updateTurboArt(_arg_2);
        }
        function updateTurboArt(_arg_2) {
            if (_arg_2 == true) {
                movie.art.rewardProgressBar.icons.blueprint.art.gotoAndStop("on");
                com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.art.turbotxt, "txt_turbo");
                com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.art.ontxt, "txt_on");
            } else {
                movie.art.rewardProgressBar.icons.blueprint.art.gotoAndStop("off");
                com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.art.turbotxt, "txt_turbo");
                com.clubpenguin.util.LocaleText.localizeField(movie.art.rewardProgressBar.icons.blueprint.art.offtxt, "txt_off");
            }
        }
        function selectLevel1() {
            selectLevel(1);
        }
        function hoverLevel1() {
            hoverLevel(1);
        }
        function outLevel1() {
            outLevel(1);
        }
        function selectLevel2() {
            selectLevel(2);
        }
        function hoverLevel2() {
            hoverLevel(2);
        }
        function outLevel2() {
            outLevel(2);
        }
        function selectLevel3() {
            selectLevel(3);
        }
        function hoverLevel3() {
            hoverLevel(3);
        }
        function outLevel3() {
            outLevel(3);
        }
        function selectLevel4() {
            selectLevel(4);
        }
        function hoverLevel4() {
            hoverLevel(4);
        }
        function outLevel4() {
            outLevel(4);
        }
        function selectLevel5() {
            selectLevel(5);
        }
        function hoverLevel5() {
            hoverLevel(5);
        }
        function outLevel5() {
            outLevel(5);
        }
        function selectLevel6() {
            selectLevel(6);
        }
        function hoverLevel6() {
            hoverLevel(6);
        }
        function outLevel6() {
            outLevel(6);
        }
        function selectLevel7() {
            selectLevel(7);
        }
        function hoverLevel7() {
            hoverLevel(7);
        }
        function outLevel7() {
            outLevel(7);
        }
        function selectLevel8() {
            selectLevel(8);
        }
        function hoverLevel8() {
            hoverLevel(8);
        }
        function outLevel8() {
            outLevel(8);
        }
        function selectLevel9() {
            selectLevel(9);
        }
        function hoverLevel9() {
            hoverLevel(9);
        }
        function outLevel9() {
            outLevel(9);
        }
        function selectLevel10() {
            selectLevel(10);
        }
        function hoverLevel10() {
            hoverLevel(10);
        }
        function outLevel10() {
            outLevel(10);
        }
        function selectLevel11() {
            selectLevel(11);
        }
        function hoverLevel11() {
            hoverLevel(11);
        }
        function outLevel11() {
            outLevel(11);
        }
        function selectLevel12() {
            selectLevel(12);
        }
        function hoverLevel12() {
            hoverLevel(12);
        }
        function outLevel12() {
            outLevel(12);
        }
        function selectLevel13() {
            selectLevel(13);
        }
        function hoverLevel13() {
            hoverLevel(13);
        }
        function outLevel13() {
            outLevel(13);
        }
        function selectLevel14() {
            selectLevel(14);
        }
        function hoverLevel14() {
            hoverLevel(14);
        }
        function outLevel14() {
            outLevel(14);
        }
        function selectLevel15() {
            selectLevel(15);
        }
        function hoverLevel15() {
            hoverLevel(15);
        }
        function outLevel15() {
            outLevel(15);
        }
        function selectLevel16() {
            selectLevel(16);
        }
        function hoverLevel16() {
            hoverLevel(16);
        }
        function outLevel16() {
            outLevel(16);
        }
        function selectLevel17() {
            selectLevel(17);
        }
        function hoverLevel17() {
            hoverLevel(17);
        }
        function outLevel17() {
            outLevel(17);
        }
        function selectLevel18() {
            selectLevel(18);
        }
        function hoverLevel18() {
            hoverLevel(18);
        }
        function outLevel18() {
            outLevel(18);
        }
        function selectLevel19() {
            selectLevel(19);
        }
        function hoverLevel19() {
            hoverLevel(19);
        }
        function outLevel19() {
            outLevel(19);
        }
        function selectLevel20() {
            selectLevel(20);
        }
        function hoverLevel20() {
            hoverLevel(20);
        }
        function outLevel20() {
            outLevel(20);
        }
        function selectLevel21() {
            selectLevel(21);
        }
        function hoverLevel21() {
            hoverLevel(21);
        }
        function outLevel21() {
            outLevel(21);
        }
        function selectLevel22() {
            selectLevel(22);
        }
        function hoverLevel22() {
            hoverLevel(22);
        }
        function outLevel22() {
            outLevel(22);
        }
        function selectLevel23() {
            selectLevel(23);
        }
        function hoverLevel23() {
            hoverLevel(23);
        }
        function outLevel23() {
            outLevel(23);
        }
        function selectLevel24() {
            selectLevel(24);
        }
        function hoverLevel24() {
            hoverLevel(24);
        }
        function outLevel24() {
            outLevel(24);
        }
        function selectLevel25() {
            selectLevel(25);
        }
        function hoverLevel25() {
            hoverLevel(25);
        }
        function outLevel25() {
            outLevel(25);
        }
        function selectLevel26() {
            selectLevel(26);
        }
        function hoverLevel26() {
            hoverLevel(26);
        }
        function outLevel26() {
            outLevel(26);
        }
        function selectLevel27() {
            selectLevel(27);
        }
        function hoverLevel27() {
            hoverLevel(27);
        }
        function outLevel27() {
            outLevel(27);
        }
        function selectLevel28() {
            selectLevel(28);
        }
        function hoverLevel28() {
            hoverLevel(28);
        }
        function outLevel28() {
            outLevel(28);
        }
        function selectLevel29() {
            selectLevel(29);
        }
        function hoverLevel29() {
            hoverLevel(29);
        }
        function outLevel29() {
            outLevel(29);
        }
        function selectLevel30() {
            selectLevel(30);
        }
        function hoverLevel30() {
            hoverLevel(30);
        }
        function outLevel30() {
            outLevel(30);
        }
        function selectLevel31() {
            selectLevel(31);
        }
        function hoverLevel31() {
            hoverLevel(31);
        }
        function outLevel31() {
            outLevel(31);
        }
        function selectLevel32() {
            selectLevel(32);
        }
        function hoverLevel32() {
            hoverLevel(32);
        }
        function outLevel32() {
            outLevel(32);
        }
        function selectLevel33() {
            selectLevel(33);
        }
        function hoverLevel33() {
            hoverLevel(33);
        }
        function outLevel33() {
            outLevel(33);
        }
        function selectLevel34() {
            selectLevel(34);
        }
        function hoverLevel34() {
            hoverLevel(34);
        }
        function outLevel34() {
            outLevel(34);
        }
        function selectLevel35() {
            selectLevel(35);
        }
        function hoverLevel35() {
            hoverLevel(35);
        }
        function outLevel35() {
            outLevel(35);
        }
        function selectLevel36() {
            selectLevel(36);
        }
        function hoverLevel36() {
            hoverLevel(36);
        }
        function outLevel36() {
            outLevel(36);
        }
        function toString() {
            return("I am a Menu class instance");
        }
    }
