//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.Piano extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var movie, settingN, sizeX, sizeY, hidden, groundY, holdsTotal, currentHold, hold1, hold2, waitDefault, wait, groundX, gameplayWorld, gameplayHolder, game;
        function Piano (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
            if (settingN == 4) {
                groundY = movie._y;
                holdsTotal = 2;
                currentHold = 2;
                hold1 = groundY + 240;
                hold2 = groundY;
                waitDefault = 10;
                wait = 0;
            }
            if (settingN == 5) {
                groundX = movie._x;
                holdsTotal = 2;
                currentHold = 2;
                hold1 = groundX + 240;
                hold2 = groundX;
                waitDefault = 10;
                wait = 0;
            }
            if (settingN == 6) {
                groundY = movie._y;
                holdsTotal = 2;
                currentHold = 1;
                hold1 = groundY - 240;
                hold2 = groundY;
                waitDefault = 10;
                wait = 0;
            }
        }
        function updateGameplay() {
            var _local_3 = false;
            if ((movie._x + sizeX) > ((-gameplayHolder._x) - gameplayWorld._x)) {
                if ((movie._x - sizeX) < (((-gameplayHolder._x) - gameplayWorld._x) + 760)) {
                    if ((movie._y + sizeY) > ((-gameplayHolder._y) - gameplayWorld._y)) {
                        if ((movie._y - sizeY) < (((-gameplayHolder._y) - gameplayWorld._y) + 480)) {
                            _local_3 = true;
                        }
                    }
                }
            }
            if (_local_3 == true) {
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
                if (_local_6 < 90) {
                    movie.art.gotoAndStop("slam");
                    var _local_2 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                    var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_2, 50);
                    var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_2, 50);
                    game.playerObj.motionX = _local_5 * 0.8;
                    game.playerObj.motionY = _local_4 * 0.8;
                }
            }
            if ((settingN == 4) || (settingN == 6)) {
                if (wait > 0) {
                    wait--;
                } else if (int(movie._y) == int(this["hold" + currentHold])) {
                    wait = waitDefault;
                    if (currentHold < holdsTotal) {
                        currentHold++;
                    } else {
                        currentHold = 1;
                    }
                } else if (movie._y < this["hold" + currentHold]) {
                    movie._y = movie._y + 5;
                } else if (movie._y > this["hold" + currentHold]) {
                    movie._y = movie._y - 5;
                }
            }
            if (settingN == 5) {
                if (wait > 0) {
                    wait--;
                } else if (int(movie._x) == int(this["hold" + currentHold])) {
                    wait = waitDefault;
                    if (currentHold < holdsTotal) {
                        currentHold++;
                    } else {
                        currentHold = 1;
                    }
                } else if (movie._x < this["hold" + currentHold]) {
                    movie._x = movie._x + 5;
                } else if (movie._x > this["hold" + currentHold]) {
                    movie._x = movie._x - 5;
                }
            }
        }
    }
