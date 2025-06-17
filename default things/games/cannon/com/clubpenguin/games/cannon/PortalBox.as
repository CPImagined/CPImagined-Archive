//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.PortalBox extends com.clubpenguin.games.cannon.GameplayObstacle
    {
        var groundX, movie, groundY, motionX, motionY, elasticMultiplier, elasticMultiplierDefault, portalLinked, linkedPortal, waitN, linkArtN, settingN, sizeX, sizeY, hidden, animating, gameplayWorld, gameplayHolder, game;
        function PortalBox (_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10) {
            super(_arg_11, _arg_5, _arg_9, _arg_4, _arg_6, _arg_8, _arg_7, _arg_3, _arg_10);
            groundX = movie._x;
            groundY = movie._y;
            motionX = 0;
            motionY = 0;
            elasticMultiplier = 0.35;
            elasticMultiplierDefault = 0.35;
            portalLinked = false;
            linkedPortal = this;
            waitN = 0;
            linkArtN = 1;
            movie.gotoAndStop(settingN);
            sizeX = movie._width;
            sizeY = movie._height;
            movie.gotoAndStop("hide");
            hidden = true;
            animating = false;
            movie.master = this;
        }
        function updateGameplay(_arg_5) {
            var _local_12 = false;
            if ((movie._x + sizeX) > ((-gameplayHolder._x) - gameplayWorld._x)) {
                if ((movie._x - sizeX) < (((-gameplayHolder._x) - gameplayWorld._x) + 760)) {
                    if ((movie._y + sizeY) > ((-gameplayHolder._y) - gameplayWorld._y)) {
                        if ((movie._y - sizeY) < (((-gameplayHolder._y) - gameplayWorld._y) + 480)) {
                            _local_12 = true;
                        }
                    }
                }
            }
            if (animating == true) {
                _local_12 = true;
            }
            if (_local_12 == true) {
                if (hidden == true) {
                    movie.gotoAndStop(settingN);
                    hidden = false;
                }
            } else if (hidden == false) {
                movie.gotoAndStop("hide");
                hidden = true;
            }
            if (portalLinked == false) {
                var _local_2 = 0;
                while (_local_2 <= game.portalArray.length) {
                    if (game.portalArray[_local_2] == this) {
                        if (game.portalArray[_local_2 - 1].portalLinked == false) {
                            linkedPortal = game.portalArray[_local_2 - 1];
                            game.portalArray[_local_2 - 1].linkedPortal = this;
                            game.portalArray[_local_2 - 1].portalLinked = true;
                            portalLinked = true;
                            game.linkedPortalN++;
                            if (game.linkedPortalN > 20) {
                                game.linkedPortalN = 1;
                            }
                            linkArtN = game.linkedPortalN;
                            game.portalArray[_local_2 - 1].linkArtN = linkArtN;
                        }
                    }
                    _local_2++;
                }
            }
            if (waitN > 0) {
                waitN--;
            } else if (game.playerObj.inCannon == false) {
                var _local_13 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                if (_local_13 < 50) {
                    var _local_17 = game.playerObj.movie._x - game.playerObj.motionX;
                    var _local_16 = game.playerObj.movie._y - game.playerObj.motionY;
                    var _local_4 = com.clubpenguin["math"].AaronsPhysics.findAngle(_local_17, _local_16, movie._x, movie._y);
                    if (_local_4 >= 180) {
                        _local_4 = _local_4 - 360;
                    }
                    trace("entryAngle " + _local_4);
                    var _local_15;
                    if (_local_4 != 0) {
                        _local_15 = Math.abs(_local_4) / _local_4;
                    } else {
                        _local_15 = 1;
                    }
                    var _local_3 = movie._rotation;
                    if (_local_3 < -180) {
                        _local_3 = _local_3 + 360;
                    }
                    _local_3 = _local_3 + 90;
                    if (_local_3 >= 180) {
                        _local_3 = _local_3 - 360;
                    }
                    trace("boxAngle " + _local_3);
                    var _local_11;
                    if (_local_3 != 0) {
                        _local_11 = Math.abs(_local_3) / _local_3;
                    } else {
                        _local_11 = 1;
                    }
                    var _local_7;
                    _local_7 = 0;
                    _local_7 = Math.abs(_local_4 - _local_3);
                    if ((_local_7 > 60) && (_local_15 != _local_11)) {
                        _local_4 = _local_4 + (_local_11 * 360);
                        _local_7 = Math.abs(_local_4 - _local_3);
                    }
                    trace((("diff " + _local_4) + ":") + _local_3);
                    if (_local_7 <= 60) {
                        movie.art.gotoAndStop("still");
                        movie.art.gotoAndStop("bumpin");
                        motionY = motionY + game.playerObj.motionY;
                        linkedPortal.animating = true;
                        linkedPortal.movie.gotoAndStop(settingN);
                        linkedPortal.movie.art.gotoAndStop("still");
                        linkedPortal.movie.art.gotoAndStop("bumpout");
                        linkedPortal.waitN = linkedPortal.waitN + 6;
                        _local_13 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                        var _local_8 = com.clubpenguin["math"].AaronsPhysics.findAngle(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                        _local_8 = _local_8 - movie._rotation;
                        _local_8 = _local_8 + linkedPortal.movie._rotation;
                        var _local_18 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_8, _local_13);
                        var _local_19 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_8, _local_13);
                        game.playerObj.movie._x = linkedPortal.movie._x + _local_18;
                        game.playerObj.movie._y = linkedPortal.movie._y + _local_19;
                        game.playerObj.blurCharged = true;
                        game.playerObj.skipNextBlur = true;
                        var _local_6;
                        _local_6 = new flash.geom.Matrix();
                        _local_6.rotate(movie._rotation * (Math.PI/180));
                        _local_6.tx = game.playerObj.motionX;
                        _local_6.ty = game.playerObj.motionY;
                        var _local_20 = (linkedPortal.movie._rotation - movie._rotation) - 180;
                        _local_6.rotate(_local_20 * (Math.PI/180));
                        var _local_21 = game.playerObj.motionX;
                        game.playerObj.motionX = _local_6.tx;
                        game.playerObj.motionY = _local_6.ty;
                        game.playerObj.motionY = game.playerObj.motionY * 1.3;
                        if (game.playerObj.motionY > 60) {
                            if (game.gravityInverted == false) {
                                game.playerObj.motionY = 60;
                            }
                        } else if (game.playerObj.motionY < -60) {
                            if (game.gravityInverted == true) {
                                game.playerObj.motionY = -60;
                            }
                        }
                        game.playerObj.motionR = game.playerObj.motionR + (Math.abs(game.playerObj.motionY) + Math.abs(game.playerObj.motionX));
                        game.playerObj.camLocked = false;
                        game.playerObj.camChasePull = 20;
                        game.playerObj.camChaseFriction = 0.7;
                    } else {
                        var _local_14 = com.clubpenguin["math"].AaronsPhysics.findAngle(game.playerObj.getPosX(), game.playerObj.getPosY(), movie._x, movie._y);
                        var _local_10 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_14, 20);
                        var _local_9 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_14, 20);
                        motionX = motionX + _local_10;
                        motionY = motionY + _local_9;
                        game.playerObj.motionX = _local_10 * -0.9;
                        game.playerObj.motionY = _local_9 * -1.2;
                        game.playerObj.motionR = Math.abs(_local_10) + Math.abs(_local_9);
                        movie.art.gotoAndStop("still");
                        movie.art.gotoAndStop("bump");
                        waitN = waitN + 3;
                    }
                }
            }
            if (movie._x > (groundX + 1)) {
                motionX = motionX - ((Math.abs(movie._x - groundX) * elasticMultiplier) * _arg_5);
            } else if (movie._x < (groundX - 1)) {
                motionX = motionX + ((Math.abs(movie._x - groundX) * elasticMultiplier) * _arg_5);
            }
            if (movie._y > (groundY + 1)) {
                motionY = motionY - ((Math.abs(movie._y - groundY) * elasticMultiplier) * _arg_5);
            } else if (movie._y < (groundY - 1)) {
                motionY = motionY + ((Math.abs(movie._y - groundY) * elasticMultiplier) * _arg_5);
            }
            motionX = motionX * (1 - (0.2 * _arg_5));
            motionY = motionY * (1 - (0.2 * _arg_5));
            movie._x = movie._x + (motionX * _arg_5);
            movie._y = movie._y + (motionY * _arg_5);
            movie.art.art.idart.gotoAndStop(linkArtN);
        }
    }
