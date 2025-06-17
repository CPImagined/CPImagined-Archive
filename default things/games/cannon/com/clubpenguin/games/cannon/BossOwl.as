//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.BossOwl extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX, movie, groundY, startX, startY, motionX, motionY, alive, hp, moveSpeed, collidable, spinN, game, settingN, gameplayHolder, countdown;
        function BossOwl (_arg_10, _arg_4, _arg_8, _arg_3, _arg_5, _arg_7, _arg_6, _arg_9) {
            super(_arg_10, _arg_4, _arg_8, _arg_3, _arg_5, _arg_7, _arg_6, _arg_9);
            groundX = movie._x;
            groundY = movie._y;
            startX = groundX;
            startY = groundY;
            motionX = 0;
            motionY = 0;
            movie.master = this;
            alive = true;
            hp = 8;
            moveSpeed = 0.003;
            collidable = true;
            spinN = 2;
            if (game.gameMode == "standardGameplay") {
                movie.art.gotoAndStop("gameplay");
                movie.art.art.gotoAndStop("still");
                movie.art.art.art.gotoAndStop(hp + 1);
            }
        }
        function startIntro() {
            game.inCutscene = true;
            game.forceSlowMode = true;
        }
        function endIntro() {
            alive = false;
            game.inCutscene = false;
            game.forceSlowMode = false;
            removeMovieClip(movie);
        }
        function updateGameplay(_arg_2) {
            if (settingN == 7) {
            }
            if (settingN == 8) {
                var _local_6 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                if (game.playerObj.inCannon == false) {
                    if (collidable == true) {
                        if (_local_6 < 70) {
                            var _local_5 = com.clubpenguin["math"].AaronsPhysics.findAngle(game.playerObj.getPosX(), game.playerObj.getPosY(), movie._x, movie._y);
                            var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_5, 30);
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_5, 30);
                            motionX = motionX + _local_4;
                            motionY = motionY + _local_3;
                            game.playerObj.motionY = Math.abs(_local_3) * -1.2;
                            game.playerObj.motionR = Math.abs(_local_4) + Math.abs(_local_3);
                            if (hp > 0) {
                                hp--;
                                moveSpeed = moveSpeed + 0.002;
                                movie.art.art.gotoAndStop("still");
                                movie.art.art.gotoAndStop("damage");
                                movie.art.art.art.gotoAndStop(hp + 1);
                                collidable = false;
                                movie.art.master = this;
                                gameplayHolder.particleHolder.attachMovie("biff", "biff", 1);
                                gameplayHolder.particleHolder.biff._x = game.playerObj.movie._x;
                                gameplayHolder.particleHolder.biff._y = game.playerObj.movie._y;
                                motionX = 0;
                                motionY = 0;
                            }
                        }
                    }
                }
                if (collidable == true) {
                    if (movie._x > groundX) {
                        motionX = motionX - ((Math.abs(movie._x - groundX) * moveSpeed) * _arg_2);
                        movie.art._xscale = -100;
                    } else if (movie._x < groundX) {
                        motionX = motionX + ((Math.abs(movie._x - groundX) * moveSpeed) * _arg_2);
                        movie.art._xscale = 100;
                    }
                    if (movie._y > groundY) {
                        motionY = motionY - ((Math.abs(movie._y - groundY) * moveSpeed) * _arg_2);
                    } else if (movie._y < groundY) {
                        motionY = motionY + ((Math.abs(movie._y - groundY) * moveSpeed) * _arg_2);
                    }
                }
                motionX = motionX * (1 - (0.1 * _arg_2));
                motionY = motionY * (1 - (0.1 * _arg_2));
                movie._x = movie._x + (motionX * _arg_2);
                movie._y = movie._y + (motionY * _arg_2);
                if (countdown > 0) {
                    countdown--;
                } else {
                    countdown = 40;
                    if (groundX > startX) {
                        groundX = startX - 300;
                    } else {
                        groundX = startX + 300;
                    }
                }
            }
        }
        function recover() {
            if (spinN > 0) {
                spinN--;
            } else {
                spinN = 2;
                if (hp == 0) {
                    movie.art.art.gotoAndStop("finish");
                } else {
                    collidable = true;
                    movie.art.art.gotoAndStop("still");
                    movie.art.art.art.gotoAndStop(hp + 1);
                }
            }
        }
        function finishChallenge1() {
            game.giantPuffleOObj.movie._x = movie._x - 11;
            game.giantPuffleOObj.movie._y = movie._y + 101;
        }
        function destroy() {
            movie.removeMovieClip();
        }
    }
