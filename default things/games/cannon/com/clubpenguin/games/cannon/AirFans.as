//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.AirFans extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var motionX, motionY, motionSpeed, movie, settingN, sizeX, sizeY, hidden, groundY, holdsTotal, currentHold, hold1, hold2, waitDefault, wait, groundX, gameplayWorld, gameplayHolder, game, holdMet;
        function AirFans (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            motionX = 0;
            motionY = 0;
            motionSpeed = 1;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
            if (settingN == 13) {
                groundY = movie._y;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundY;
                hold2 = groundY + 300;
                waitDefault = 10;
                wait = 0;
            }
            if (settingN == 14) {
                groundY = movie._y;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundY - 300;
                hold2 = groundY;
                waitDefault = 10;
                wait = 0;
            }
            if (settingN == 15) {
                groundX = movie._x;
                holdsTotal = 2;
                currentHold = 2;
                hold1 = groundX - 300;
                hold2 = groundX;
                waitDefault = 10;
                wait = 0;
            }
            if (settingN == 16) {
                groundX = movie._x;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundX;
                hold2 = groundX + 300;
                waitDefault = 10;
                wait = 0;
            }
        }
        function updateGameplay($speedMod) {
            var _local_4 = false;
            if ((movie._x + sizeX) > ((-gameplayHolder._x) - gameplayWorld._x)) {
                if ((movie._x - sizeX) < (((-gameplayHolder._x) - gameplayWorld._x) + 760)) {
                    if ((movie._y + sizeY) > ((-gameplayHolder._y) - gameplayWorld._y)) {
                        if ((movie._y - sizeY) < (((-gameplayHolder._y) - gameplayWorld._y) + 480)) {
                            _local_4 = true;
                        }
                    }
                }
            }
            if (_local_4 == true) {
                if (hidden == true) {
                    movie.gotoAndStop(settingN);
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            if (game.playerObj.inCannon == false) {
                var _local_6 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                if (_local_6 < 220) {
                    if (game.playerObj.movie._y < movie._y) {
                        if (game.playerObj.movie._x > (movie._x - 60)) {
                            if (game.playerObj.movie._x < (movie._x + 60)) {
                                var _local_3 = movie.art._rotation - 90;
                                var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_3, 1.8);
                                var _local_2 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_3, 1.8);
                                game.playerObj.motionX = game.playerObj.motionX + _local_5;
                                if (game.playerObj.motionY > 0) {
                                    game.playerObj.motionY = game.playerObj.motionY + (_local_2 - (game.playerObj.motionY / 3));
                                } else {
                                    game.playerObj.motionY = game.playerObj.motionY + _local_2;
                                }
                                game.playerObj.motionR = game.playerObj.motionR + _local_2;
                            }
                        }
                    }
                }
            }
            if ((settingN == 13) || (settingN == 14)) {
                if (wait > 0) {
                    wait--;
                } else {
                    holdMet = false;
                    if (currentHold == 1) {
                        if (movie._y <= this["hold" + currentHold]) {
                            holdMet = true;
                        }
                    } else if (currentHold == 2) {
                        if (movie._y >= this["hold" + currentHold]) {
                            holdMet = true;
                        }
                    }
                    if (holdMet == true) {
                        wait = waitDefault;
                        if (currentHold < holdsTotal) {
                            currentHold++;
                        } else {
                            currentHold = 1;
                        }
                    } else if (movie._y < this["hold" + currentHold]) {
                        motionY = motionY + motionSpeed;
                    } else if (movie._y > this["hold" + currentHold]) {
                        motionY = motionY - motionSpeed;
                    }
                }
            }
            if ((settingN == 15) || (settingN == 16)) {
                if (wait > 0) {
                    wait--;
                } else {
                    holdMet = false;
                    if (currentHold == 1) {
                        if (movie._x <= this["hold" + currentHold]) {
                            holdMet = true;
                        }
                    } else if (currentHold == 2) {
                        if (movie._x >= this["hold" + currentHold]) {
                            holdMet = true;
                        }
                    }
                    if (holdMet == true) {
                        wait = waitDefault;
                        if (currentHold < holdsTotal) {
                            currentHold++;
                        } else {
                            currentHold = 1;
                        }
                    } else if (movie._x < this["hold" + currentHold]) {
                        motionX = motionX + motionSpeed;
                    } else if (movie._x > this["hold" + currentHold]) {
                        motionX = motionX - motionSpeed;
                    }
                }
            }
            motionX = motionX * 0.9;
            motionY = motionY * 0.9;
            movie._x = movie._x + motionX;
            movie._y = movie._y + motionY;
        }
    }
