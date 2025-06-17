//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.FallZone
    {
        var grabbed, game, skyN, movie, offsetY;
        function FallZone (_arg_5, _arg_2, _arg_4, _arg_3) {
            grabbed = false;
            game = _arg_5;
            skyN = _arg_4;
            movie = game.gameplayHolder.fallZoneHolder.attachMovie("fallZone", "fallZone", _arg_3);
            movie._y = _arg_2;
            if ((_arg_2 * 0) != 0) {
                movie._y = 0;
            }
            offsetY = 0;
            movie.gotoAndStop(game.gameMode);
            movie.art.gotoAndStop(skyN);
        }
        function updateEditor() {
            if (grabbed == true) {
                if (game.brushObj.getGrabMode() == "drag") {
                    movie._y = game.gameplayHolder._ymouse + offsetY;
                    movie._y = Math.round(movie._y / 10) * 10;
                }
            }
        }
        function updateGameplay($speedMod) {
            game.gameplayHolder.fallZoneHolder._x = game.gameplayHolder._x * -1;
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
        function destroy() {
            movie.removeMovieClip();
        }
    }
