//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.FattyBirdRed extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX, movie, groundY, motionX, motionY, elasticMultiplier, elasticMultiplierDefault, settingN, sizeX, sizeY, hidden, gameplayWorld, gameplayHolder, game;
        function FattyBirdRed (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            groundX = movie._x;
            groundY = movie._y;
            motionX = 0;
            motionY = 0;
            elasticMultiplier = 0.15;
            elasticMultiplierDefault = 0.15;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
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
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            if (game.playerObj.inCannon == false) {
                var _local_8 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                if (_local_8 < 50) {
                    var _local_5 = com.clubpenguin["math"].AaronsPhysics.findAngle(game.playerObj.getPosX(), game.playerObj.getPosY(), movie._x, movie._y);
                    var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_5, 20);
                    var _local_3 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_5, 20);
                    motionX = motionX + _local_4;
                    motionY = motionY + _local_3;
                    movie.art.gotoAndStop("still");
                    movie.art.gotoAndStop("shake");
                    game.playerObj.motionX = _local_4 * -0.5;
                    game.playerObj.motionY = _local_3 * -1.5;
                    game.playerObj.motionR = Math.abs(_local_4) + Math.abs(_local_3);
                }
            }
            if (elasticMultiplier < elasticMultiplierDefault) {
                var _local_7 = 100 - ((elasticMultiplier / elasticMultiplierDefault) * 100);
                if (_local_7 > 10) {
                    elasticMultiplier = elasticMultiplier * 1.05;
                }
            } else if (elasticMultiplier > elasticMultiplierDefault) {
                elasticMultiplier = elasticMultiplierDefault;
            }
            if (movie._x > (groundX + 1)) {
                motionX = motionX - ((Math.abs(movie._x - groundX) * elasticMultiplier) * _arg_2);
            } else if (movie._x < (groundX - 1)) {
                motionX = motionX + ((Math.abs(movie._x - groundX) * elasticMultiplier) * _arg_2);
            }
            if (movie._y > (groundY + 1)) {
                motionY = motionY - ((Math.abs(movie._y - groundY) * elasticMultiplier) * _arg_2);
            } else if (movie._y < (groundY - 1)) {
                motionY = motionY + ((Math.abs(movie._y - groundY) * elasticMultiplier) * _arg_2);
            }
            motionX = motionX * (1 - (0.2 * _arg_2));
            motionY = motionY * (1 - (0.2 * _arg_2));
            movie._x = movie._x + (motionX * _arg_2);
            movie._y = movie._y + (motionY * _arg_2);
        }
        function setElasticPull(_arg_2) {
            elasticMultiplier = _arg_2;
        }
    }
