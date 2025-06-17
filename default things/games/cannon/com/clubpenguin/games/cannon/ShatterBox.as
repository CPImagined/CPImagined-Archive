//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.ShatterBox extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX, movie, groundY, motionX, motionY, elasticMultiplier, elasticMultiplierDefault, settingN, sizeX, sizeY, hidden, breakN, defaultBreakN, waitN, game, gameplayWorld, gameplayHolder;
        function ShatterBox (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            groundX = movie._x;
            groundY = movie._y;
            motionX = 0;
            motionY = 0;
            elasticMultiplier = 0.95;
            elasticMultiplierDefault = 0.95;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height + 700;
            movie.gotoAndStop("hide");
            hidden = true;
            movie.master = this;
            breakN = random(3);
            defaultBreakN = breakN;
            waitN = 0;
        }
        function updateGameplay(_arg_6) {
            if (breakN == 4) {
                if (game.playerObj.alive == false) {
                    breakN = defaultBreakN;
                    movie.art.gotoAndStop("reappear");
                }
            }
            var _local_13 = false;
            if ((movie._x + sizeX) > ((-gameplayHolder._x) - gameplayWorld._x)) {
                if ((movie._x - sizeX) < (((-gameplayHolder._x) - gameplayWorld._x) + 760)) {
                    if ((movie._y + sizeY) > ((-gameplayHolder._y) - gameplayWorld._y)) {
                        if ((movie._y - sizeY) < (((-gameplayHolder._y) - gameplayWorld._y) + 480)) {
                            _local_13 = true;
                        }
                    }
                }
            }
            if (_local_13 == true) {
                if (hidden == true) {
                    movie.gotoAndStop(settingN);
                    movie.art.gotoAndStop(("break" + breakN) + "still");
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            if (waitN > 0) {
                waitN--;
            } else if (breakN < 4) {
                if (game.playerObj.inCannon == false) {
                    var _local_11 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                    var _local_9 = false;
                    var _local_8 = movie._x;
                    var _local_7 = movie._y;
                    var _local_3 = game.playerObj.movie._x;
                    var _local_2 = game.playerObj.movie._y;
                    if (_local_11 < 70) {
                        if (_local_3 > (_local_8 - 51)) {
                            if (_local_3 < (_local_8 + 51)) {
                                if (_local_2 > (_local_7 - 41)) {
                                    if (_local_2 < (_local_7 + 41)) {
                                        _local_9 = true;
                                    }
                                }
                            }
                        }
                    }
                    if (_local_9 == true) {
                        var _local_10 = false;
                        _local_3 = game.playerObj.halfPosX;
                        _local_2 = game.playerObj.halfPosY;
                        if (_local_11 < 70) {
                            if (_local_3 > (_local_8 - 51)) {
                                if (_local_3 < (_local_8 + 51)) {
                                    if (_local_2 > (_local_7 - 41)) {
                                        if (_local_2 < (_local_7 + 41)) {
                                            _local_10 = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (_local_9 == true) {
                        if (_local_10 == true) {
                            _local_3 = game.playerObj.halfPosX;
                            _local_2 = game.playerObj.halfPosY;
                        } else {
                            _local_3 = game.playerObj.movie._x;
                            _local_2 = game.playerObj.movie._y;
                        }
                        var _local_12 = com.clubpenguin["math"].AaronsPhysics.findAngle(_local_3, _local_2, movie._x, movie._y);
                        var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_12, 20);
                        var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_12, 20);
                        motionX = motionX + (_local_5 / 2);
                        motionY = motionY + (_local_4 / 2);
                        if (Math.abs(_local_5) > Math.abs(_local_4)) {
                            _local_5 = _local_5 * 1.5;
                            _local_4 = _local_4 * 0.5;
                        } else {
                            _local_5 = _local_5 * 0.5;
                            _local_4 * 2;
                        }
                        game.playerObj.motionX = _local_5 * -0.7;
                        game.playerObj.motionY = _local_4 * -1.3;
                        game.playerObj.motionR = Math.abs(_local_5) + Math.abs(_local_4);
                        shatter();
                    }
                }
            }
            if (movie._x > (groundX + 1)) {
                motionX = motionX - ((Math.abs(movie._x - groundX) * elasticMultiplier) * _arg_6);
            } else if (movie._x < (groundX - 1)) {
                motionX = motionX + ((Math.abs(movie._x - groundX) * elasticMultiplier) * _arg_6);
            }
            if (movie._y > (groundY + 1)) {
                motionY = motionY - ((Math.abs(movie._y - groundY) * elasticMultiplier) * _arg_6);
            } else if (movie._y < (groundY - 1)) {
                motionY = motionY + ((Math.abs(movie._y - groundY) * elasticMultiplier) * _arg_6);
            }
            motionX = motionX * (1 - (0.3 * _arg_6));
            motionY = motionY * (1 - (0.3 * _arg_6));
            movie._x = movie._x + (motionX * _arg_6);
            movie._y = movie._y + (motionY * _arg_6);
        }
        function shatter() {
            breakN = 4;
            movie.art.gotoAndStop("break0still");
            movie.art.gotoAndStop("break" + breakN);
            waitN = waitN + 1;
        }
        function reappear() {
            movie.art.gotoAndStop("break" + breakN);
        }
    }
