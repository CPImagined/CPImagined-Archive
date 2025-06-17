//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.FireBox extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX, movie, groundY, motionX, motionY, settingN, timehpDefault, timehp, state, alive, floatX, game;
        function FireBox (_arg_15, _arg_9, _arg_13, _arg_8, _arg_10, _arg_12, _arg_11, _arg_4, _arg_14, _arg_7, _arg_5, _arg_3, _arg_6) {
            super(_arg_15, _arg_9, _arg_13, _arg_8, _arg_10, _arg_12, _arg_11, _arg_4, _arg_14);
            groundX = movie._x;
            groundY = movie._y;
            motionX = _arg_7;
            motionY = _arg_5;
            if ((motionX * 0) != 0) {
                motionX = 0;
                motionY = 0;
            }
            movie.gotoAndStop(settingN);
            movie.art.gotoAndStop("appear");
            movie.master = this;
            timehpDefault = _arg_3;
            timehp = _arg_3;
            state = "still1";
            alive = true;
            floatX = _arg_6;
        }
        function updateGameplay(_arg_10) {
            if (game.playerObj.inCannon == false) {
                if (alive == true) {
                    var _local_12 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                    var _local_8 = false;
                    var _local_7 = movie._x;
                    var _local_6 = movie._y;
                    var _local_5 = game.playerObj.movie._x;
                    var _local_4 = game.playerObj.movie._y;
                    if (_local_12 < 60) {
                        if (_local_5 > (_local_7 - 46)) {
                            if (_local_5 < (_local_7 + 46)) {
                                if (_local_4 > (_local_6 - 36)) {
                                    if (_local_4 < (_local_6 + 36)) {
                                        _local_8 = true;
                                    }
                                }
                            }
                        }
                    }
                    if (_local_8 == true) {
                        var _local_11 = false;
                        _local_5 = game.playerObj.halfPosX;
                        _local_4 = game.playerObj.halfPosY;
                        if (_local_12 < 60) {
                            if (_local_5 > (_local_7 - 46)) {
                                if (_local_5 < (_local_7 + 46)) {
                                    if (_local_4 > (_local_6 - 36)) {
                                        if (_local_4 < (_local_6 + 36)) {
                                            _local_11 = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (_local_8 == true) {
                        if (_local_11 == true) {
                            _local_5 = game.playerObj.halfPosX;
                            _local_4 = game.playerObj.halfPosY;
                        } else {
                            _local_5 = game.playerObj.movie._x;
                            _local_4 = game.playerObj.movie._y;
                        }
                        var _local_9 = com.clubpenguin["math"].AaronsPhysics.findAngle(_local_5, _local_4, movie._x, movie._y);
                        var _local_3 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_9, 20);
                        var _local_2 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_9, 20);
                        motionX = motionX + (_local_3 * 3);
                        motionY = motionY + (_local_2 * 3);
                        if (timehpDefault == 48) {
                            if (state == "still3") {
                                game.playerObj.motionX = _local_3 * -0.7;
                                game.playerObj.motionY = _local_2 * -1.3;
                                game.playerObj.motionR = Math.abs(_local_3) + Math.abs(_local_2);
                                game.playerObj.motionR = game.playerObj.motionR + 30;
                            } else if (state == "still2") {
                                game.playerObj.motionX = _local_3 * -0.9;
                                game.playerObj.motionY = _local_2 * -1.7;
                                game.playerObj.motionR = Math.abs(_local_3) + Math.abs(_local_2);
                                game.playerObj.motionR = game.playerObj.motionR + 30;
                            } else if (state == "still1") {
                                game.playerObj.motionX = _local_3 * -1.1;
                                game.playerObj.motionY = _local_2 * -2;
                                game.playerObj.motionR = Math.abs(_local_3) + Math.abs(_local_2);
                                game.playerObj.motionR = game.playerObj.motionR + 30;
                            }
                        } else {
                            game.playerObj.motionX = _local_3 * -1.1;
                            game.playerObj.motionY = _local_2 * -2;
                            game.playerObj.motionR = Math.abs(_local_3) + Math.abs(_local_2);
                            game.playerObj.motionR = game.playerObj.motionR + 30;
                        }
                        if (game.playerObj.motionX < 0) {
                            game.playerObj.motionX = game.playerObj.motionX * 0.5;
                        }
                        movie._rotation = _local_9 - 90;
                        movie.art.gotoAndStop("still");
                        movie.art.gotoAndStop("explode");
                        state = "explode";
                        alive = false;
                    }
                }
            }
            if (timehp > 0) {
                timehp--;
            } else {
                if (state == "still1") {
                    state = "still2";
                    game.fireboxNewest = this;
                } else if (state == "still2") {
                    state = "still3";
                } else if (state == "still3") {
                    state = "expire";
                    alive = false;
                }
                movie.art.gotoAndStop(state);
                timehp = timehpDefault;
            }
            motionY = motionY - 0.2;
            motionX = motionX - floatX;
            motionX = motionX * (1 - (0.02 * _arg_10));
            motionY = motionY * (1 - (0.02 * _arg_10));
            movie._x = movie._x + (motionX * _arg_10);
            movie._y = movie._y + (motionY * _arg_10);
            if (state == "expire") {
                var _local_12 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                if (_local_12 < 160) {
                    game.playerObj.motionY = -30;
                    game.playerObj.motionR = 60;
                }
            }
        }
        function destroy() {
            movie.removeMovieClip();
        }
    }
