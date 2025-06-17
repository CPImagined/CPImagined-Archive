//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.Cactus extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var movie, settingN, sizeX, sizeY, hidden, gameplayWorld, gameplayHolder, game;
        function Cactus (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
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
            var _local_6 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
            if (game.playerObj.inCannon == false) {
                _local_6 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                if (_local_6 < 50) {
                    movie.art.gotoAndStop("bump");
                    var _local_2 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                    var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_2, 50);
                    var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_2, 50);
                    game.playerObj.motionX = _local_5 * 0.8;
                    game.playerObj.motionY = _local_4 * 0.8;
                }
            }
        }
    }
