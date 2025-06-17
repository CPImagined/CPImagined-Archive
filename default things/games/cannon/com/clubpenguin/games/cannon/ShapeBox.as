//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.ShapeBox extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX, movie, groundY, motionX, motionY, elasticMultiplier, elasticMultiplierDefault, settingN, sizeX, sizeY, hidden, shape, waitN, gameplayWorld, gameplayHolder, game;
        function ShapeBox (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            groundX = movie._x;
            groundY = movie._y;
            motionX = 0;
            motionY = 0;
            elasticMultiplier = 0.35;
            elasticMultiplierDefault = 0.35;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height + 700;
            movie.gotoAndStop("hide");
            hidden = true;
            shape = "square";
            movie.master = this;
            waitN = 0;
        }
        function updateGameplay(_arg_4) {
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
                    movie.art.gotoAndStop(shape + "still");
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            if (waitN > 0) {
                waitN--;
            } else if (game.playerObj.inCannon == false) {
                var _local_5 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                var _local_7 = false;
                var _local_9 = movie._x;
                var _local_8 = movie._y;
                var _local_3 = game.playerObj.movie._x;
                var _local_2 = game.playerObj.movie._y;
                if (shape == "triangle") {
                    if (_local_5 < 60) {
                        var _local_19 = movie._x;
                        var _local_17 = movie._y - 47;
                        var _local_18 = movie._x + 52;
                        var _local_15 = movie._y + 47;
                        var _local_16 = movie._x - 52;
                        var _local_14 = movie._y + 47;
                        if (triangleCollision(_local_3, _local_2, _local_19, _local_17, _local_18, _local_15, _local_16, _local_14)) {
                            _local_7 = true;
                        }
                    }
                }
                if (shape == "square") {
                    if (_local_5 < 60) {
                        if (_local_3 > (_local_9 - 46)) {
                            if (_local_3 < (_local_9 + 46)) {
                                if (_local_2 > (_local_8 - 36)) {
                                    if (_local_2 < (_local_8 + 36)) {
                                        _local_7 = true;
                                    }
                                }
                            }
                        }
                    }
                }
                if (shape == "circle") {
                    if (_local_5 < 54) {
                        _local_7 = true;
                    }
                }
                if (_local_7 == true) {
                    var _local_10 = false;
                    _local_3 = game.playerObj.halfPosX;
                    _local_2 = game.playerObj.halfPosY;
                    if (shape == "triangle") {
                        if (_local_5 < 60) {
                            var _local_19 = movie._x;
                            var _local_17 = movie._y - 47;
                            var _local_18 = movie._x + 52;
                            var _local_15 = movie._y + 47;
                            var _local_16 = movie._x - 52;
                            var _local_14 = movie._y + 47;
                            if (triangleCollision(_local_3, _local_2, _local_19, _local_17, _local_18, _local_15, _local_16, _local_14)) {
                                _local_10 = true;
                            }
                        }
                    }
                    if (shape == "square") {
                        if (_local_5 < 60) {
                            if (_local_3 > (_local_9 - 46)) {
                                if (_local_3 < (_local_9 + 46)) {
                                    if (_local_2 > (_local_8 - 36)) {
                                        if (_local_2 < (_local_8 + 36)) {
                                            _local_10 = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (shape == "circle") {
                        if (_local_5 < 54) {
                            _local_10 = true;
                        }
                    }
                }
                if (_local_7 == true) {
                    if (_local_10 == true) {
                        _local_3 = game.playerObj.halfPosX;
                        _local_2 = game.playerObj.halfPosY;
                    } else {
                        _local_3 = game.playerObj.movie._x;
                        _local_2 = game.playerObj.movie._y;
                    }
                    var _local_6 = com.clubpenguin["math"].AaronsPhysics.findAngle(_local_3, _local_2, movie._x, movie._y);
                    if (shape == "square") {
                        var _local_12 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_6, 20);
                        var _local_11 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_6, 20);
                        motionX = motionX + _local_12;
                        motionY = motionY + _local_11;
                        game.playerObj.motionX = _local_12 * -0.7;
                        game.playerObj.motionY = _local_11 * -1.3;
                        game.playerObj.motionR = Math.abs(_local_12) + Math.abs(_local_11);
                        shape = "circle";
                    } else if (shape == "circle") {
                        var _local_12 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_6, 50);
                        var _local_11 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_6, 50);
                        motionX = motionX + _local_12;
                        motionY = motionY + _local_11;
                        game.playerObj.motionX = _local_12 * -0.5;
                        game.playerObj.motionY = _local_11 * -0.5;
                        game.playerObj.motionR = Math.abs(_local_12) + Math.abs(_local_11);
                        shape = "triangle";
                    } else if (shape == "triangle") {
                        var _local_12 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_6, 50);
                        var _local_11 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_6, 50);
                        motionX = motionX + _local_12;
                        motionY = motionY + _local_11;
                        game.playerObj.motionX = _local_12 * -0.8;
                        game.playerObj.motionY = _local_11 * -0.8;
                        game.playerObj.motionR = Math.abs(_local_12) + Math.abs(_local_11);
                        shape = "square";
                    }
                    movie.art.gotoAndStop(shape + "still");
                    movie.art.gotoAndStop(shape + "morph");
                    waitN = waitN + 3;
                }
            }
            if (movie._x > (groundX + 1)) {
                motionX = motionX - ((Math.abs(movie._x - groundX) * elasticMultiplier) * _arg_4);
            } else if (movie._x < (groundX - 1)) {
                motionX = motionX + ((Math.abs(movie._x - groundX) * elasticMultiplier) * _arg_4);
            }
            if (movie._y > (groundY + 1)) {
                motionY = motionY - ((Math.abs(movie._y - groundY) * elasticMultiplier) * _arg_4);
            } else if (movie._y < (groundY - 1)) {
                motionY = motionY + ((Math.abs(movie._y - groundY) * elasticMultiplier) * _arg_4);
            }
            motionX = motionX * (1 - (0.2 * _arg_4));
            motionY = motionY * (1 - (0.2 * _arg_4));
            movie._x = movie._x + (motionX * _arg_4);
            movie._y = movie._y + (motionY * _arg_4);
        }
        function triangleCollision(_arg_6, _arg_5, _arg_12, _arg_10, _arg_11, _arg_8, _arg_9, _arg_7) {
            var _local_4 = lineSide(_arg_12, _arg_10, _arg_11, _arg_8, _arg_6, _arg_5);
            var _local_2 = lineSide(_arg_11, _arg_8, _arg_9, _arg_7, _arg_6, _arg_5);
            var _local_3 = lineSide(_arg_9, _arg_7, _arg_12, _arg_10, _arg_6, _arg_5);
            if ((_local_4 == _local_2) && (_local_2 == _local_3)) {
                return(true);
            }
            return(false);
        }
        function lineSide(_arg_3, _arg_2, _arg_7, _arg_6, _arg_5, _arg_4) {
            var _local_1 = ((_arg_7 - _arg_3) * (_arg_4 - _arg_2)) - ((_arg_5 - _arg_3) * (_arg_6 - _arg_2));
            if (_local_1 > 0) {
                return("right");
            }
            if (_local_1 < 0) {
                return("left");
            }
            return("mid");
        }
    }
