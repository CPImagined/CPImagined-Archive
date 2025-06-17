//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.GiantPuffleO
    {
        var grabbed, game, iconHolder, movie, startX, startY, motionX, motionY, moveSpeed, offsetX, offsetY, hasBox;
        function GiantPuffleO (_arg_5, _arg_4, _arg_3, _arg_2) {
            grabbed = false;
            game = _arg_5;
            iconHolder = _arg_4;
            movie = iconHolder.attachMovie("giantPuffleO", "giantPuffleO", 2);
            movie._x = _arg_3;
            movie._y = _arg_2;
            startX = _arg_3;
            startY = _arg_2;
            motionX = 0;
            motionY = 0;
            moveSpeed = 0.01;
            if ((_arg_3 * 0) != 0) {
                movie._x = 0;
            }
            if ((_arg_2 * 0) != 0) {
                movie._y = 0;
            }
            offsetX = 0;
            offsetY = 0;
            hasBox = false;
        }
        function updateEditor() {
            if (grabbed == true) {
                if (game.brushObj.getGrabMode() == "drag") {
                    movie._x = game.gameplayHolder._xmouse + offsetX;
                    movie._y = game.gameplayHolder._ymouse + offsetY;
                    movie._x = Math.round(movie._x / 10) * 10;
                    movie._y = Math.round(movie._y / 10) * 10;
                }
            }
        }
        function updateGameplay() {
            if (game.playerObj.inCannon == false) {
                var _local_2 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.getPosX(), game.playerObj.getPosY());
                if (_local_2 < 50) {
                    game.forceSlowMode = false;
                    game.exitSloMo();
                    if (hasBox == true) {
                        movie.gotoAndStop("completebox");
                    } else {
                        movie.gotoAndStop("complete");
                    }
                    movie.game = game;
                    game.gamePaused = true;
                    game.playerObj.movie._visible = false;
                }
            }
            if (movie._x > startX) {
                motionX = motionX - (Math.abs(movie._x - startX) * moveSpeed);
            } else if (movie._x < startX) {
                motionX = motionX + (Math.abs(movie._x - startX) * moveSpeed);
            }
            if (movie._y > startY) {
                motionY = motionY - (Math.abs(movie._y - startY) * moveSpeed);
            } else if (movie._y < startY) {
                motionY = motionY + (Math.abs(movie._y - startY) * moveSpeed);
            }
            motionX = motionX * 0.9;
            motionY = motionY * 0.9;
            movie._x = movie._x + motionX;
            movie._y = movie._y + motionY;
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
        function destroy() {
            movie.removeMovieClip();
        }
    }
