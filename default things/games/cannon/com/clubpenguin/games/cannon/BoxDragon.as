//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.BoxDragon extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var motionX, motionY, elasticMultiplier, elasticMultiplierDefault, movie, settingN, sizeX, sizeY, hidden, pullY, pullX, flippedX, game, gameplayWorld, gameplayHolder;
        function BoxDragon (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            motionX = 0;
            motionY = 0;
            elasticMultiplier = 0.95;
            elasticMultiplierDefault = 0.95;
            movie.gotoAndStop(settingN);
            sizeX = movie._width + 700;
            sizeY = movie._height + 700;
            movie.gotoAndStop("hide");
            hidden = true;
            pullY = 0;
            pullX = 0;
            flippedX = false;
            movie.master = this;
            if (game.gameMode == "standardGameplay") {
                movie.art.gotoAndStop("gameplay");
            }
        }
        function updateGameplay(_arg_3) {
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
                    movie.art.gotoAndStop("gameplay");
                    movie.art.art.b1.gotoAndStop("still");
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            motionY = motionY + pullY;
            motionX = motionX + pullX;
            motionX = motionX * (1 - (0.2 * _arg_3));
            motionY = motionY * (1 - (0.2 * _arg_3));
            movie._x = movie._x + (motionX * _arg_3);
            movie._y = movie._y + (motionY * _arg_3);
            if (game.playerObj.inCannon == false) {
                var _local_2 = 1;
                while (_local_2 <= 6) {
                    detectPlayer(_local_2);
                    _local_2++;
                }
            }
        }
        function detectPlayer(_arg_2) {
            var _local_11 = com.clubpenguin["math"].AaronsPhysics.findDistance((movie._x + movie.art.art._x) + movie.art.art["c" + _arg_2]._x, (movie._y + movie.art.art._y) + movie.art.art["c" + _arg_2]._y, game.playerObj.movie._x, game.playerObj.movie._y);
            var _local_12 = false;
            var _local_9 = (movie._x + movie.art.art._x) + movie.art.art["c" + _arg_2]._x;
            var _local_10 = (movie._y + movie.art.art._y) + movie.art.art["c" + _arg_2]._y;
            if (flippedX == true) {
                _local_11 = com.clubpenguin["math"].AaronsPhysics.findDistance((movie._x - movie.art.art._x) - movie.art.art["c" + _arg_2]._x, (movie._y + movie.art.art._x) + movie.art.art["c" + _arg_2]._y, game.playerObj.movie._x, game.playerObj.movie._y);
                _local_9 = (movie._x - movie.art.art._x) - movie.art.art["c" + _arg_2]._x;
            }
            var _local_4 = game.playerObj.movie._x;
            var _local_3 = game.playerObj.movie._y;
            if (_arg_2 == 1) {
                var _local_7 = 186;
                var _local_6 = 186;
                var _local_5 = 41;
            } else if (_arg_2 == 2) {
                var _local_7 = 146;
                var _local_6 = 146;
                var _local_5 = 69;
            } else if (_arg_2 == 3) {
                var _local_7 = 242;
                var _local_6 = 242;
                var _local_5 = 113;
            } else if (_arg_2 == 4) {
                var _local_7 = 188;
                var _local_6 = 188;
                var _local_5 = 139;
            } else if (_arg_2 == 5) {
                var _local_7 = 123;
                var _local_6 = 123;
                var _local_5 = 69;
            } else if (_arg_2 == 6) {
                var _local_7 = 136;
                var _local_6 = 136;
                var _local_5 = 103;
            }
            if (_local_11 < _local_7) {
                if (_local_4 > (_local_9 - _local_6)) {
                    if (_local_4 < (_local_9 + _local_6)) {
                        if (_local_3 > (_local_10 - _local_5)) {
                            if (_local_3 < (_local_10 + _local_5)) {
                                _local_12 = true;
                            }
                        }
                    }
                }
            }
            if (_local_12 == true) {
                var _local_13 = false;
                _local_4 = game.playerObj.halfPosX;
                _local_3 = game.playerObj.halfPosY;
                if (_local_11 < _local_7) {
                    if (_local_4 > (_local_9 - _local_6)) {
                        if (_local_4 < (_local_9 + _local_6)) {
                            if (_local_3 > (_local_10 - _local_5)) {
                                if (_local_3 < (_local_10 + _local_5)) {
                                    _local_13 = true;
                                }
                            }
                        }
                    }
                }
            }
            if (_local_13 == true) {
                var _local_15 = false;
                _local_4 = game.playerObj.onethirdPosX;
                _local_3 = game.playerObj.onethirdPosY;
                if (_local_11 < _local_7) {
                    if (_local_4 > (_local_9 - _local_6)) {
                        if (_local_4 < (_local_9 + _local_6)) {
                            if (_local_3 > (_local_10 - _local_5)) {
                                if (_local_3 < (_local_10 + _local_5)) {
                                    _local_15 = true;
                                }
                            }
                        }
                    }
                }
            }
            if (_local_12 == true) {
                if (_local_15 == true) {
                    _local_4 = game.playerObj.onethirdPosX;
                    _local_3 = game.playerObj.onethirdPosY;
                } else if (_local_13 == true) {
                    _local_4 = game.playerObj.halfPosX;
                    _local_3 = game.playerObj.halfPosY;
                } else {
                    _local_4 = game.playerObj.movie._x;
                    _local_3 = game.playerObj.movie._y;
                }
                var _local_14 = com.clubpenguin["math"].AaronsPhysics.findAngle(_local_4, _local_3, (movie._x + movie.art.art._x) + movie.art.art["c" + _arg_2]._x, (movie._y + movie.art.art._y) + movie.art.art["c" + _arg_2]._y);
                if (flippedX == true) {
                    _local_14 = com.clubpenguin["math"].AaronsPhysics.findAngle(_local_4, _local_3, (movie._x - movie.art.art._x) - movie.art.art["c" + _arg_2]._x, (movie._y + movie.art.art._y) + movie.art.art["c" + _arg_2]._y);
                }
                var _local_8 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_14, 20);
                if (_local_8 > 0) {
                    _local_8 = 20;
                }
                if (_local_8 < 0) {
                    _local_8 = -20;
                }
                _local_8 = _local_8 - (motionY * 1.2);
                game.playerObj.motionY = _local_8 * -1;
                game.playerObj.motionR = Math.abs(_local_8);
                if (_arg_2 == 1) {
                    movie.art.art.tail2.gotoAndStop("wave");
                } else if (_arg_2 == 2) {
                    movie.art.art.tail1.gotoAndStop("bump");
                } else if (_arg_2 == 3) {
                    movie.art.art.torso.gotoAndStop("bump");
                } else if (_arg_2 == 5) {
                    movie.art.art.neck.gotoAndStop("bump");
                } else if (_arg_2 == 6) {
                    movie.art.art.head.gotoAndStop("sleep");
                    movie.art.art.head.gotoAndStop("awake");
                }
            }
        }
    }
