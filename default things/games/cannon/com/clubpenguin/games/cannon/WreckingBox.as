//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.WreckingBox extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX, movie, groundY, defaultGroundY, motionX, motionY, elasticMultiplier, elasticMultiplierDefault, settingN, sizeX, sizeY, hidden, defaultSwingX, swingX, swingCountDefault, swingCount, game, gameplayWorld, gameplayHolder;
        function WreckingBox (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            groundX = movie._x;
            groundY = movie._y;
            defaultGroundY = movie._y;
            motionX = 0;
            motionY = 0;
            elasticMultiplier = 0.02;
            elasticMultiplierDefault = 0.02;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height + 700;
            movie.gotoAndStop("hide");
            hidden = true;
            movie.master = this;
            defaultSwingX = 2;
            swingX = defaultSwingX;
            swingCountDefault = 100;
            swingCount = swingCountDefault;
        }
        function updateGameplay(_arg_6) {
            if (swingCount > 0) {
                swingCount--;
            } else {
                swingCount = swingCountDefault;
                swingX = swingX * -1;
            }
            motionX = motionX + swingX;
            if (game.gravityInverted == false) {
                motionY = motionY + 2;
            } else if (game.gravityInverted == true) {
                motionY = motionY - 2;
            }
            var _local_7 = false;
            if ((movie._x + sizeX) > ((-gameplayHolder._x) - gameplayWorld._x)) {
                if ((movie._x - sizeX) < (((-gameplayHolder._x) - gameplayWorld._x) + 760)) {
                    if ((movie._y + sizeY) > ((-gameplayHolder._y) - gameplayWorld._y)) {
                        if ((movie._y - sizeY) < (((-gameplayHolder._y) - gameplayWorld._y) + 480)) {
                            _local_7 = true;
                        }
                    }
                }
            }
            if (_local_7 == true) {
                if (hidden == true) {
                    movie.gotoAndStop(settingN);
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            var _local_5 = (movie._x + movie.art._x) + movie.art.box._x;
            var _local_4 = (movie._y + movie.art._y) + movie.art.box._y;
            if (game.playerObj.inCannon == false) {
                var _local_8 = com.clubpenguin["math"].AaronsPhysics.findDistance(_local_5, _local_4, game.playerObj.movie._x, game.playerObj.movie._y);
                if (_local_8 < 56) {
                    var _local_9 = com.clubpenguin["math"].AaronsPhysics.findAngle(game.playerObj.movie._x, game.playerObj.movie._y, _local_5, _local_4);
                    var _local_3 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_9, 30);
                    var _local_2 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_9, 30);
                    motionX = motionX + (_local_3 * 2);
                    motionY = motionY + (_local_2 * 2);
                    game.playerObj.motionX = _local_3 * -1;
                    game.playerObj.motionY = _local_2 * -1;
                    game.playerObj.motionR = Math.abs(_local_3) + Math.abs(_local_2);
                }
            }
            var _local_8 = com.clubpenguin["math"].AaronsPhysics.findDistance(_local_5, _local_4, groundX, groundY);
            if (_local_8 > 1) {
                var _local_9 = com.clubpenguin["math"].AaronsPhysics.findAngle(groundX, groundY, _local_5, _local_4);
                var _local_3 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_9, _local_8 / 100);
                var _local_2 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_9, _local_8 / 100);
                motionX = motionX - _local_3;
                motionY = motionY - _local_2;
            }
            motionX = motionX * (1 - (0.2 * _arg_6));
            motionY = motionY * (1 - (0.2 * _arg_6));
            movie.art.box._x = movie.art.box._x + (motionX * _arg_6);
            movie.art.box._y = movie.art.box._y + (motionY * _arg_6);
            var _local_9 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie.art.rope._x, movie.art.rope._y, movie.art.box._x, movie.art.box._y - 15);
            movie.art.rope._rotation = _local_9;
            _local_8 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie.art.rope._x, movie.art.rope._y, movie.art.box._x, movie.art.box._y - 15);
            movie.art.rope._xscale = _local_8;
        }
    }
