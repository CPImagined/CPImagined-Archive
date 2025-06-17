//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.StartIcon
    {
        var grabbed, game, iconHolder, movie, offsetX, offsetY;
        function StartIcon (_arg_5, _arg_4, _arg_3, _arg_2) {
            grabbed = false;
            game = _arg_5;
            iconHolder = _arg_4;
            movie = iconHolder.attachMovie("iconstart", "iconstart", 1);
            movie._x = _arg_3;
            movie._y = _arg_2;
            if ((_arg_3 * 0) != 0) {
                movie._x = 0;
            }
            if ((_arg_2 * 0) != 0) {
                movie._y = 0;
            }
            offsetX = 0;
            offsetY = 0;
        }
        function update() {
            if (grabbed == true) {
                if (game.brushObj.getGrabMode() == "drag") {
                    movie._x = game.gameplayHolder._xmouse + offsetX;
                    movie._y = game.gameplayHolder._ymouse + offsetY;
                    movie._x = Math.round(movie._x / 10) * 10;
                    movie._y = Math.round(movie._y / 10) * 10;
                }
            }
        }
        function hidden() {
            movie._visible = false;
        }
        function mouseClick() {
            if (game.brushObj.grabValid()) {
                if (movie.hitTest(_xmouse, _ymouse, true)) {
                    if (game.brushObj.getSettingN() == 0) {
                        if (game.brushObj.getGrabMode() == "drag") {
                            if (game.brushObj.getGrabbing() == false) {
                                game.brushObj.setGrabbing(true);
                                grabbed = true;
                                if (movie._x > game.gameplayHolder._xmouse) {
                                    offsetX = movie._x - game.gameplayHolder._xmouse;
                                } else if (movie._x < game.gameplayHolder._xmouse) {
                                    offsetX = (game.gameplayHolder._xmouse - movie._x) * -1;
                                } else {
                                    offsetX = 0;
                                }
                                if (movie._y > game.gameplayHolder._ymouse) {
                                    offsetY = movie._y - game.gameplayHolder._ymouse;
                                } else if (movie._y < game.gameplayHolder._ymouse) {
                                    offsetY = (game.gameplayHolder._ymouse - movie._y) * -1;
                                } else {
                                    offsetY = 0;
                                }
                            }
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
