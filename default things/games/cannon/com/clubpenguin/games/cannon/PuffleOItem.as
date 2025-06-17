//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.PuffleOItem
    {
        var game, gameplayWorld, gameplayHolder, grabbed, offsetX, offsetY, puffleOHolder, idNumber, settingN, movie, groundX, groundY, collected, motionX, motionY, sizeX, sizeY, hidden, donePoofing;
        function PuffleOItem (_arg_9, _arg_5, _arg_7, _arg_6, _arg_2, _arg_4, _arg_3, _arg_8) {
            game = _arg_9;
            gameplayWorld = _arg_5;
            gameplayHolder = _arg_7;
            grabbed = false;
            offsetX = 0;
            offsetY = 0;
            puffleOHolder = _arg_6;
            idNumber = _arg_2;
            settingN = _arg_8;
            movie = puffleOHolder.attachMovie("puffleO", "Obj" + _arg_2, _arg_2);
            movie._x = _arg_4;
            movie._y = _arg_3;
            groundX = _arg_4;
            groundY = _arg_3;
            collected = false;
            motionX = 0;
            motionY = 0;
            movie.master = this;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
            donePoofing = false;
        }
        function updateEditor() {
            movie.gotoAndStop(settingN);
            if (grabbed == true) {
                if (game.brushObj.getGrabMode() == "drag") {
                    movie._x = gameplayHolder._xmouse + offsetX;
                    movie._y = gameplayHolder._ymouse + offsetY;
                    movie._x = Math.round(movie._x / 4) * 4;
                    movie._y = Math.round(movie._y / 4) * 4;
                }
            }
        }
        function updateGameplay() {
            var _local_6 = false;
            if ((movie._x + sizeX) > ((-gameplayHolder._x) - gameplayWorld._x)) {
                if ((movie._x - sizeX) < (((-gameplayHolder._x) - gameplayWorld._x) + 760)) {
                    if ((movie._y + sizeY) > ((-gameplayHolder._y) - gameplayWorld._y)) {
                        if ((movie._y - sizeY) < (((-gameplayHolder._y) - gameplayWorld._y) + 480)) {
                            _local_6 = true;
                        }
                    }
                }
            }
            if (_local_6 == true) {
                if (collected == false) {
                    if (hidden == true) {
                        movie.gotoAndStop("still");
                        hidden = false;
                    }
                } else if (donePoofing == true) {
                    if (hidden == true) {
                        movie.gotoAndStop("done");
                        hidden = false;
                    }
                }
            } else if (collected == false) {
                if (hidden == false) {
                    movie.gotoAndStop("hide");
                    hidden = true;
                }
            } else if (donePoofing == true) {
                if (hidden == false) {
                    movie.gotoAndStop("hide");
                    hidden = true;
                }
            }
            if (collected == false) {
                var _local_2 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                if (_local_2 < 40) {
                    game.collectPuffleO();
                    movie.gotoAndStop("collected");
                    collected = true;
                }
            }
            if (collected == false) {
                if (game.magnetism == true) {
                    if (game.magnet.alive == true) {
                        var _local_4 = game.magnet.movie._x + game.magnetOffsetX;
                        var _local_3 = game.magnet.movie._y + game.magnetOffsetY;
                        var _local_2 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, _local_4, _local_3);
                        if (_local_2 < 300) {
                            var _local_5 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie._x, movie._y, _local_4, _local_3);
                            var _local_8 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_5, (300 - _local_2) / 100);
                            var _local_7 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_5, (300 - _local_2) / 100);
                            motionX = motionX + _local_8;
                            motionY = motionY + _local_7;
                        }
                        motionX = motionX * 0.9;
                        motionY = motionY * 0.9;
                        movie._x = movie._x + motionX;
                        movie._y = movie._y + motionY;
                        if (_local_2 < 40) {
                            movie.gotoAndStop("collected");
                            collected = true;
                            if (game.magnet.collidable == true) {
                                game.magnet.movie.art.art.gotoAndStop(1);
                                game.magnet.movie.art.art.gotoAndStop("laugh");
                            }
                        }
                    }
                }
            }
        }
        function resetPosition() {
            movie._x = groundX;
            movie._y = groundY;
            donePoofing = true;
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
                            game.removeObject(this, game.level1puffleOArray);
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
    }
