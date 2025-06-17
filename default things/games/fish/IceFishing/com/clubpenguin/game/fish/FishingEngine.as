//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.game.fish.FishingEngine extends MovieClip
    {
        var oj, stop, createEmptyMovieClip, getNextHighestDepth, SHELL, grayFishMode, orangeFishTotal, grayFishTotal, listener, backgroundAudio, gotoAndStop, mySound, soundInstance, gameDirectory, localeDirectory, loader, start_screen, penguinColor, colorObject, oneup, fish2, gameOverEvent, isBigFishCaught, consecutiveFishCaught, hasLostLife, totalFishCaught, gameRunning, icepoint, hookEmpty, hookPrevPos, _ymouse, hookCurrPos, hookisFalling, lives, level, levelBlock, fishCaught, puffle, sharkActive, crabActive, kickerLeftMove, kickerRightMove, lineisCut, startTime, timer, speedTimer, speed, lineExtra, linesCutByCrab, objArray, fish1, fish3, fish4, fish5, fish6, fish7, fish8, jfish1, jfish2, finLeft, finRight, crab1, crab2, kickerLeft, kickerRight, grayfish1, grayfish2, grayfish3, grayfish4, iceboxArray, iceboxArrayPos, currentFish, greyFishCaught, jellyFishHitCount, sharkLeftMove, sharkRightMove, hook, millisecondsOfTime, clockTimer, minutesGiven, secondsOfTime, minutesOfTime, timeLeft, penguin, line, cutPoint, shark1, shark2, hookFall, groups, icebox, fishblockNum, fishNum, gft, oft, fish, fishflee, grayfishflee, sharkleftDistance, sharkLeft, sharkrightDistance, sharkRight, bigFish, nextFrame, lives_mc, oneupText, prompt, gameOver_mc;
        function FishingEngine () {
            super();
            if (!DEV_STANDALONE) {
            }
            oj = new com.disney.games.fish.OpcodeJournal();
        }
        function frame1() {
            init();
            this.stop();
            this.createEmptyMovieClip("soundInstance", getNextHighestDepth());
        }
        function init() {
            SHELL = _global.getCurrentShell();
            var _local_3 = SHELL.getMyPlayerId();
            if (_local_3 == undefined) {
                _local_3 = -1;
            }
            oj.init(_local_3);
            if (SHELL.isItemOnMyPlayer(321) || (DEV_GRAY_MODE)) {
                grayFishMode = true;
                oj.sendEventAction(oj.OPCODEGUID_USEFLASHINGLUREFISHINGROD);
            } else {
                grayFishMode = false;
            }
            orangeFishTotal = 0;
            grayFishTotal = 0;
            if (DEV_STANDALONE) {
                com.clubpenguin.util.Loader.setLocaleVersion(undefined);
                com.clubpenguin.util.Loader.setLocale(undefined);
                com.clubpenguin.util.Loader.loadAllMovies(this, []);
            }
            listener = new Object();
            listener.onLoadComplete = com.clubpenguin.util.Delegate.create(this, onLoadComplete);
            com.clubpenguin.util.Loader.addEventListener(listener);
            playbackgroundAudio();
        }
        function playbackgroundAudio() {
            var _local_2 = this.createEmptyMovieClip("bgSoundClip", getNextHighestDepth());
            var _local_3 = 45;
            backgroundAudio = new Sound(_local_2);
            backgroundAudio.attachSound("backgroundLoop");
            backgroundAudio.setVolume(_local_3);
            backgroundAudio.start(0, 99);
        }
        function onLoadComplete() {
            com.clubpenguin.util.Loader.removeEventListener(listener);
            this.gotoAndStop(2);
            listener.onLoadComplete = undefined;
        }
        function addSound(clip, volume) {
            if (volume == undefined) {
                volume = 100;
            }
            mySound = new Sound(soundInstance);
            mySound.setVolume(volume);
            mySound.attachSound(clip);
            mySound.start();
        }
        function frame2() {
            this.stop();
            gameDirectory = com.clubpenguin.util.LocaleText.getGameDirectory();
            localeDirectory = ("lang/" + com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.getLocaleID())) + "/";
            loader = new MovieClipLoader();
            loader.loadClip((gameDirectory + localeDirectory) + "title.swf", start_screen.logo_title);
            penguinColor = SHELL.getMyPlayerHex();
            colorObject = new Color(start_screen.penguin_color_screen.penguin_mc);
            colorObject.setRGB(penguinColor);
        }
        function frame33() {
            loader.loadClip((gameDirectory + localeDirectory) + "canoworms.swf", oneup.obj.canOWorms);
        }
        function frame36() {
            fish2.play();
        }
        function frame38() {
            this.stop();
            (gameOverEvent);// not popped
            isBigFishCaught = false;
            consecutiveFishCaught = 0;
            hasLostLife = false;
            totalFishCaught = 0;
            gameRunning = true;
            icepoint = 122;
            hookEmpty = true;
            hookPrevPos = _ymouse;
            hookCurrPos = _ymouse;
            hookisFalling = false;
            lives = 3;
            level = 1;
            levelBlock = false;
            fishCaught = 0;
            puffle._visible = false;
            oj.startGame();
            sharkActive = false;
            crabActive = false;
            kickerLeftMove = false;
            kickerRightMove = false;
            lineisCut = false;
            startTime = getTimer();
            timer = getTimer();
            speedTimer = getTimer();
            speed = 4000;
            if (grayFishMode == true) {
                lineExtra = 35;
            } else {
                lineExtra = 0;
            }
            linesCutByCrab = 0;
            objArray = new Array(fish1, fish2, fish3, fish4, fish5, fish6, fish7, fish8, oneup, jfish1, jfish2, finLeft, finRight, crab1, crab2, kickerLeft, kickerRight, grayfish1, grayfish2, grayfish3, grayfish4);
            iceboxArray = new Array(6, 8, 6, 16, 18);
            iceboxArrayPos = 0;
            currentFish = 0;
            greyFishCaught = 0;
            jellyFishHitCount = 0;
            sharkLeftMove = false;
            sharkRightMove = false;
            hook.isHit = false;
            hook.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updateHook);
            hook.onMouseDown = com.clubpenguin.util.Delegate.create(this, hookRelease);
        }
        function updateHook() {
            hookMove();
            if (hook._y > 120) {
                hazardHit();
            }
        }
        function hookRelease() {
            fishDrop();
            getWorm(0);
        }
        function endOfLevel(curLevel, numberOfFish, tip) {
            if (fishCaught == numberOfFish) {
                if (level == curLevel) {
                    puffle.play();
                    puffle._visible = true;
                    puffle.obj.levelTip.text = tip;
                    levelBlock = true;
                }
            }
        }
        function levelUp() {
            level++;
            speed = speed - 500;
            levelBlock = false;
            puffle._visible = false;
        }
        function gameSpeed() {
            speedTimer = getTimer();
            var _local_2;
            _local_2 = speedTimer - startTime;
            if ((speedTimer - timer) >= speed) {
                timer = speedTimer;
                groupChoose();
            }
            groupPlay();
        }
        function catchFish() {
            fishCaught++;
            speedTimer = getTimer();
            var _local_2;
            _local_2 = speedTimer - startTime;
            if ((_local_2 <= 300000) && (fishCaught == 63)) {
                com.clubpenguin.util.Stamp.sendStamp(STAMP_FLY_FISHER);
                oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS388_FLYFISHER);
            }
        }
        function countdown() {
            millisecondsOfTime = (minutesGiven * 60000) - (speedTimer - clockTimer);
            secondsOfTime = Math.floor(millisecondsOfTime / 1000) % 60;
            minutesOfTime = Math.floor(millisecondsOfTime / 60000);
            timeLeft.text = ((minutesOfTime + ":") + ((secondsOfTime < 10) ? "0" : "")) + secondsOfTime;
        }
        function distance(x1, y1, x2, y2) {
            var _local_2 = x2 - x1;
            var _local_1 = y2 - y1;
            return(Math.sqrt((_local_2 * _local_2) + (_local_1 * _local_1)));
        }
        function pengCtrl() {
            if (penguin._currentframe < 10) {
                if (hook.isHit == true) {
                    penguin.gotoAndStop(3);
                } else if (hook.isHit == false) {
                    if (_ymouse <= icepoint) {
                        penguin.gotoAndStop(1);
                    } else {
                        penguin.gotoAndStop(2);
                    }
                }
            }
            if (lives < 1) {
                penguin.wormCan.gotoAndStop(2);
            } else {
                penguin.wormCan.gotoAndStop(1);
            }
        }
        function hookMove() {
            if ((_ymouse >= (line._y + lineExtra)) && (_ymouse < 440)) {
                hook._y = _ymouse;
            } else if (_ymouse >= 440) {
                hook._y = 440;
            } else {
                hook._y = line._y + lineExtra;
            }
            if ((hookEmpty == true) && (hook.isHit == false)) {
                hookCurrPos = _ymouse;
                if (_ymouse <= icepoint) {
                    hook.gotoAndStop(2);
                } else {
                    if (hookCurrPos < hookPrevPos) {
                        hook.gotoAndStop(4);
                    } else if (hookCurrPos > hookPrevPos) {
                        hook.gotoAndStop(3);
                    } else {
                        hook.gotoAndStop(1);
                    }
                    hookPrevPos = _ymouse;
                }
            }
        }
        function lineScale() {
            if ((line._y < _ymouse) && (_ymouse < 440)) {
                if (lineisCut == false) {
                    line._yscale = _ymouse - line._y;
                } else if (lineisCut == true) {
                    if (_ymouse < (cutPoint + line._y)) {
                        line._yscale = _ymouse - line._y;
                    }
                }
            } else if ((_ymouse >= 440) && (!lineisCut)) {
                line._yscale = 440 - line._y;
            } else if ((line._y > _ymouse) && (!lineisCut)) {
                line._yscale = 0;
            }
        }
        function lineCut(collider) {
            if ((collider == crab1) || (collider == crab2)) {
                if (hook._currentframe == 5) {
                    fishFlees();
                }
                if (hook._currentframe == 7) {
                    grayfishFlees();
                }
            }
            if ((collider != shark1) && (collider != shark2)) {
                hookisFalling = true;
            }
            if (hookisFalling == true) {
                hookFall._x = hook._x;
                hookFall.mask._y = collider._y - _ymouse;
            }
            lineisCut = true;
            hook.isHit = true;
            hook._visible = false;
            hook.gotoAndStop("empty");
            line._yscale = collider._y - line._y;
            cutPoint = collider._y - line._y;
        }
        function lineMask() {
            if (lineisCut == false) {
                if (hookisFalling == false) {
                    hookFall._y = _ymouse;
                } else {
                    hookFall.gotoAndStop(1);
                    hookFall._x = 900;
                    hookisFalling = false;
                }
            }
            if (lineisCut == true) {
                if (hookFall._y < 800) {
                    hookFall.gotoAndStop(2);
                    hookFall._y = hookFall._y + 20;
                } else {
                    hookFall.gotoAndStop(1);
                    hookFall._x = 900;
                    hookisFalling = false;
                }
            }
        }
        function objChoose(stopwatch, item) {
            if (((speedTimer - timer) >= stopwatch) && ((speedTimer - timer) <= (stopwatch + 200))) {
                if ((item >= 0) && (item <= 7)) {
                    objArray[item].play();
                } else if ((item == 8) && (lives < 3)) {
                    objArray[item].play();
                } else if ((item == 9) || (item == 10)) {
                    objArray[item].play();
                } else if ((item == 11) || (item == 12)) {
                    if (!sharkActive) {
                        objArray[item].play();
                    }
                } else if ((item == 13) || (item == 14)) {
                    if (!crabActive) {
                        objArray[item].play();
                    }
                } else if (item == 15) {
                    if (!kickerLeftMove) {
                        kickerLeft.obj.gotoAndStop(Math.round((Math.random() * 1) + 1));
                        kickerLeft._y = (Math.random() * 200) + 235;
                        kickerLeftMove = true;
                    }
                } else if (item == 16) {
                    if (!kickerRightMove) {
                        kickerRight.obj.gotoAndStop(Math.round((Math.random() * 1) + 1));
                        kickerRight._y = (Math.random() * 200) + 235;
                        kickerRightMove = true;
                    }
                } else if ((item >= 17) && (item <= 20)) {
                    if ((fishCaught < 56) && grayFishMode) {
                        objArray[item].play();
                    }
                }
            }
        }
        function groupChoose() {
            if (level == 1) {
                groups = Math.floor((Math.random() * 10) + 1);
            } else if (level == 2) {
                groups = Math.floor((Math.random() * 20) + 1);
            } else if (level == 3) {
                groups = Math.floor((Math.random() * 30) + 1);
            } else if (level == 4) {
                groups = Math.floor((Math.random() * 30) + 11);
            }
        }
        function groupPlay() {
            if (groups == 0) {
                objChoose(100, 18);
                objChoose(800, 20);
                objChoose(1200, 5);
            } else if (groups == 1) {
                objChoose(100, 0);
                objChoose(400, 15);
                objChoose(800, 18);
                objChoose(1500, 6);
            } else if (groups == 2) {
                objChoose(300, 7);
                objChoose(1400, 3);
            } else if (groups == 3) {
                objChoose(1200, 5);
                objChoose(1900, 16);
            } else if (groups == 4) {
                objChoose(100, 15);
                objChoose(600, 1);
                objChoose(900, 5);
                objChoose(1500, 18);
            } else if (groups == 5) {
                objChoose(300, 4);
                objChoose(800, 3);
                objChoose(900, 15);
            } else if (groups == 6) {
                objChoose(200, 7);
                objChoose(300, 15);
                objChoose(1900, 6);
            } else if (groups == 7) {
                objChoose(300, 4);
                objChoose(800, 2);
            } else if (groups == 8) {
                objChoose(300, 7);
                objChoose(400, 16);
                objChoose(800, 20);
            } else if (groups == 9) {
                objChoose(500, 2);
                objChoose(800, 20);
            } else if (groups == 10) {
                objChoose(100, 16);
                objChoose(200, 2);
                objChoose(900, 3);
            } else if (groups == 11) {
                objChoose(100, 15);
                objChoose(200, 16);
                objChoose(800, 3);
                objChoose(1200, 19);
            } else if (groups == 12) {
                objChoose(100, 6);
                objChoose(2000, 3);
                objChoose(2200, 9);
            } else if (groups == 13) {
                objChoose(500, 8);
            } else if (groups == 14) {
                objChoose(800, 6);
                objChoose(1200, 10);
            } else if (groups == 15) {
                objChoose(400, 3);
                objChoose(1000, 6);
                objChoose(1100, 10);
            } else if (groups == 16) {
                objChoose(100, 17);
                objChoose(800, 20);
                objChoose(1600, 1);
            } else if (groups == 17) {
                objChoose(900, 10);
                objChoose(1200, 9);
            } else if (groups == 18) {
                objChoose(900, 9);
                objChoose(1200, 10);
                objChoose(1300, 7);
            } else if (groups == 19) {
                objChoose(200, 9);
                objChoose(400, 4);
                objChoose(1300, 3);
            } else if (groups == 20) {
                objChoose(900, 10);
                objChoose(1200, 17);
                objChoose(2400, 9);
            } else if (groups == 21) {
                objChoose(100, 11);
            } else if (groups == 22) {
                objChoose(100, 12);
            } else if (groups == 23) {
                objChoose(200, 11);
                objChoose(400, 6);
                objChoose(1300, 9);
            } else if (groups == 24) {
                objChoose(900, 12);
                objChoose(1000, 15);
                objChoose(1900, 2);
            } else if (groups == 25) {
                objChoose(100, 10);
                objChoose(2000, 11);
            } else if (groups == 26) {
                objChoose(100, 15);
                objChoose(500, 11);
                objChoose(900, 7);
            } else if (groups == 27) {
                objChoose(100, 6);
                objChoose(900, 12);
            } else if (groups == 28) {
                objChoose(200, 0);
                objChoose(900, 12);
                objChoose(1900, 9);
            } else if (groups == 29) {
                objChoose(600, 9);
                objChoose(1200, 17);
            } else if (groups == 30) {
                objChoose(500, 2);
                objChoose(1200, 16);
                objChoose(1700, 12);
            } else if (groups == 31) {
                objChoose(400, 13);
            } else if (groups == 32) {
                objChoose(400, 14);
            } else if (groups == 33) {
                objChoose(100, 13);
                objChoose(1900, 14);
            } else if (groups == 34) {
                objChoose(400, 13);
                objChoose(800, 1);
                objChoose(1600, 9);
            } else if (groups == 35) {
                objChoose(700, 14);
                objChoose(800, 5);
                objChoose(1600, 12);
                objChoose(2400, 19);
            } else if (groups == 36) {
                objChoose(200, 9);
                objChoose(1600, 10);
                objChoose(1700, 3);
            } else if (groups == 37) {
                objChoose(600, 8);
                objChoose(1200, 10);
                objChoose(1900, 14);
            } else if (groups == 38) {
                objChoose(100, 8);
                objChoose(200, 18);
                objChoose(900, 4);
                objChoose(2200, 14);
            } else if (groups == 39) {
                objChoose(1000, 7);
                objChoose(1200, 15);
            } else if (groups == 40) {
                objChoose(300, 17);
                objChoose(1400, 13);
                objChoose(2800, 1);
            }
        }
        function yOffset(amt) {
            return(Math.random() * amt);
        }
        function hazardHit() {
            if (level > 0) {
                fishHit();
                kickerHit();
                grayFishHit();
            }
            if (level > 1) {
                jfishHit();
                oneupHit();
            }
            if (level > 2) {
                sharkHit();
            }
        }
        function fishHit() {
            if (hook._currentframe < 5) {
                var _local_3 = 1;
                while (_local_3 < 9) {
                    var _local_2 = this["fish" + _local_3];
                    if (_local_2._currentframe > 1) {
                        if (_local_2.obj.hotspot.hitTest(hook.hotspot)) {
                            _local_2.gotoAndStop(1);
                            hook.gotoAndStop(5);
                            hookEmpty = false;
                            addSound("chomp");
                        }
                    }
                    _local_3++;
                }
            }
        }
        function addFish(col) {
            if (currentFish == iceboxArray[iceboxArrayPos]) {
                currentFish = 1;
                iceboxArrayPos = iceboxArrayPos + 1;
                icebox.nextFrame();
            } else {
                currentFish = currentFish + 1;
            }
            fishblockNum = "fishblock" + iceboxArrayPos;
            icebox[fishblockNum].nextFrame();
            fishNum = "fish" + currentFish;
            if (col == "gray") {
                icebox[fishblockNum][fishNum].gotoAndStop(2);
                grayFishTotal = grayFishTotal + 1;
                gft.text = grayFishTotal.toString();
            } else {
                orangeFishTotal = orangeFishTotal + 1;
                oft.text = orangeFishTotal.toString();
            }
        }
        function fishDrop() {
            if (hook._currentframe == 5) {
                if (_ymouse <= icepoint) {
                    consecutiveFishCaught++;
                    if (consecutiveFishCaught == 15) {
                        com.clubpenguin.util.Stamp.sendStamp(STAMP_FISHTASTIC);
                        oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS376_FISHTASTIC);
                    }
                    if (consecutiveFishCaught == 45) {
                        com.clubpenguin.util.Stamp.sendStamp(STAMP_AFISHIONADO);
                        oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS382_AFISHIONADO);
                    }
                    hook.gotoAndStop(2);
                    addFish();
                    catchFish();
                    icebox.fishNum.text = fishCaught;
                    if (fishCaught == 1) {
                        icebox.fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fish", [""]) + " ";
                    } else {
                        icebox.fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fishies", [""]) + " ";
                        if ((fishCaught == 0) && (com.clubpenguin.util.LocaleText.getLocaleID() == com.clubpenguin.util.LocaleText.LANG_ID_FR)) {
                            fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fish", [""]) + " ";
                        }
                    }
                    addSound("fishicebox");
                } else {
                    hook.gotoAndStop(1);
                    fishFlees();
                }
                hookEmpty = true;
            } else if (hook._currentframe == 7) {
                if (_ymouse <= icepoint) {
                    consecutiveFishCaught++;
                    greyFishCaught++;
                    if (greyFishCaught == 15) {
                        com.clubpenguin.util.Stamp.sendStamp(STAMP_GRAY_GOODIES);
                        oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS384_GRAYGOODIES);
                    }
                    if (consecutiveFishCaught == 15) {
                        com.clubpenguin.util.Stamp.sendStamp(STAMP_FISHTASTIC);
                        oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS376_FISHTASTIC);
                    }
                    if (consecutiveFishCaught == 45) {
                        com.clubpenguin.util.Stamp.sendStamp(STAMP_AFISHIONADO);
                        oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS382_AFISHIONADO);
                    }
                    hook.gotoAndStop(2);
                    addFish("gray");
                    catchFish();
                    icebox.fishNum.text = fishCaught;
                    if (fishCaught == 1) {
                        icebox.fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fish", [""]) + " ";
                    } else if ((fishCaught == 0) && (com.clubpenguin.util.LocaleText.getLocaleID() == com.clubpenguin.util.LocaleText.LANG_ID_FR)) {
                        fish.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_fish", [""]) + " ";
                    }
                    addSound("fishicebox");
                } else {
                    hook.gotoAndStop(1);
                    grayfishFlees();
                }
                hookEmpty = true;
            }
        }
        function fishFlees() {
            consecutiveFishCaught = 0;
            addSound("fishfleesound");
            fishflee._x = hook._x;
            fishflee._y = hook._y;
            fishflee.gotoAndPlay(2);
        }
        function grayfishFlees() {
            consecutiveFishCaught = 0;
            addSound("fishfleesound");
            grayfishflee._x = hook._x;
            grayfishflee._y = hook._y;
            grayfishflee.gotoAndPlay(2);
        }
        function jfishHit() {
            if (hook.isHit == false) {
                var _local_3 = 1;
                while (_local_3 < 3) {
                    var _local_2 = this["jfish" + _local_3];
                    if (_local_2._currentframe > 1) {
                        if (_local_2.obj.hotspot.hitTest(hook.hotspot) || (_local_2.obj.hotspot.hitTest(line))) {
                            hook.isHit = true;
                            if (hook._currentframe == 5) {
                                fishFlees();
                            } else if (hook._currentframe == 7) {
                                grayfishFlees();
                            }
                            jellyFishHitCount++;
                            oj.sendEventAction(oj.OPCODEGUID_STUNGBYJELLYFISH);
                            hook.gotoAndStop(6);
                            line.gotoAndStop(2);
                            penguin.gotoAndStop("electro");
                        }
                    }
                    _local_3++;
                }
            }
        }
        function sharkLeftDist() {
            sharkleftDistance = distance(sharkLeft._x, sharkLeft._y, hook._x, hook._y);
            if (sharkleftDistance < 150) {
                if (lineisCut == false) {
                    sharkLeft.gotoAndStop(2);
                } else {
                    sharkLeft.gotoAndStop(1);
                }
            } else {
                sharkLeft.gotoAndStop(1);
            }
        }
        function sharkRightDist() {
            sharkrightDistance = distance(sharkRight._x, sharkRight._y, hook._x, hook._y);
            if (sharkrightDistance < 150) {
                if (lineisCut == false) {
                    sharkRight.gotoAndStop(2);
                } else {
                    sharkRight.gotoAndStop(1);
                }
            } else {
                sharkRight.gotoAndStop(1);
            }
        }
        function sharkHit() {
            if (hook.isHit == false) {
                if (sharkLeft.hotspot.hitTest(hook.hotspot)) {
                    if (!hookEmpty) {
                        feedTheShark();
                    }
                    lineCut(sharkLeft);
                }
                if (sharkRight.hotspot.hitTest(hook.hotspot)) {
                    if (!hookEmpty) {
                        feedTheShark();
                    }
                    lineCut(sharkRight);
                }
            }
        }
        function feedTheShark() {
            consecutiveFishCaught = 0;
            com.clubpenguin.util.Stamp.sendStamp(STAMP_SNACK_ATTACK);
            oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS372_SNACKATTACK);
            addSound("shark");
            oj.sendEventAction(oj.OPCODEGUID_ATEBYSHARK);
        }
        function crabHit() {
            if (hook.isHit == false) {
                if (crab1.hotspot.hitTest(line)) {
                    crabCutTheLine(crab1);
                }
                if (crab2.hotspot.hitTest(line)) {
                    crabCutTheLine(crab2);
                }
            }
        }
        function crabCutTheLine(_targetCrab) {
            linesCutByCrab++;
            lineCut(_targetCrab);
            oj.sendEventAction(oj.OPCODEGUID_CLIPPEDBYCRAB);
        }
        function kickerHit() {
            if (kickerLeft.obj.hotspot.hitTest(hook.hotspot)) {
                if (hook._currentframe == 5) {
                    hook.gotoAndStop(1);
                    fishFlees();
                    hookMove();
                    hookEmpty = true;
                    if (kickerLeft.obj._currentframe == 1) {
                        oj.sendEventAction(oj.OPCODEGUID_KICKEDBYBOOT);
                    } else if (kickerLeft.obj._currentframe == 2) {
                        oj.sendEventAction(oj.OPCODEGUID_HITBYBARREL);
                    }
                }
                if (hook._currentframe == 7) {
                    hook.gotoAndStop(1);
                    grayfishFlees();
                    hookMove();
                    hookEmpty = true;
                    if (kickerLeft.obj._currentframe == 1) {
                        oj.sendEventAction(oj.OPCODEGUID_KICKEDBYBOOT);
                    } else if (kickerLeft.obj._currentframe == 2) {
                        oj.sendEventAction(oj.OPCODEGUID_HITBYBARREL);
                    }
                }
            }
            if (kickerRight.obj.hotspot.hitTest(hook.hotspot)) {
                if (hook._currentframe == 5) {
                    hook.gotoAndStop(1);
                    fishFlees();
                    hookMove();
                    hookEmpty = true;
                    if (kickerRight.obj._currentframe == 1) {
                        oj.sendEventAction(oj.OPCODEGUID_KICKEDBYBOOT);
                    } else if (kickerRight.obj._currentframe == 2) {
                        oj.sendEventAction(oj.OPCODEGUID_HITBYBARREL);
                    }
                }
                if (hook._currentframe == 7) {
                    hook.gotoAndStop(1);
                    grayfishFlees();
                    if (kickerRight.obj._currentframe == 1) {
                        oj.sendEventAction(oj.OPCODEGUID_KICKEDBYBOOT);
                    } else if (kickerRight.obj._currentframe == 2) {
                        oj.sendEventAction(oj.OPCODEGUID_HITBYBARREL);
                    }
                }
                hookMove();
                hookEmpty = true;
            }
        }
        function grayFishHit() {
            if (hook._currentframe < 5) {
                var _local_3 = 1;
                while (_local_3 < 5) {
                    var _local_2 = this["grayfish" + _local_3];
                    if (_local_2._currentframe > 1) {
                        if (_local_2.obj.hotspot.hitTest(hook.hotspot)) {
                            _local_2.gotoAndStop(1);
                            hook.gotoAndStop(7);
                            hookEmpty = false;
                            addSound("chomp");
                        }
                    }
                    _local_3++;
                }
            }
        }
        function bigFishHit() {
            if (bigFish._currentframe < 165) {
                if (bigFish.obj.disthotspot.hitTest(hook.hotspot)) {
                    bigFish.obj.gotoAndStop(2);
                } else {
                    bigFish.obj.gotoAndStop(1);
                }
            }
            if (bigFish.obj.hotspot.hitTest(hook.hotspot)) {
                oj.sendEventAction(oj.OPCODEGUID_CATCHMULLET);
                isBigFishCaught = true;
                this.nextFrame();
            }
        }
        function oneupHit() {
            if ((oneup.obj.hotspot.hitTest(hook.hotspot) && (oneup._alpha == 100)) && (hook._currentframe < 50)) {
                oneup._alpha = oneup._alpha - 10;
                lives++;
                lives_mc.lives.text = lives;
                oneupText.mc.label.text = com.clubpenguin.util.LocaleText.getText("ingame_1UP");
                oneupText._x = 367;
                oneupText._y = 330;
                oneupText.play();
                addSound("ding");
                oj.sendEventAction(oj.OPCODEGUID_CATCHCANOFWORMS);
            }
            if (oneup._alpha < 100) {
                oneup._alpha = oneup._alpha - 10;
            }
            if (oneup._alpha < 10) {
                oneup.gotoAndStop(1);
                oneup._alpha = 100;
            }
        }
        function needWorm() {
            prompt.gotoAndStop(2);
        }
        function getWorm(yvar) {
            if (lives > 0) {
                if ((prompt._currentframe == 2) && (_ymouse <= (icepoint + yvar))) {
                    hook.gotoAndStop(2);
                    prompt.gotoAndStop(1);
                    hook._visible = true;
                    hook.isHit = false;
                    hookEmpty = true;
                    loseLife();
                    lineisCut = false;
                }
            }
        }
        function loseLife() {
            hook.isHit = false;
            hasLostLife = true;
            lives--;
            lives_mc.lives.text = lives;
            hook._visible = true;
        }
        function gameOver() {
            if (!isBigFishCaught) {
                oj.sendEventAction(oj.OPCODEGUID_DIDNTCATCHMULLET);
            }
            gameRunning = false;
            hook._visible = false;
            gameOver_mc._visible = true;
            if (grayFishMode) {
                gameOver_mc.gotoAndStop(2);
                gameOver_mc.fishNum.text = (com.clubpenguin.util.LocaleText.getTextReplaced("ingame_yellowfishscore", ["" + orangeFishTotal, "" + (orangeFishTotal * 4)]) + newline) + com.clubpenguin.util.LocaleText.getTextReplaced("ingame_grayfishscore", ["" + grayFishTotal, "" + (grayFishTotal * 8)]);
            } else {
                gameOver_mc.fishNum.text = com.clubpenguin.util.LocaleText.getTextReplaced("ui_fishcaught", ["" + fishCaught]);
            }
        }
        function getCoins(bonus) {
            var _local_3 = new Object();
            _local_3.coins = ((orangeFishTotal * 4) + (grayFishTotal * 8)) + bonus;
            _local_3.score = _local_3.coins;
            oj.sendGameScore(gameOverEvent, orangeFishTotal + grayFishTotal, _local_3.coins);
            oj.stopGame();
            _root.showWindow("Game Over", _local_3);
        }
        function frame39() {
            com.clubpenguin.util.Stamp.sendStamp(STAMP_PRIZE_MULLET);
            oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS386_PRIZEMULLET);
            if (jellyFishHitCount >= 3) {
                com.clubpenguin.util.Stamp.sendStamp(STAMP_SHOCK_KING);
                oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS374_SHOCKKING);
            }
            if (linesCutByCrab >= 3) {
                com.clubpenguin.util.Stamp.sendStamp(STAMP_CRAB_CUTS);
                oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS380_CRABCUTS);
            }
            if ((greyFishCaught >= 15) && (!hasLostLife)) {
                com.clubpenguin.util.Stamp.sendStamp(STAMP_ACE_ANGLER);
                oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS390_ACEANGLER);
            }
            if (!hasLostLife) {
                com.clubpenguin.util.Stamp.sendStamp(STAMP_WORM_WIN);
                oj.sendStampOpcodes(oj.OPCODEGUID_STAMPS378_WORMWIN);
            }
            this.stop();
        }
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
    }
