//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.Asteroid extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var idNumber, motionX, motionY, motionR, groundX, groundY, movie, settingN, sizeX, sizeY, hidden, variantN, shrinking, collidable, gameplayWorld, gameplayHolder, game;
        function Asteroid (_arg_11, _arg_8, _arg_9, _arg_7, _arg_3, _arg_5, _arg_4, _arg_6, _arg_10) {
            super(_arg_11, _arg_8, _arg_9, _arg_7, _arg_3, _arg_5, _arg_4, _arg_6, _arg_10);
            idNumber = _arg_3;
            motionX = 0;
            motionY = 0;
            motionR = 0;
            groundX = _arg_5;
            groundY = _arg_4;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
            variantN = random(3) + 1;
            movie.art.art.gotoAndStop(variantN);
            shrinking = false;
            collidable = true;
        }
        function updateGameplay(_arg_2) {
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
                if (hidden == true) {
                    movie.gotoAndStop(settingN);
                    movie.art.art.gotoAndStop(variantN);
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            var _local_7 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
            if (game.playerObj.inCannon == false) {
                if (collidable == true) {
                    _local_7 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                    if (_local_7 < 50) {
                        movie.art.gotoAndStop("bump");
                        movie.art.art.art.gotoAndStop(variantN);
                        game.forceSlowMode = false;
                        var _local_5 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                        var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_5, 50);
                        var _local_3 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_5, 50);
                        game.playerObj.motionX = _local_4 * 0.8;
                        game.playerObj.motionY = _local_3 * 0.8;
                        motionX = motionX - (_local_4 / 4);
                        motionY = motionY - (_local_3 / 4);
                    }
                }
            }
            if (movie._x > (groundX + 1)) {
                motionX = motionX - ((Math.abs(movie._x - groundX) * 0.001) * _arg_2);
            } else if (movie._x < (groundX - 1)) {
                motionX = motionX + ((Math.abs(movie._x - groundX) * 0.001) * _arg_2);
            }
            if (movie._y > (groundY + 1)) {
                motionY = motionY - ((Math.abs(movie._y - groundY) * 0.001) * _arg_2);
            } else if (movie._y < (groundY - 1)) {
                motionY = motionY + ((Math.abs(movie._y - groundY) * 0.001) * _arg_2);
            }
            if (shrinking == true) {
                motionR = motionR + 4;
                movie._xscale = movie._xscale * 0.9;
                movie._yscale = movie._yscale * 0.9;
                if (movie._xscale < 1) {
                    removeMovieClip(movie);
                }
            }
            motionX = motionX * (1 - (0.1 * _arg_2));
            motionY = motionY * (1 - (0.1 * _arg_2));
            motionR = motionR * (1 - (0.1 * _arg_2));
            movie._x = movie._x + (motionX * _arg_2);
            movie._y = movie._y + (motionY * _arg_2);
            movie._rotation = movie._rotation + motionR;
        }
    }
