//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.PoofyCloud extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX, movie, groundY, dissipated, settingN, sizeX, sizeY, hidden, gameplayWorld, gameplayHolder, game;
        function PoofyCloud (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            groundX = movie._x;
            groundY = movie._y;
            dissipated = false;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
        }
        function updateGameplay($speedMod) {
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
                if (dissipated == false) {
                    if (hidden == true) {
                        movie.gotoAndStop(settingN);
                        movie.art.gotoAndStop("gameplay");
                        hidden = false;
                    }
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            if (game.playerObj.inCannon == false) {
                var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                if (_local_3 < 90) {
                    movie.art.art.master = this;
                    movie.art.art.gotoAndStop("poof");
                    dissipated = true;
                }
            }
        }
        function destroy() {
            movie.removeMovieClip();
        }
    }
