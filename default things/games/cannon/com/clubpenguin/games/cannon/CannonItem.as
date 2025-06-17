//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.CannonItem
    {
        var game, gameplayWorld, gameplayHolder, offsetX, offsetY, grabbed, cannonHolder, idNumber, settingN, inCannon, movie, rotClockwise, cannonballMotionX, cannonballMotionY, sizeX, sizeY, hidden, cannonballHolder, puffleON, wait, waitDefault, holdsTotal, currentHold, hold1, hold2, rot, hold3, hold4, groundX, groundY, motionR;
        function CannonItem (_arg_10, _arg_6, _arg_8, _arg_7, _arg_4, _arg_3, _arg_2, _arg_5, _arg_9) {
            game = _arg_10;
            gameplayWorld = _arg_6;
            gameplayHolder = _arg_8;
            offsetX = 0;
            offsetY = 0;
            grabbed = false;
            cannonHolder = _arg_7;
            idNumber = _arg_4;
            settingN = _arg_9;
            inCannon = false;
            movie = cannonHolder.attachMovie("cannon", "Obj" + _arg_4, _arg_4);
            movie._x = _arg_3;
            movie._y = _arg_2;
            movie._rotation = _arg_5;
            rotClockwise = true;
            cannonballMotionX = 0;
            cannonballMotionY = 0;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
            cannonballHolder = cannonHolder.createEmptyMovieClip("cannonballHolder", 1000);
            puffleON = 0;
            if (settingN == 2) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 2;
                currentHold = 2;
                hold1 = -90;
                hold2 = 0;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 3) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 2;
                currentHold = 2;
                hold1 = -90;
                hold2 = -180;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 4) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 2;
                currentHold = 2;
                hold1 = 90;
                hold2 = 0;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 5) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 2;
                currentHold = 2;
                hold1 = 90;
                hold2 = 180;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 6) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 4;
                currentHold = 3;
                hold1 = -90;
                hold2 = 0;
                hold3 = 90;
                hold4 = 180;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 7) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 3;
                currentHold = 3;
                hold1 = -180;
                hold2 = -90;
                hold3 = 0;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 8) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 3;
                currentHold = 1;
                hold1 = 0;
                hold2 = 90;
                hold3 = 180;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 9) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 3;
                currentHold = 1;
                hold1 = 90;
                hold2 = 180;
                hold3 = 270;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 10) {
                wait = 0;
                waitDefault = 10;
                holdsTotal = 3;
                currentHold = 1;
                hold1 = -90;
                hold2 = 0;
                hold3 = 90;
                rot = this["hold" + currentHold];
                movie._rotation = rot;
            } else if (settingN == 12) {
                groundX = _arg_3;
                wait = 0;
                waitDefault = 0;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundX;
                hold2 = groundX + 240;
            } else if (settingN == 13) {
                groundY = _arg_2;
                wait = 0;
                waitDefault = 0;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundY;
                hold2 = groundY + 240;
            } else if (settingN == 14) {
                sizeY = sizeX;
            } else if (settingN == 15) {
                motionR = 0;
                sizeY = sizeX;
            } else if (settingN == 17) {
                groundX = _arg_3;
                wait = 0;
                waitDefault = 0;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundX;
                hold2 = groundX - 240;
            } else if (settingN == 18) {
                groundY = _arg_2;
                wait = 0;
                waitDefault = 0;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundY;
                hold2 = groundY - 240;
            } else if (settingN == 19) {
                groundX = _arg_3;
                wait = 0;
                waitDefault = 0;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundX;
                hold2 = groundX - 240;
            } else if (settingN == 20) {
                groundY = _arg_2;
                wait = 0;
                waitDefault = 0;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundY;
                hold2 = groundY - 240;
            } else if (settingN == 21) {
                groundX = _arg_3;
                wait = 0;
                waitDefault = 0;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundX;
                hold2 = groundX + 240;
            } else if (settingN == 22) {
                groundY = _arg_2;
                wait = 0;
                waitDefault = 0;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundY;
                hold2 = groundY + 240;
            }
        }
        function updateEditor() {
            movie.gotoAndStop(settingN);
            movie.hint.gotoAndStop("show");
            movie.hint._rotation = -movie._rotation;
            if (grabbed == true) {
                if (game.brushObj.getGrabMode() == "drag") {
                    movie._x = gameplayHolder._xmouse + offsetX;
                    movie._y = gameplayHolder._ymouse + offsetY;
                    movie._x = Math.round(movie._x / 10) * 10;
                    movie._y = Math.round(movie._y / 10) * 10;
                    estimatePath();
                } else if (game.brushObj.getGrabMode() == "rotate") {
                    var _local_2 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie._x, movie._y, gameplayHolder._xmouse, gameplayHolder._ymouse);
                    movie._rotation = _local_2;
                    movie.hint._rotation = -_local_2;
                    estimatePath();
                }
            }
        }
        function estimatePath() {
            var _local_2 = 1;
            while (_local_2 < 100) {
                cannonballHolder.attachMovie("cannonball", "can" + _local_2, _local_2);
                var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(movie._rotation, 50);
                var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(movie._rotation, 50);
                cannonballMotionX = _local_5 * 0.8;
                cannonballMotionY = _local_4 * 0.8;
                cannonballHolder["can" + _local_2]._x = movie._x;
                cannonballHolder["can" + _local_2]._y = movie._y;
                cannonballHolder["can" + _local_2]._x = cannonballHolder["can" + _local_2]._x + cannonballMotionX;
                cannonballHolder["can" + _local_2]._y = cannonballHolder["can" + _local_2]._y + cannonballMotionY;
                cannonballHolder["can" + _local_2]._x = cannonballHolder["can" + _local_2]._x + cannonballMotionX;
                cannonballHolder["can" + _local_2]._y = cannonballHolder["can" + _local_2]._y + cannonballMotionY;
                var _local_3 = 1;
                while (_local_3 < _local_2) {
                    cannonballMotionY = cannonballMotionY + 1;
                    cannonballMotionX = cannonballMotionX * 0.98;
                    cannonballMotionY = cannonballMotionY * 0.98;
                    cannonballHolder["can" + _local_2]._x = cannonballHolder["can" + _local_2]._x + cannonballMotionX;
                    cannonballHolder["can" + _local_2]._y = cannonballHolder["can" + _local_2]._y + cannonballMotionY;
                    _local_3++;
                }
                _local_2 = _local_2 + 2;
            }
            if (Key.isDown(32)) {
                puffleON++;
                if ((cannonballHolder["can" + puffleON]._x * 0) == 0) {
                    game.generatePuffleO(Math.round(cannonballHolder["can" + puffleON]._x), Math.round(cannonballHolder["can" + puffleON]._y));
                }
            }
        }
        function updateGameplay(_arg_3) {
            var _local_5 = false;
            if ((movie._x + sizeX) > ((-gameplayHolder._x) - gameplayWorld._x)) {
                if ((movie._x - sizeX) < (((-gameplayHolder._x) - gameplayWorld._x) + 760)) {
                    if ((movie._y + sizeY) > ((-gameplayHolder._y) - gameplayWorld._y)) {
                        if ((movie._y - sizeY) < (((-gameplayHolder._y) - gameplayWorld._y) + 480)) {
                            _local_5 = true;
                        }
                    }
                }
            }
            if (_local_5 == true) {
                if (hidden == true) {
                    movie.gotoAndStop(settingN);
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            var _local_6 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
            if (settingN == 1) {
                if (inCannon == false) {
                    detectPuffle();
                } else if (inCannon == true) {
                    game.playerObj.fire(_arg_3);
                }
            } else if ((settingN >= 2) && (settingN <= 10)) {
                if (inCannon == false) {
                    detectPuffle();
                } else if (inCannon == true) {
                    if (wait > 0) {
                        wait--;
                    } else if (rot == this["hold" + currentHold]) {
                        wait = waitDefault;
                        if ((rotClockwise == true) && (currentHold < holdsTotal)) {
                            currentHold++;
                        } else if ((rotClockwise == false) && (currentHold > 1)) {
                            currentHold--;
                        } else if (holdsTotal == 3) {
                            if (rotClockwise == true) {
                                rotClockwise = false;
                                currentHold--;
                            } else {
                                rotClockwise = true;
                                currentHold++;
                            }
                        } else if (holdsTotal == 4) {
                            rot = rot * -1;
                            currentHold = 1;
                        } else {
                            currentHold = 1;
                        }
                    } else if (rot < this["hold" + currentHold]) {
                        rot = rot + (10 * _arg_3);
                        if (rot > this["hold" + currentHold]) {
                            rot = this["hold" + currentHold];
                        }
                        movie._rotation = rot;
                    } else if (rot > this["hold" + currentHold]) {
                        rot = rot - (10 * _arg_3);
                        if (rot < this["hold" + currentHold]) {
                            rot = this["hold" + currentHold];
                        }
                        movie._rotation = rot;
                    }
                }
            } else if (settingN == 11) {
                if (inCannon == false) {
                    detectPuffle();
                }
            } else if ((((settingN == 12) || (settingN == 17)) || (settingN == 19)) || (settingN == 21)) {
                if ((settingN == 19) || (settingN == 21)) {
                    var _local_4 = true;
                }
                if (inCannon == false) {
                    detectPuffle();
                    if (_local_4 != true) {
                        if (movie._x != hold1) {
                            if (movie._x == this["hold" + currentHold]) {
                                if (currentHold < holdsTotal) {
                                    currentHold++;
                                } else {
                                    currentHold = 1;
                                }
                            } else if (movie._x < this["hold" + currentHold]) {
                                movie._x = movie._x + 10;
                                if (movie._x > this["hold" + currentHold]) {
                                    movie._x = this["hold" + currentHold];
                                }
                            } else if (movie._x > this["hold" + currentHold]) {
                                movie._x = movie._x - 10;
                                if (movie._x < this["hold" + currentHold]) {
                                    movie._x = this["hold" + currentHold];
                                }
                            }
                        }
                    }
                    if (_local_4 == true) {
                        if (movie._x == this["hold" + currentHold]) {
                            if (currentHold < holdsTotal) {
                                currentHold++;
                            } else {
                                currentHold = 1;
                            }
                        } else if (movie._x < this["hold" + currentHold]) {
                            movie._x = movie._x + 10;
                            if (movie._x > this["hold" + currentHold]) {
                                movie._x = this["hold" + currentHold];
                            }
                        } else if (movie._x > this["hold" + currentHold]) {
                            movie._x = movie._x - 10;
                            if (movie._x < this["hold" + currentHold]) {
                                movie._x = this["hold" + currentHold];
                            }
                        }
                    }
                } else if (inCannon == true) {
                    if (movie._x == this["hold" + currentHold]) {
                        if (currentHold < holdsTotal) {
                            currentHold++;
                        } else {
                            currentHold = 1;
                        }
                    } else {
                        if (movie._x < this["hold" + currentHold]) {
                            movie._x = movie._x + 10;
                            if (movie._x > this["hold" + currentHold]) {
                                movie._x = this["hold" + currentHold];
                            }
                        } else if (movie._x > this["hold" + currentHold]) {
                            movie._x = movie._x - 10;
                            if (movie._x < this["hold" + currentHold]) {
                                movie._x = this["hold" + currentHold];
                            }
                        }
                        game.playerObj.movie._x = movie._x;
                    }
                }
            } else if ((((settingN == 13) || (settingN == 18)) || (settingN == 20)) || (settingN == 22)) {
                if ((settingN == 20) || (settingN == 22)) {
                    var _local_4 = true;
                }
                if (inCannon == false) {
                    detectPuffle();
                    if (_local_4 != true) {
                        if (movie._y != hold1) {
                            if (movie._y == this["hold" + currentHold]) {
                                if (currentHold < holdsTotal) {
                                    currentHold++;
                                } else {
                                    currentHold = 1;
                                }
                            } else if (movie._y < this["hold" + currentHold]) {
                                movie._y = movie._y + 10;
                                if (movie._y > this["hold" + currentHold]) {
                                    movie._y = this["hold" + currentHold];
                                }
                            } else if (movie._y > this["hold" + currentHold]) {
                                movie._y = movie._y - 10;
                                if (movie._y < this["hold" + currentHold]) {
                                    movie._y = this["hold" + currentHold];
                                }
                            }
                        }
                    }
                    if (_local_4 == true) {
                        if (movie._y == this["hold" + currentHold]) {
                            if (currentHold < holdsTotal) {
                                currentHold++;
                            } else {
                                currentHold = 1;
                            }
                        } else if (movie._y < this["hold" + currentHold]) {
                            movie._y = movie._y + 10;
                            if (movie._y > this["hold" + currentHold]) {
                                movie._y = this["hold" + currentHold];
                            }
                        } else if (movie._y > this["hold" + currentHold]) {
                            movie._y = movie._y - 10;
                            if (movie._y < this["hold" + currentHold]) {
                                movie._y = this["hold" + currentHold];
                            }
                        }
                    }
                } else if (inCannon == true) {
                    if (movie._y == this["hold" + currentHold]) {
                        if (currentHold < holdsTotal) {
                            currentHold++;
                        } else {
                            currentHold = 1;
                        }
                    } else {
                        if (movie._y < this["hold" + currentHold]) {
                            movie._y = movie._y + 10;
                            if (movie._y > this["hold" + currentHold]) {
                                movie._y = this["hold" + currentHold];
                            }
                        } else if (movie._y > this["hold" + currentHold]) {
                            movie._y = movie._y - 10;
                            if (movie._y < this["hold" + currentHold]) {
                                movie._y = this["hold" + currentHold];
                            }
                        }
                        game.playerObj.movie._y = movie._y;
                    }
                }
            } else if (settingN == 14) {
                if (inCannon == false) {
                    detectPuffle();
                } else if (inCannon == true) {
                    movie._rotation = movie._rotation + 8;
                }
            } else if (settingN == 15) {
                if (inCannon == false) {
                    detectPuffle();
                } else if (inCannon == true) {
                    var _local_2 = false;
                    if (Key.isDown(37) || Key.isDown(65)) {
                        motionR = motionR - 2;
                        _local_2 = true;
                    }
                    if (Key.isDown(39) || Key.isDown(68)) {
                        motionR = motionR + 2;
                        _local_2 = true;
                    }
                }
                if (_local_2 == true) {
                    motionR = motionR * 0.8;
                } else {
                    motionR = motionR * 0.7;
                }
                movie._rotation = movie._rotation + motionR;
            } else if (settingN == 16) {
                if (inCannon == false) {
                    detectPuffle();
                } else if (inCannon == true) {
                    game.playerObj.startX = movie._x;
                    game.playerObj.startY = movie._y - 60;
                    movie.art.flaggy.gotoAndStop("show");
                    game.playerObj.fire(_arg_3);
                }
            } else if (settingN == 23) {
                if (inCannon == false) {
                    detectPuffle();
                } else if (inCannon == true) {
                    movie.art.art.charge.gotoAndStop("charge");
                }
            }
        }
        function shoot() {
            inCannon = false;
            movie.art.gotoAndStop("still");
            movie.art.gotoAndStop("fire");
            if (settingN == 23) {
                game.forceSlowMode = true;
            }
        }
        function detectPuffle() {
            if (game.playerObj.inCannon == false) {
                var _local_2 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                if (_local_2 < 40) {
                    game.playerObj.inCannon = true;
                    inCannon = true;
                    game.forceSlowMode = false;
                    game.playerObj.motionX = 0;
                    game.playerObj.motionY = 0;
                    game.playerObj.movie._x = movie._x;
                    game.playerObj.movie._y = movie._y;
                    movie.art.gotoAndStop("still");
                    movie.art.art.window.puffle.gotoAndStop(game.playerColor);
                    game.playerObj.isIn = this;
                }
            }
        }
        function mouseClick() {
            if (game.brushObj.grabValid()) {
                if (movie.hitTest(_xmouse, _ymouse, true)) {
                    if (game.brushObj.getSettingN() == 0) {
                        if ((game.brushObj.getGrabMode() == "drag") || (game.brushObj.getGrabMode() == "rotate")) {
                            if (game.brushObj.getGrabbing() == false) {
                                game.brushObj.setGrabbing(true);
                                grabbed = true;
                                if (movie._x > gameplayHolder._xmouse) {
                                    offsetX = movie._x - gameplayHolder._xmouse;
                                } else if (movie._x < gameplayHolder._xmouse) {
                                    offsetX = (gameplayHolder._xmouse - movie._x) * -1;
                                } else {
                                    offsetX = 0;
                                }
                                if (movie._y > gameplayHolder._ymouse) {
                                    offsetY = movie._y - gameplayHolder._ymouse;
                                } else if (movie._y < gameplayHolder._ymouse) {
                                    offsetY = (gameplayHolder._ymouse - movie._y) * -1;
                                } else {
                                    offsetY = 0;
                                }
                            }
                        } else if (game.brushObj.getGrabMode() == "erase") {
                            game.removeObject(this, game.level1cannonArray);
                        }
                    }
                }
            }
        }
        function mouseRelease() {
            if (grabbed == true) {
                grabbed = false;
                game.brushObj.setGrabbing(false);
            }
        }
        function destroy() {
            movie.removeMovieClip();
        }
    }
