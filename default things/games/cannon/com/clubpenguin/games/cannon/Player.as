//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.Player
    {
        var game, gameplayWorld, gameplayHolder, blurHolder, playerColor, spaceUp, spaceDown, spacePress, leftKeyUp, leftKeyDown, leftKeyPress, rightKeyUp, rightKeyDown, rightKeyPress, inCannon, blurN, blurMax, blurCharged, skipNextBlur, alive, pushX, pushY, motionX, motionY, motionR, movie, startX, startY, halfPosX, halfPosY, ground, skyN, camLocked, camMotionX, camMotionY, camChasePull, camChaseFriction, camTarget, tap0FrameBack, tap1FrameBack, tap2FrameBack, tap3FrameBack, tap4FrameBack, tap5FrameBack, shareFrame, isIn, onethirdPosX, onethirdPosY, camTargetTimeN, shareFrameTarget;
        function Player (_arg_10, _arg_3, _arg_9, _arg_4, _arg_7, _arg_6, _arg_8, _arg_2, _arg_5) {
            game = _arg_10;
            gameplayWorld = _arg_3;
            gameplayHolder = _arg_9;
            gameplayHolder._x = 0;
            gameplayHolder._y = 0;
            blurHolder = _arg_4;
            playerColor = _arg_8;
            spaceUp = true;
            spaceDown = false;
            spacePress = false;
            leftKeyUp = true;
            leftKeyDown = false;
            leftKeyPress = false;
            rightKeyUp = true;
            rightKeyDown = false;
            rightKeyPress = false;
            inCannon = false;
            blurN = 2;
            blurMax = 20;
            blurCharged = false;
            skipNextBlur = true;
            alive = true;
            pushX = 0;
            pushY = 0;
            motionX = 0;
            motionY = 0;
            motionR = 0;
            movie = gameplayHolder.attachMovie("player", "player", 9);
            startX = _arg_7;
            startY = _arg_6;
            movie._x = startX;
            movie._y = startY;
            halfPosX = startX;
            halfPosY = startY;
            movie.gotoAndStop(playerColor);
            ground = _arg_2;
            skyN = _arg_5;
            camLocked = true;
            camMotionX = 0;
            camMotionY = 0;
            camChasePull = 20;
            camChaseFriction = 0.7;
            camTarget = movie;
            tap0FrameBack = false;
            tap1FrameBack = false;
            tap2FrameBack = false;
            tap3FrameBack = false;
            tap4FrameBack = false;
            tap5FrameBack = false;
            shareFrame = false;
        }
        function getPosX() {
            return(movie._x);
        }
        function getPosY() {
            return(movie._y);
        }
        function fire($speedMod) {
            if (isIn.noFire != true) {
                inCannon = false;
                var _local_3 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(isIn.movie._rotation, 50);
                var _local_2 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(isIn.movie._rotation, 50);
                motionX = _local_3 * 0.8;
                motionY = _local_2 * 0.8;
                motionR = Math.abs(_local_3) + Math.abs(_local_2);
                movie._x = movie._x + _local_3;
                movie._y = movie._y + _local_2;
                skipNextBlur = true;
                blurCharged = true;
                isIn.shoot();
            }
        }
        function resetYar() {
            movie._x = startX;
            movie._y = startY;
            movie._rotation = 0;
            motionX = 0;
            motionY = 0;
            motionR = 0;
            gameplayHolder._x = 0;
            gameplayHolder._y = 0;
            inCannon = false;
            movie._visible = true;
            alive = true;
            skipNextBlur = true;
            blurCharged = false;
            camLocked = true;
            game.gravityInverted == false;
        }
        function updateGameplay(_arg_2) {
            tap5FrameBack = tap4FrameBack;
            tap4FrameBack = tap3FrameBack;
            tap3FrameBack = tap2FrameBack;
            tap2FrameBack = tap1FrameBack;
            tap1FrameBack = tap0FrameBack;
            tap0FrameBack = false;
            if (Key.isDown(32)) {
                if (spaceUp == true) {
                    spacePress = true;
                }
                spaceUp = false;
                spaceDown = true;
            } else {
                spaceUp = true;
                spaceDown = false;
                spacePress = false;
            }
            if (Key.isDown(37) || Key.isDown(65)) {
                if (leftKeyUp == true) {
                    leftKeyPress = true;
                    tap0FrameBack = true;
                }
                leftKeyUp = false;
                leftKeyDown = true;
            } else {
                leftKeyUp = true;
                leftKeyDown = false;
                leftKeyPress = false;
            }
            if (Key.isDown(39) || Key.isDown(68)) {
                if (rightKeyUp == true) {
                    rightKeyPress = true;
                    tap0FrameBack = true;
                }
                rightKeyUp = false;
                rightKeyDown = true;
            } else {
                rightKeyUp = true;
                rightKeyDown = false;
                rightKeyPress = false;
            }
            if (inCannon == false) {
                if ((Math.abs(motionX) < 5) && (Math.abs(motionY) < 5)) {
                    blurCharged = false;
                }
                if (game.gravityInverted == false) {
                    motionY = motionY + (1 * _arg_2);
                } else if (game.gravityInverted == true) {
                    motionY = motionY - (1 * _arg_2);
                }
                motionX = motionX * (1 - (0.02 * _arg_2));
                motionY = motionY * (1 - (0.02 * _arg_2));
                motionR = motionR * (1 - (0.02 * _arg_2));
                if (leftKeyDown == true) {
                    if (game.inCutscene == false) {
                        if (leftKeyPress == true) {
                            if ((((((tap0FrameBack == true) || (tap1FrameBack == true)) || (tap2FrameBack == true)) || (tap3FrameBack == true)) || (tap4FrameBack == true)) || (tap5FrameBack == true)) {
                                if (game.inCutscene == false) {
                                    motionX = motionX - (0.9 / _arg_2);
                                    movie._xscale = -100;
                                }
                            }
                        }
                        motionX = motionX - (0.8 / _arg_2);
                        movie._xscale = -100;
                        motionR = motionR + 0.4;
                    }
                }
                if (rightKeyDown == true) {
                    if (game.inCutscene == false) {
                        if (rightKeyPress == true) {
                            if ((((((tap0FrameBack == true) || (tap1FrameBack == true)) || (tap2FrameBack == true)) || (tap3FrameBack == true)) || (tap4FrameBack == true)) || (tap5FrameBack == true)) {
                                motionX = motionX + (0.9 / _arg_2);
                                movie._xscale = 100;
                            }
                        }
                        motionX = motionX + (0.8 / _arg_2);
                        movie._xscale = 100;
                        motionR = motionR + 0.4;
                    }
                }
                if (alive == true) {
                    if (game.gravityInverted == false) {
                        if (movie._y > ground) {
                            fallout("down");
                        }
                    } else if (movie._y < game.ceilingY) {
                        if (game.skyN == 3) {
                            fallout("up");
                        } else {
                            game.gravityInverted = false;
                        }
                    }
                }
            } else if (inCannon == true) {
                if (spacePress == true) {
                    if (game.inCutscene == false) {
                        fire(_arg_2);
                    }
                }
            }
            halfPosX = movie._x + ((motionX * _arg_2) / 2);
            halfPosY = movie._y + ((motionY * _arg_2) / 2);
            onethirdPosX = (movie._x + ((motionX * _arg_2) / 2)) + ((motionX * _arg_2) / 3);
            onethirdPosY = (movie._y + ((motionY * _arg_2) / 2)) + ((motionY * _arg_2) / 3);
            movie._rotation = movie._rotation + (motionR * _arg_2);
            movie._x = movie._x + (motionX * _arg_2);
            movie._y = movie._y + (motionY * _arg_2);
            var _local_4 = gameplayHolder._x;
            var _local_3 = gameplayHolder._y;
            if (camTargetTimeN > 0) {
                camTargetTimeN--;
                if (camTargetTimeN == 0) {
                    camTarget = movie;
                    camLocked = false;
                    camChasePull = 20;
                    camChaseFriction = 0.7;
                }
            }
            if (((camTarget._y + _local_3) + gameplayWorld._y) > 280) {
                _local_3 = _local_3 + (280 - ((camTarget._y + _local_3) + gameplayWorld._y));
            } else if (((camTarget._y + _local_3) + gameplayWorld._y) < 200) {
                _local_3 = _local_3 + (200 - ((camTarget._y + _local_3) + gameplayWorld._y));
            }
            if (((camTarget._x + _local_4) + gameplayWorld._x) > 460) {
                _local_4 = _local_4 + (460 - ((camTarget._x + _local_4) + gameplayWorld._x));
            } else if (((camTarget._x + _local_4) + gameplayWorld._x) < 300) {
                _local_4 = _local_4 + (300 - ((camTarget._x + _local_4) + gameplayWorld._x));
            }
            if (shareFrame == true) {
                if (((shareFrameTarget._y + _local_3) + gameplayWorld._y) > 380) {
                    _local_3 = _local_3 + (380 - ((shareFrameTarget._y + _local_3) + gameplayWorld._y));
                } else if (((shareFrameTarget._y + _local_3) + gameplayWorld._y) < 100) {
                    _local_3 = _local_3 + (100 - ((shareFrameTarget._y + _local_3) + gameplayWorld._y));
                }
                if (((shareFrameTarget._x + _local_4) + gameplayWorld._x) > 560) {
                    _local_4 = _local_4 + (560 - ((shareFrameTarget._x + _local_4) + gameplayWorld._x));
                } else if (((shareFrameTarget._x + _local_4) + gameplayWorld._x) < 200) {
                    _local_4 = _local_4 + (200 - ((shareFrameTarget._x + _local_4) + gameplayWorld._x));
                }
            }
            if (camLocked == true) {
                if (alive == true) {
                    gameplayHolder._x = _local_4;
                    gameplayHolder._y = _local_3;
                    camMotionX = 0;
                    camMotionY = 0;
                }
            } else {
                var _local_9 = com.clubpenguin["math"].AaronsPhysics.findDistance(gameplayHolder._x, gameplayHolder._y, _local_4, _local_3);
                if (_local_9 > 10) {
                    var _local_8 = com.clubpenguin["math"].AaronsPhysics.findAngle(gameplayHolder._x, gameplayHolder._y, _local_4, _local_3);
                    var _local_7 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_8, (_local_9 * 2) / camChasePull);
                    var _local_6 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_8, (_local_9 * 2) / camChasePull);
                    camMotionX = camMotionX + _local_7;
                    camMotionY = camMotionY + _local_6;
                }
                camMotionX = camMotionX * camChaseFriction;
                camMotionY = camMotionY * camChaseFriction;
                gameplayHolder._x = gameplayHolder._x + camMotionX;
                gameplayHolder._y = gameplayHolder._y + camMotionY;
                if (camChasePull > 2) {
                    camChasePull = camChasePull - 0.375;
                }
                if (camChaseFriction > 0.4) {
                    camChaseFriction = camChaseFriction - 0.00625;
                }
                _local_9 = com.clubpenguin["math"].AaronsPhysics.findDistance(gameplayHolder._x, gameplayHolder._y, _local_4, _local_3);
                if (_local_9 <= 10) {
                    camLocked = true;
                }
            }
            if (blurCharged == true) {
                if (blurN >= blurMax) {
                    blurN = 1;
                    var _local_5 = blurMax - 1;
                } else {
                    var _local_5 = blurN;
                }
                if (inCannon == false) {
                    blurN++;
                    blurHolder.attachMovie("blur", "blur" + blurN, blurN);
                    blurHolder["blur" + blurN]._x = movie._x;
                    blurHolder["blur" + blurN]._y = movie._y;
                    blurHolder["blur" + blurN].art.gotoAndStop(playerColor);
                    var _local_8 = com.clubpenguin["math"].AaronsPhysics.findAngle(blurHolder["blur" + blurN]._x, blurHolder["blur" + blurN]._y, blurHolder["blur" + _local_5]._x, blurHolder["blur" + _local_5]._y);
                    blurHolder["blur" + blurN]._rotation = _local_8;
                    var _local_9 = com.clubpenguin["math"].AaronsPhysics.findDistance(blurHolder["blur" + blurN]._x, blurHolder["blur" + blurN]._y, blurHolder["blur" + _local_5]._x, blurHolder["blur" + _local_5]._y);
                    blurHolder["blur" + blurN]._xscale = blurHolder["blur" + blurN]._xscale * (_local_9 / 6);
                    if (skipNextBlur == true) {
                        skipNextBlur = false;
                        blurHolder["blur" + blurN]._visible = false;
                        blurHolder["blur" + blurN]._x = movie._x;
                        blurHolder["blur" + blurN]._y = movie._y;
                    }
                }
            }
            spacePress = false;
            rightKeyPress = false;
            leftKeyPress = false;
        }
        function fallout(_arg_2) {
            alive = false;
            game.forceSlowMode = false;
            game.gravityInverted = false;
            motionX = 0;
            motionY = 0;
            movie._visible = false;
            gameplayHolder.particleHolder.attachMovie("splash", "splash", 1);
            gameplayHolder.particleHolder.splash.player = this;
            gameplayHolder.particleHolder.splash._x = movie._x;
            gameplayHolder.particleHolder.splash._y = movie._y;
            if (_arg_2 == "up") {
                gameplayHolder.particleHolder.splash._yscale = -100;
            }
            gameplayHolder.particleHolder.splash.gotoAndStop(skyN);
        }
        function destroy() {
            movie.removeMovieClip();
        }
    }
