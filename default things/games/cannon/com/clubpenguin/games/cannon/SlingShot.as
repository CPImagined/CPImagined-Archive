//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.SlingShot extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var motionX, motionY, inCannon, groundX, cannon, movie, groundY, pullX, pullY, pullingX, pullingY, noFire, settingN, sizeX, sizeY, hidden, gameplayWorld, gameplayHolder, game;
        function SlingShot (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            motionX = 0;
            motionY = 0;
            inCannon = false;
            groundX = movie._x + cannon._x;
            groundY = movie._y + cannon._y;
            pullX = 0;
            pullY = 0;
            pullingX = false;
            pullingY = false;
            noFire = true;
            movie.gotoAndStop(settingN);
            cannon = movie.art.cannon;
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
                if (hidden == true) {
                    movie.gotoAndStop(settingN);
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            if (game.playerObj.inCannon == false) {
                if (inCannon == false) {
                    var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x + cannon._x, movie._y + cannon._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                    if (_local_3 < 40) {
                        game.playerObj.inCannon = true;
                        inCannon = true;
                        motionX = motionX + game.playerObj.motionX;
                        motionY = motionY + game.playerObj.motionY;
                        if (motionY < -10) {
                            motionY = -10;
                        }
                        game.playerObj.motionX = 0;
                        game.playerObj.motionY = 0;
                        game.playerObj.movie._x = movie._x + cannon._x;
                        game.playerObj.movie._y = movie._y + cannon._y;
                        movie.art.gotoAndStop("still");
                        cannon.window.puffle.gotoAndStop(game.playerColor);
                        game.playerObj.isIn = this;
                    }
                }
            }
            pullingX = false;
            pullingY = false;
            if (inCannon == true) {
                if (Key.isDown(40) || Key.isDown(83)) {
                    if (cannon._y < 166) {
                        pullY = pullY + 3;
                    } else {
                        motionY = 0;
                    }
                    pullingY = true;
                }
                if (Key.isDown(37) || Key.isDown(65)) {
                    if (cannon._x > -98) {
                        pullX = pullX - 2;
                    } else {
                        motionX = 0;
                    }
                    pullingX = true;
                }
                if (Key.isDown(39) || Key.isDown(68)) {
                    if (cannon._x < 98) {
                        pullX = pullX + 2;
                    } else {
                        motionX = 0;
                    }
                    pullingX = true;
                }
            }
            if (cannon._x > 4) {
                motionX = motionX - (Math.abs(cannon._x) * 0.5);
            } else if (cannon._x < -4) {
                motionX = motionX + (Math.abs(cannon._x) * 0.5);
            }
            if (cannon._y > 4) {
                motionY = motionY - (Math.abs(cannon._y) * 0.5);
            } else if (cannon._y < -4) {
                motionY = motionY + (Math.abs(cannon._y) * 0.5);
            }
            if (pullingX == true) {
                pullX = pullX * 0.98;
                motionX = motionX + pullX;
            } else {
                pullX = 0;
            }
            if (pullingY == true) {
                pullY = pullY * 0.98;
                motionY = motionY + pullY;
            } else {
                pullY = 0;
            }
            motionX = motionX * 0.8;
            motionY = motionY * 0.8;
            cannon._x = cannon._x + motionX;
            cannon._y = cannon._y + motionY;
            if (cannon._x > 98) {
                cannon._x = 98;
            }
            if (cannon._x < -98) {
                cannon._x = -98;
            }
            if (cannon._y > 166) {
                cannon._y = 166;
            }
            var _local_4 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie.art.ropeL._x, movie.art.ropeL._y, cannon._x, cannon._y - 15);
            movie.art.ropeL._rotation = _local_4;
            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie.art.ropeL._x, movie.art.ropeL._y, cannon._x, cannon._y - 15);
            movie.art.ropeL._xscale = _local_3;
            _local_4 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie.art.ropeR._x, movie.art.ropeR._y, cannon._x, cannon._y - 15);
            movie.art.ropeR._rotation = _local_4;
            _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie.art.ropeR._x, movie.art.ropeR._y, cannon._x, cannon._y - 15);
            movie.art.ropeR._xscale = _local_3;
            if (inCannon == true) {
                game.playerObj.movie._x = movie._x + cannon._x;
                game.playerObj.movie._y = movie._y + cannon._y;
            }
            if (inCannon == true) {
                if (motionY < -20) {
                    if (cannon._y < -4) {
                        inCannon = false;
                        game.playerObj.inCannon = false;
                        cannon.window.puffle.gotoAndStop("none");
                        game.playerObj.motionX = motionX / 5;
                        game.playerObj.motionY = motionY;
                        game.playerObj.movie._x = game.playerObj.movie._x + motionX;
                        game.playerObj.movie._y = game.playerObj.movie._y + motionY;
                        game.playerObj.motionR = Math.abs(motionX) + Math.abs(motionY);
                        game.playerObj.skipNextBlur = true;
                        game.playerObj.blurCharged = true;
                    }
                }
            }
        }
    }
