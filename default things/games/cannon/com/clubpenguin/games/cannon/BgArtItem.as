//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.BgArtItem
    {
        var game, gameplayWorld, gameplayHolder, grabbed, offsetX, offsetY, bgArtHolder, idNumber, settingN, movie, sizeX, sizeY, hidden;
        function BgArtItem (_arg_9, _arg_3, _arg_7, _arg_4, _arg_2, _arg_6, _arg_5, _arg_8) {
            game = _arg_9;
            gameplayWorld = _arg_3;
            gameplayHolder = _arg_7;
            grabbed = false;
            offsetX = 0;
            offsetY = 0;
            bgArtHolder = _arg_4;
            idNumber = _arg_2;
            settingN = _arg_8;
            movie = bgArtHolder.attachMovie("bgArt", "Obj" + _arg_2, _arg_2);
            movie._x = _arg_6;
            movie._y = _arg_5;
            movie.cacheAsBitmap = true;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
            if (settingN == 51) {
                sizeX = 100000 /* 0x0186A0 */;
                sizeY = 100000 /* 0x0186A0 */;
            }
        }
        function updateEditor() {
            movie.gotoAndStop(settingN);
            if (grabbed == true) {
                if (game.brushObj.getGrabMode() == "drag") {
                    movie._x = gameplayHolder._xmouse + offsetX;
                    movie._y = gameplayHolder._ymouse + offsetY;
                    movie._x = Math.round(movie._x / 10) * 10;
                    movie._y = Math.round(movie._y / 10) * 10;
                }
            }
        }
        function updateGameplay() {
            var _local_2 = false;
            if ((movie._x + sizeX) > ((-gameplayHolder._x) - gameplayWorld._x)) {
                if ((movie._x - sizeX) < (((-gameplayHolder._x) - gameplayWorld._x) + 760)) {
                    if ((movie._y + sizeY) > ((-gameplayHolder._y) - gameplayWorld._y)) {
                        if ((movie._y - sizeY) < (((-gameplayHolder._y) - gameplayWorld._y) + 480)) {
                            _local_2 = true;
                        }
                    }
                }
            }
            if (_local_2 == true) {
                if (hidden == true) {
                    movie.gotoAndStop(settingN);
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
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
                            game.removeObject(this, game.level1bgArtArray);
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
