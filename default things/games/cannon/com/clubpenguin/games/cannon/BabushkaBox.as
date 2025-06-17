//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.BabushkaBox extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX1, groundY1, groundX2, groundY2, groundX3, groundY3, groundX4, groundY4, groundX5, groundY5, motionX1, motionY1, motionX2, motionY2, motionX3, motionY3, motionX4, motionY4, motionX5, motionY5, elasticMultiplier, elasticMultiplierDefault, movie, settingN, sizeX, sizeY, hidden, waitN, b1Hittable, b2Hittable, b3Hittable, b4Hittable, b5Hittable, game, gameplayWorld, gameplayHolder;
        function BabushkaBox (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            groundX1 = 0;
            groundY1 = 0;
            groundX2 = 150;
            groundY2 = 0;
            groundX3 = 300;
            groundY3 = 0;
            groundX4 = 450;
            groundY4 = 0;
            groundX5 = 600;
            groundY5 = 0;
            motionX1 = 0;
            motionY1 = 0;
            motionX2 = 0;
            motionY2 = 0;
            motionX3 = 0;
            motionY3 = 0;
            motionX4 = 0;
            motionY4 = 0;
            motionX5 = 0;
            motionY5 = 0;
            elasticMultiplier = 0.95;
            elasticMultiplierDefault = 0.95;
            movie.gotoAndStop(settingN);
            sizeX = movie._width + 700;
            sizeY = movie._height + 700;
            movie.gotoAndStop("hide");
            hidden = true;
            movie.master = this;
            waitN = 0;
            b1Hittable = true;
            b2Hittable = false;
            b3Hittable = false;
            b4Hittable = false;
            b5Hittable = false;
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
                    if (b2Hittable == true) {
                        movie.art.art.b2.gotoAndStop("still");
                    }
                    if (b3Hittable == true) {
                        movie.art.art.b3.gotoAndStop("still");
                    }
                    if (b4Hittable == true) {
                        movie.art.art.b4.gotoAndStop("still");
                    }
                    if (b5Hittable == true) {
                        movie.art.art.b5.gotoAndStop("still");
                    }
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            if (waitN > 0) {
                waitN--;
            } else if (game.playerObj.inCannon == false) {
                var _local_2 = 1;
                while (_local_2 <= 5) {
                    if (this[("b" + _local_2) + "Hittable"] == true) {
                        detectPlayer(_local_2);
                    }
                    _local_2++;
                }
            }
            var _local_2 = 1;
            while (_local_2 <= 5) {
                updatePos(_local_2, _arg_3);
                _local_2++;
            }
        }
        function detectPlayer(_arg_2) {
            var _local_14 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x + movie.art.art["b" + _arg_2]._x, movie._y + movie.art.art["b" + _arg_2]._y, game.playerObj.movie._x, game.playerObj.movie._y);
            var _local_11 = false;
            var _local_10 = movie._x + movie.art.art["b" + _arg_2]._x;
            var _local_9 = movie._y + movie.art.art["b" + _arg_2]._y;
            var _local_4 = game.playerObj.movie._x;
            var _local_3 = game.playerObj.movie._y;
            var _local_12 = 100;
            if (_arg_2 == 1) {
                var _local_6 = 59;
                var _local_5 = 48;
            } else if (_arg_2 == 2) {
                var _local_6 = 50;
                var _local_5 = 41;
            } else if (_arg_2 == 3) {
                var _local_6 = 41;
                var _local_5 = 34;
            } else if (_arg_2 == 4) {
                var _local_6 = 33;
                var _local_5 = 28;
            } else if (_arg_2 == 5) {
                var _local_6 = 24;
                var _local_5 = 22;
            }
            if (_local_14 < _local_12) {
                if (_local_4 > (_local_10 - _local_6)) {
                    if (_local_4 < (_local_10 + _local_6)) {
                        if (_local_3 > (_local_9 - _local_5)) {
                            if (_local_3 < (_local_9 + _local_5)) {
                                _local_11 = true;
                            }
                        }
                    }
                }
            }
            if (_local_11 == true) {
                var _local_13 = false;
                _local_4 = game.playerObj.halfPosX;
                _local_3 = game.playerObj.halfPosY;
                if (_local_14 < _local_12) {
                    if (_local_4 > (_local_10 - _local_6)) {
                        if (_local_4 < (_local_10 + _local_6)) {
                            if (_local_3 > (_local_9 - _local_5)) {
                                if (_local_3 < (_local_9 + _local_5)) {
                                    _local_13 = true;
                                }
                            }
                        }
                    }
                }
            }
            if (_local_11 == true) {
                if (_local_13 == true) {
                    _local_4 = game.playerObj.halfPosX;
                    _local_3 = game.playerObj.halfPosY;
                } else {
                    _local_4 = game.playerObj.movie._x;
                    _local_3 = game.playerObj.movie._y;
                }
                var _local_15 = com.clubpenguin["math"].AaronsPhysics.findAngle(_local_4, _local_3, movie._x + movie.art.art["b" + _arg_2]._x, movie._y + movie.art.art["b" + _arg_2]._y);
                var _local_8 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_15, 20);
                var _local_7 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_15, 20);
                this["motionX" + _arg_2] = this["motionX" + _arg_2] + (_local_8 / 2);
                this["motionY" + _arg_2] = this["motionY" + _arg_2] + (_local_7 / 2);
                if (Math.abs(_local_8) > Math.abs(_local_7)) {
                    _local_8 = _local_8 * 1.5;
                    _local_7 = _local_7 * 0.5;
                } else {
                    _local_8 = _local_8 * 0.5;
                    _local_7 * 2;
                }
                game.playerObj.motionX = _local_8 * -0.7;
                game.playerObj.motionY = _local_7 * -1;
                game.playerObj.motionR = Math.abs(_local_8) + Math.abs(_local_7);
                movie.art.art["b" + _arg_2].gotoAndStop("bump");
                if (this[("b" + (_arg_2 + 1)) + "Hittable"] == false) {
                    this[("b" + (_arg_2 + 1)) + "Hittable"] = true;
                    movie.art.art["b" + (_arg_2 + 1)].gotoAndStop("appear");
                } else if (this[("b" + (_arg_2 + 1)) + "Hittable"] == true) {
                    this[("b" + (_arg_2 + 1)) + "Hittable"] = false;
                    movie.art.art["b" + (_arg_2 + 1)].gotoAndStop("remove");
                } else if (_arg_2 == 5) {
                    this[("b" + _arg_2) + "Hittable"] = false;
                    movie.art.art["b" + _arg_2].gotoAndStop("dissipate");
                }
                waitN = waitN + 1;
            }
        }
        function chainReaction(_arg_2) {
            if (this[("b" + _arg_2) + "Hittable"] == true) {
                this[("b" + _arg_2) + "Hittable"] = false;
                movie.art.art["b" + _arg_2].gotoAndStop("dissipate");
            }
        }
        function updatePos(_arg_2, _arg_3) {
            if (movie.art.art["b" + _arg_2]._x > (this["groundX" + _arg_2] + 1)) {
                this["motionX" + _arg_2] = this["motionX" + _arg_2] - ((Math.abs(movie.art.art["b" + _arg_2]._x - this["groundX" + _arg_2]) * elasticMultiplier) * _arg_3);
            } else if (movie.art.art["b" + _arg_2]._x < (this["groundX" + _arg_2] - 1)) {
                this["motionX" + _arg_2] = this["motionX" + _arg_2] + ((Math.abs(movie.art.art["b" + _arg_2]._x - this["groundX" + _arg_2]) * elasticMultiplier) * _arg_3);
            }
            if (movie.art.art["b" + _arg_2]._y > (this["groundY" + _arg_2] + 1)) {
                this["motionY" + _arg_2] = this["motionY" + _arg_2] - ((Math.abs(movie.art.art["b" + _arg_2]._y - this["groundY" + _arg_2]) * elasticMultiplier) * _arg_3);
            } else if (movie.art.art["b" + _arg_2]._y < (this["groundY" + _arg_2] - 1)) {
                this["motionY" + _arg_2] = this["motionY" + _arg_2] + ((Math.abs(movie.art.art["b" + _arg_2]._y - this["groundY" + _arg_2]) * elasticMultiplier) * _arg_3);
            }
            this["motionX" + _arg_2] = this["motionX" + _arg_2] * (1 - (0.3 * _arg_3));
            this["motionY" + _arg_2] = this["motionY" + _arg_2] * (1 - (0.3 * _arg_3));
            movie.art.art["b" + _arg_2]._x = movie.art.art["b" + _arg_2]._x + (this["motionX" + _arg_2] * _arg_3);
            movie.art.art["b" + _arg_2]._y = movie.art.art["b" + _arg_2]._y + (this["motionY" + _arg_2] * _arg_3);
        }
    }
