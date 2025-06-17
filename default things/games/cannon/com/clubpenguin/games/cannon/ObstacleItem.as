//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.ObstacleItem
    {
        var game, gameplayWorld, gameplayHolder, grabbed, offsetX, offsetY, obstacleHolder, idNumber, settingN, movie;
        function ObstacleItem (_arg_10, _arg_6, _arg_9, _arg_5, _arg_2, _arg_8, _arg_7, _arg_4, _arg_3) {
            game = _arg_10;
            gameplayWorld = _arg_6;
            gameplayHolder = _arg_9;
            grabbed = false;
            offsetX = 0;
            offsetY = 0;
            obstacleHolder = _arg_5;
            idNumber = _arg_2;
            settingN = _arg_3;
            movie = obstacleHolder.attachMovie("obstacle", "Obj" + _arg_2, _arg_2);
            movie._x = _arg_8;
            movie._y = _arg_7;
            movie._rotation = _arg_4;
            movie.gotoAndStop(_arg_3);
        }
        function updateEditor() {
            movie.hint.gotoAndStop("show");
            if (grabbed == true) {
                if (game.brushObj.getGrabMode() == "drag") {
                    movie._x = gameplayHolder._xmouse + offsetX;
                    movie._y = gameplayHolder._ymouse + offsetY;
                    movie._x = Math.round(movie._x / 10) * 10;
                    movie._y = Math.round(movie._y / 10) * 10;
                } else if (game.brushObj.getGrabMode() == "rotate") {
                    if (settingN == 30) {
                        var _local_2 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie._x, movie._y, gameplayHolder._xmouse, gameplayHolder._ymouse);
                        movie._rotation = _local_2;
                        movie.hint._rotation = -_local_2;
                    }
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
                            game.removeObject(this, game.level1obstacleArray);
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
