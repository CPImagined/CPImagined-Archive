//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.BossCrabby
    {
        var game, gameplayWorld, gameplayHolder, bossHolder, idNumber, settingN, movie, debrisN, groundX, groundY, startX, startY, motionX, motionY, alive, hp, moveSpeed, collidable, leaving, pathTargetN, targetSet, timeN, engineLoopN, engineLoopDefault, pathFollowing, goingForward, pathWayArray, chase, chaseStartN, phase, motionRArm, armAngle, attacking, armRotationN, playerFellDuring, changingGravity, tooClose, box0X, box0Y, box1X, box1Y, box2X, box2Y, box3X, box3Y, box4X, box4Y, box5X, box5Y, box6X, box6Y, box7X, box7Y, orbitR0, orbitR1, orbitR2, orbitR3, orbitR4, orbitR5, orbitR6, orbitR7, box8X, box8Y, box9X, box9Y, box10X, box10Y, box11X, box11Y, box12X, box12Y, box13X, box13Y, box14X, box14Y, box15X, box15Y, orbitR8, orbitR9, orbitR10, orbitR11, orbitR12, orbitR13, orbitR14, orbitR15, box16X, box16Y, box17X, box17Y, box18X, box18Y, box19X, box19Y, box20X, box20Y, box21X, box21Y, box22X, box22Y, box23X, box23Y, orbitR16, orbitR17, orbitR18, orbitR19, orbitR20, orbitR21, orbitR22, orbitR23, dragonFlyX, speedMod, countdown, attackEnd, anvilXL, anvilX, anvilYL, anvilY, pushX, pushY, debrisObj;
        function BossCrabby (_arg_9, _arg_3, _arg_7, _arg_4, _arg_2, _arg_6, _arg_5, $posR, _arg_8) {
            game = _arg_9;
            gameplayWorld = _arg_3;
            gameplayHolder = _arg_7;
            bossHolder = _arg_4;
            idNumber = _arg_2;
            settingN = _arg_8;
            movie = bossHolder.attachMovie("obstacle", "Obj" + _arg_2, _arg_2);
            movie._x = _arg_6;
            movie._y = _arg_5;
            movie.gotoAndStop(settingN);
            debrisN = 1;
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
            leaving = false;
            pathTargetN = -1;
            targetSet = false;
            timeN = 0;
            engineLoopN = 35;
            engineLoopDefault = engineLoopN;
            if (game.gameMode == "standardGameplay") {
                movie.art.gotoAndStop("gameplay");
                if (settingN == 23) {
                    pathFollowing = false;
                } else if (settingN == 24) {
                    pathFollowing = false;
                } else if (settingN == 25) {
                    pathFollowing = false;
                }
                if (settingN == 26) {
                    pathFollowing = true;
                    goingForward = true;
                    pathWayArray = [[-1900, 250], [-1800, 250], [-1600, 250], [-1200, 250], [-1000, 250], [-800, 250], [-400, 250], [-100, 200], [-100, 15], [490, 15], [912, 15], [1503, 48], [1823, 52], [2193, 30], [2528, 68], [2968, -47], [3448, 0], [3598, -378], [3397, -630], [3286, -853], [3428, -1086], [3325, -1301], [3511, -1545], [3316, -1893], [3735, -2151], [4237, -2150], [4703, -2146], [4750, -1000], [4750, 0], [4750, 1000]];
                    game.magnetism = true;
                    game.magnet = this;
                    game.magnetOffsetX = 0;
                    game.magnetOffsetY = 120;
                }
                if (settingN == 27) {
                    chase = false;
                    chaseStartN = 0;
                    phase = 1;
                    pathFollowing = true;
                    goingForward = true;
                    pathWayArray = [[653, -1540], [-665, -1603], [-675.05, -1325]];
                    movie._x = 2020;
                    movie._y = -1740;
                    motionRArm = 0;
                    armAngle = 0;
                    attacking = true;
                    armRotationN = 0;
                }
                if (settingN == 28) {
                    pathFollowing = false;
                    playerFellDuring = false;
                    changingGravity = false;
                    tooClose = false;
                }
                if (settingN == 29) {
                    hp = 9;
                    phase = 1;
                    pathFollowing = false;
                    box0X = 0;
                    box0Y = 0;
                    box1X = 0;
                    box1Y = 0;
                    box2X = 0;
                    box2Y = 0;
                    box3X = 0;
                    box3Y = 0;
                    box4X = 0;
                    box4Y = 0;
                    box5X = 0;
                    box5Y = 0;
                    box6X = 0;
                    box6Y = 0;
                    box7X = 0;
                    box7Y = 0;
                    orbitR0 = 0;
                    orbitR1 = 45;
                    orbitR2 = 90;
                    orbitR3 = 135;
                    orbitR4 = 180;
                    orbitR5 = 225;
                    orbitR6 = 270;
                    orbitR7 = 315;
                    box8X = 0;
                    box8Y = 0;
                    box9X = 0;
                    box9Y = 0;
                    box10X = 0;
                    box10Y = 0;
                    box11X = 0;
                    box11Y = 0;
                    box12X = 0;
                    box12Y = 0;
                    box13X = 0;
                    box13Y = 0;
                    box14X = 0;
                    box14Y = 0;
                    box15X = 0;
                    box15Y = 0;
                    orbitR8 = 23;
                    orbitR9 = 68;
                    orbitR10 = 113;
                    orbitR11 = 158;
                    orbitR12 = 203;
                    orbitR13 = 248;
                    orbitR14 = 293;
                    orbitR15 = 338;
                    box16X = 0;
                    box16Y = 0;
                    box17X = 0;
                    box17Y = 0;
                    box18X = 0;
                    box18Y = 0;
                    box19X = 0;
                    box19Y = 0;
                    box20X = 0;
                    box20Y = 0;
                    box21X = 0;
                    box21Y = 0;
                    box22X = 0;
                    box22Y = 0;
                    box23X = 0;
                    box23Y = 0;
                    orbitR16 = 0;
                    orbitR17 = 45;
                    orbitR18 = 90;
                    orbitR19 = 135;
                    orbitR20 = 180;
                    orbitR21 = 225;
                    orbitR22 = 270;
                    orbitR23 = 315;
                }
                if (settingN == 38) {
                    phase = 1;
                    pathFollowing = false;
                    dragonFlyX = 0;
                }
            }
        }
        function startIntro() {
            trace("start intro");
            game.inCutscene = true;
            game.forceSlowMode = true;
        }
        function endIntro() {
            alive = false;
            game.inCutscene = false;
            game.forceSlowMode = false;
            removeMovieClip(movie);
        }
        function updateGameplay(_arg_23) {
            speedMod = _arg_23;
            if (alive == true) {
                if (engineLoopN > 0) {
                    engineLoopN--;
                } else {
                    engineLoopN = engineLoopDefault;
                    playSFX("vroom");
                }
            }
            if (settingN == 23) {
                if (game.playerObj.inCannon == false) {
                    if (alive == true) {
                        var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(game.playerObj.movie._x, game.playerObj.movie._y, game.giantPuffleOObj.movie._x, game.giantPuffleOObj.movie._y);
                        if (_local_3 < 50) {
                            movie.art.art.gotoAndStop("lose");
                        }
                        if (collidable == true) {
                            _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_3 < 50) {
                                leaving = true;
                                movie.art.art.gotoAndStop(1);
                                movie.art.art.gotoAndStop("hit");
                                bumpPuffle();
                                takeDamage();
                            }
                        }
                    }
                }
                if (alive == false) {
                    collidable = false;
                    motionY = motionY + 0.4;
                }
                if ((leaving == true) && (alive == true)) {
                    motionY = motionY - 0.2;
                    motionX = motionX - 0.2;
                }
                if (leaving == false) {
                    pullTowardsTarget();
                }
                updatePosition();
                if (alive == true) {
                    if (leaving == false) {
                        if (countdown > 0) {
                            countdown--;
                        } else {
                            countdown = 40;
                            if (groundX > startX) {
                                groundX = startX - 100;
                            } else {
                                groundX = startX + 100;
                            }
                        }
                    }
                }
            } else if (settingN == 24) {
                if (alive == true) {
                    game.inCutscene = true;
                }
            }
            if (settingN == 25) {
                if (game.playerObj.inCannon == false) {
                    if (alive == true) {
                        if (collidable == true) {
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_3 < 50) {
                                movie.art.art.gotoAndStop(1);
                                movie.art.art.gotoAndStop("hit");
                                bumpPuffle();
                                takeDamage();
                            }
                        }
                    }
                }
                if (alive == false) {
                    collidable = false;
                    motionY = motionY + 0.4;
                }
                pullTowardsTarget();
                updatePosition();
                if (alive == true) {
                    if (countdown > 0) {
                        countdown--;
                    } else {
                        countdown = 40;
                        if (groundX > startX) {
                            groundX = startX - 500;
                        } else {
                            groundX = startX + 500;
                        }
                    }
                }
            }
            if (settingN == 26) {
                if (game.playerObj.inCannon == false) {
                    if (alive == true) {
                        if (collidable == true) {
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_3 < 50) {
                                movie.art.art.gotoAndStop(1);
                                movie.art.art.gotoAndStop("hit");
                                bumpPuffle();
                                takeDamage();
                            }
                        }
                    }
                }
                if (alive == false) {
                    collidable = false;
                    motionY = motionY + 0.4;
                }
                if (alive == true) {
                    if (pathFollowing == true) {
                        if (targetSet == false) {
                            if (pathTargetN < pathWayArray.length) {
                                pathTargetN++;
                                groundX = pathWayArray[pathTargetN][0];
                                groundY = pathWayArray[pathTargetN][1];
                                targetSet = true;
                            } else {
                                pathFollowing = false;
                            }
                        } else {
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, groundX, groundY);
                            if (_local_3 < 100) {
                                targetSet = false;
                            }
                        }
                    }
                }
                pullTowardsTarget();
                updatePosition();
            }
            if (settingN == 27) {
                timeN++;
                if (phase == 1) {
                    if (timeN == 1) {
                        game.inCutscene = true;
                        game.playerObj.motionX = 0;
                        game.playerObj.movie._x = game.playerObj.startX;
                    }
                    if (timeN == 72) {
                        startIntro();
                        game.playMusic("none");
                    }
                    if (timeN == 96) {
                        game.playMusic("boss");
                    }
                    if (timeN == 240) {
                        game.inCutscene = false;
                        game.forceSlowMode = false;
                    }
                    if (timeN == 336) {
                        phase = 2;
                        pathTargetN = 0;
                        groundX = pathWayArray[pathTargetN][0];
                        groundY = pathWayArray[pathTargetN][1];
                        pathWayArray = [[130, -325], [460.05, -320], [760.05, -310], [985.05, -80], [1135.05, 200], [950.05, 430], [625.05, 505], [300, 500], [-10, 490], [-320, 490], [-635, 480], [-810, 230], [-680, -55], [-510, -280], [-210, -335]];
                        attacking = false;
                    }
                }
                if (game.playerObj.inCannon == false) {
                    if (alive == true) {
                        if (collidable == true) {
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_3 < 50) {
                                movie.art.art.gotoAndStop(1);
                                movie.art.art.gotoAndStop("hit");
                                bumpPuffle();
                                takeDamage();
                            }
                        }
                    }
                }
                if (alive == false) {
                    collidable = false;
                    motionY = motionY + 0.4;
                    attacking = false;
                }
                if (alive == true) {
                    if (pathFollowing == true) {
                        if (targetSet == false) {
                            if (goingForward == true) {
                                pathTargetN++;
                                if (pathTargetN >= pathWayArray.length) {
                                    pathTargetN = 0;
                                }
                            } else {
                                pathTargetN--;
                                if (pathTargetN < 0) {
                                    pathTargetN = pathWayArray.length - 1;
                                }
                            }
                            if (pathTargetN == attackEnd) {
                                attacking = false;
                            }
                            groundX = pathWayArray[pathTargetN][0];
                            groundY = pathWayArray[pathTargetN][1];
                            targetSet = true;
                        } else {
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, groundX, groundY);
                            if (_local_3 < 100) {
                                targetSet = false;
                            }
                        }
                    }
                }
                if (phase == 2) {
                    if (alive == true) {
                        var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                        if (_local_3 > 1500) {
                            moveSpeed = 0.02;
                        } else if (_local_3 > 1000) {
                            moveSpeed = 0.01;
                        } else if (_local_3 > 600) {
                            moveSpeed = 0.006;
                        } else {
                            moveSpeed = 0.003;
                        }
                        if (game.playerObj.alive == false) {
                            attacking = true;
                            attackEnd = pathTargetN;
                        }
                        if (chase == true) {
                            if ((chaseStartN + 120) < timeN) {
                                chase = false;
                            }
                            var _local_8 = pathTargetN + 1;
                            if (_local_8 == pathWayArray.length) {
                                _local_8 = 0;
                            }
                            var _local_13 = pathWayArray[_local_8][0];
                            var _local_12 = pathWayArray[_local_8][1];
                            var _local_15 = com.clubpenguin["math"].AaronsPhysics.findDistance(_local_13, _local_12, game.playerObj.movie._x, game.playerObj.movie._y);
                            var _local_7 = pathTargetN - 1;
                            if (_local_7 == -1) {
                                _local_7 = pathWayArray.length - 1;
                            }
                            var _local_17 = pathWayArray[_local_7][0];
                            var _local_16 = pathWayArray[_local_7][1];
                            var _local_14 = com.clubpenguin["math"].AaronsPhysics.findDistance(_local_17, _local_16, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_15 < _local_14) {
                                goingForward = true;
                            } else {
                                goingForward = false;
                            }
                        }
                    }
                }
                pullTowardsTarget();
                updatePosition();
                if (attacking == true) {
                    if (motionX > 0) {
                        motionRArm = motionRArm + 4;
                    } else {
                        motionRArm = motionRArm - 4;
                    }
                }
                motionRArm = motionRArm + (motionX / 10);
                armRotationN = armRotationN + Math.abs(motionRArm);
                if (armRotationN > 360) {
                    armRotationN = 0;
                    if (Math.abs(motionRArm) > 10) {
                        swingSFX();
                    }
                }
                if (armAngle != 0) {
                    if (attacking == false) {
                        motionRArm = motionRArm - (armAngle / 10);
                    }
                }
                motionRArm = motionRArm * 0.9;
                armAngle = armAngle + motionRArm;
                if (armAngle > 360) {
                    armAngle = armAngle - 360;
                }
                if (armAngle < -360) {
                    armAngle = armAngle + 360;
                }
                movie.art.art.arm._rotation = armAngle + 90;
                anvilXL = anvilX;
                anvilYL = anvilY;
                anvilX = com.clubpenguin["math"].AaronsPhysics.findPositionXAfterParentRotation(200, 0, movie._x, movie._y, movie.art.art.arm._rotation);
                anvilY = com.clubpenguin["math"].AaronsPhysics.findPositionYAfterParentRotation(200, 0, movie._x, movie._y, movie.art.art.arm._rotation);
                var _local_6 = com.clubpenguin["math"].AaronsPhysics.findAngle(anvilXL, anvilYL, anvilX, anvilY);
                if (alive == true) {
                    if (collidable == true) {
                        var _local_2 = 0;
                        while (_local_2 < game.sodaBalloonArray.length) {
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(anvilX, anvilY, game.sodaBalloonArray[_local_2].movie._x, game.sodaBalloonArray[_local_2].movie._y);
                            if (_local_3 < 120) {
                                if (attacking == false) {
                                    if (game.sodaBalloonArray[_local_2].movie._y > (anvilY - 50)) {
                                        var _local_11 = com.clubpenguin["math"].AaronsPhysics.findAngle(anvilX, anvilY, game.sodaBalloonArray[_local_2].movie._x, game.sodaBalloonArray[_local_2].movie._y);
                                        var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_11, 50);
                                        var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_11, 50);
                                        game.sodaBalloonArray[_local_2].motionX = _local_5;
                                        game.sodaBalloonArray[_local_2].motionY = _local_4;
                                        game.sodaBalloonArray[_local_2].setElasticPull(0.001);
                                    }
                                }
                                if (attacking == true) {
                                    var _local_11 = com.clubpenguin["math"].AaronsPhysics.findAngle(anvilX, anvilY, game.sodaBalloonArray[_local_2].movie._x, game.sodaBalloonArray[_local_2].movie._y);
                                    var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_11, 50);
                                    var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_11, 50);
                                    var _local_20 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_6, 100);
                                    var _local_18 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_6, 100);
                                    game.sodaBalloonArray[_local_2].motionX = _local_5 + _local_20;
                                    game.sodaBalloonArray[_local_2].motionY = _local_4 + _local_18;
                                    game.sodaBalloonArray[_local_2].setElasticPull(0.001);
                                }
                            }
                            _local_2++;
                        }
                        if (game.playerObj.inCannon == false) {
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(anvilX, anvilY, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_3 < 120) {
                                if (attacking == false) {
                                    if (game.playerObj.movie._y > (anvilY - 50)) {
                                        var _local_11 = com.clubpenguin["math"].AaronsPhysics.findAngle(anvilX, anvilY, game.playerObj.movie._x, game.playerObj.movie._y);
                                        var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_11, 25);
                                        var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_11, 25);
                                        game.playerObj.motionX = _local_5;
                                        game.playerObj.motionY = _local_4;
                                        game.sfx.anvil100.gotoAndPlay("on");
                                    }
                                }
                                if (attacking == true) {
                                    var _local_11 = com.clubpenguin["math"].AaronsPhysics.findAngle(anvilX, anvilY, game.playerObj.movie._x, game.playerObj.movie._y);
                                    var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_11, 25);
                                    var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_11, 25);
                                    var _local_20 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_6, 50);
                                    var _local_18 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_6, 50);
                                    game.playerObj.motionX = _local_5 + _local_20;
                                    game.playerObj.motionY = _local_4 + _local_18;
                                    game.sfx.anvil100.gotoAndPlay("on");
                                }
                            }
                        }
                    }
                }
            }
            if (settingN == 28) {
                if (game.playerObj.alive == false) {
                    playerFellDuring = true;
                }
                tooClose = false;
                if (movie._x < game.playerObj.movie._x) {
                    groundX = game.playerObj.movie._x - 260;
                    if ((game.playerObj.movie._x - movie._x) < 200) {
                        groundX = groundX - 400;
                        tooClose = true;
                    }
                } else {
                    groundX = game.playerObj.movie._x - 260;
                    if ((movie._x - game.playerObj.movie._x) < 200) {
                        groundX = groundX + 400;
                        tooClose = true;
                    }
                }
                if (tooClose == false) {
                    if (collidable == true) {
                        if (changingGravity == false) {
                            var _local_22 = 16;
                            var _local_10 = game.playerObj.movie._y + (game.playerObj.motionY * 16);
                            if (game.gravityInverted == false) {
                                if (_local_10 > movie._y) {
                                    trace("start changing gravity to up");
                                    movie.art.art.gotoAndStop(1);
                                    movie.art.art.gotoAndStop("invert");
                                    playerFellDuring = false;
                                    changingGravity = true;
                                }
                            }
                            if (game.gravityInverted == true) {
                                if (_local_10 < movie._y) {
                                    trace("start changing gravity to down");
                                    movie.art.art.gotoAndStop(1);
                                    movie.art.art.gotoAndStop("invert");
                                    playerFellDuring = false;
                                    changingGravity = true;
                                }
                            }
                        } else {
                            trace("currently changing gravity " + changingGravity);
                        }
                    }
                }
                if (game.playerObj.inCannon == false) {
                    if (alive == true) {
                        if (collidable == true) {
                            var _local_2 = 0;
                            while (_local_2 < game.shatterBoxArray.length) {
                                if (game.shatterBoxArray[_local_2].breakN < 4) {
                                    var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.shatterBoxArray[_local_2].movie._x, game.shatterBoxArray[_local_2].movie._y);
                                    if (_local_3 < 120) {
                                        var _local_11 = com.clubpenguin["math"].AaronsPhysics.findAngle(game.shatterBoxArray[_local_2].movie._x, game.shatterBoxArray[_local_2].movie._y, movie._x, movie._y);
                                        var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_11, 20);
                                        var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_11, 20);
                                        motionX = _local_5;
                                        motionY = _local_4;
                                        game.shatterBoxArray[_local_2].shatter();
                                    }
                                }
                                _local_2++;
                            }
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_3 < 50) {
                                movie.art.art.gotoAndStop(1);
                                movie.art.art.gotoAndStop("hit");
                                bumpPuffle();
                                takeDamage();
                                changingGravity = false;
                                trace("changingGravity set to " + changingGravity);
                            }
                            _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y + 120, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_3 < 43) {
                                bumpGravityBox(movie.art.art.art.box);
                                var _local_11 = com.clubpenguin["math"].AaronsPhysics.findAngle(game.playerObj.movie._x, game.playerObj.movie._y, movie._x + 120, movie._y);
                                var _local_5 = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_11, 20);
                                var _local_4 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_11, 20);
                                motionX = _local_5;
                                motionY = _local_4;
                                game.playerObj.motionX = _local_5 * -0.9;
                                game.playerObj.motionY = _local_4 * -1.2;
                                game.playerObj.motionR = Math.abs(_local_5) + Math.abs(_local_4);
                            }
                        }
                    }
                }
                if (alive == false) {
                    collidable = false;
                    motionY = motionY + 0.4;
                }
                pullTowardsTarget();
                updatePosition();
            }
            if (settingN == 29) {
                timeN++;
                if (phase == 1) {
                    groundX = groundX + 10;
                    if (timeN == 1) {
                        movie._x = groundX;
                        movie._y = groundY;
                        game.inCutscene = true;
                        game.playerObj.motionX = 0;
                        game.playerObj.movie._x = game.playerObj.startX;
                    }
                    if (timeN == 72) {
                        startIntro();
                        game.playMusic("none");
                    }
                    if (timeN == 96) {
                        game.playMusic("boss");
                    }
                    if (timeN == 240) {
                        game.inCutscene = false;
                        game.forceSlowMode = false;
                    }
                    if (timeN == 336) {
                        phase = 2;
                        groundX = 250;
                        groundY = -940;
                        startX = groundX;
                        startY = groundY;
                    }
                }
                if (game.playerObj.inCannon == false) {
                    if (alive == true) {
                        if (collidable == true) {
                            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                            if (_local_3 < 50) {
                                movie.art.art.gotoAndStop(1);
                                movie.art.art.gotoAndStop("hit");
                                bumpPuffle();
                                takeDamage();
                                var _local_2 = 0;
                                while (_local_2 < 24) {
                                    game.asteroidArray[_local_2].motionX = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(this["orbitR" + _local_2], 50);
                                    game.asteroidArray[_local_2].motionY = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(this["orbitR" + _local_2], 50);
                                    _local_2++;
                                }
                                if (hp < 2) {
                                    gameplayHolder.particleHolder.attachMovie("bossspinout", "bossspinout", 2);
                                    gameplayHolder.particleHolder.bossspinout._x = movie._x;
                                    gameplayHolder.particleHolder.bossspinout._y = movie._y;
                                    game.playerObj.camTarget = gameplayHolder.particleHolder.bossspinout;
                                    game.playerObj.camTargetTimeN = 54;
                                    game.playerObj.camLocked = false;
                                    _local_2 = 0;
                                    while (_local_2 < 24) {
                                        game.asteroidArray[_local_2].motionX = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(this["orbitR" + _local_2], 50);
                                        game.asteroidArray[_local_2].motionY = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(this["orbitR" + _local_2], 50);
                                        game.asteroidArray[_local_2].shrinking = true;
                                        game.asteroidArray[_local_2].collidable = false;
                                        _local_2++;
                                    }
                                    game.level1obstacleArray[25].movie._x = 480;
                                    game.level1obstacleArray[25].movie._y = -1650;
                                    game.level1obstacleArray[25].groundX = 480;
                                    game.level1obstacleArray[25].groundY = -850;
                                    game.level1obstacleArray[26].movie._x = 610;
                                    game.level1obstacleArray[26].movie._y = -2260;
                                    game.level1obstacleArray[26].groundX = 610;
                                    game.level1obstacleArray[26].groundY = -1460;
                                    game.level1obstacleArray[27].movie._x = 760;
                                    game.level1obstacleArray[27].movie._y = -2840;
                                    game.level1obstacleArray[27].groundX = 760;
                                    game.level1obstacleArray[27].groundY = -2040;
                                    game.level1obstacleArray[28].movie._x = 930;
                                    game.level1obstacleArray[28].movie._y = -3430;
                                    game.level1obstacleArray[28].groundX = 930;
                                    game.level1obstacleArray[28].groundY = -2630;
                                    game.level1obstacleArray[29].movie._x = 1110;
                                    game.level1obstacleArray[29].movie._y = -4000;
                                    game.level1obstacleArray[29].groundX = 1110;
                                    game.level1obstacleArray[29].groundY = -3200;
                                    game.playerObj.motionX = 0;
                                    game.playerObj.motionY = -27;
                                    destroy();
                                }
                            }
                        }
                    }
                }
                if (alive == true) {
                    var _local_2 = 0;
                    while (_local_2 < 8) {
                        this["orbitR" + _local_2] = this["orbitR" + _local_2] + (1.5 * speedMod);
                        if (this["orbitR" + _local_2] >= 360) {
                            this["orbitR" + _local_2] = this["orbitR" + _local_2] - 360;
                        }
                        this[("box" + _local_2) + "X"] = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(this["orbitR" + _local_2], 800);
                        this[("box" + _local_2) + "Y"] = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(this["orbitR" + _local_2], 800);
                        this[("box" + _local_2) + "X"] = movie._x + this[("box" + _local_2) + "X"];
                        this[("box" + _local_2) + "Y"] = movie._y + this[("box" + _local_2) + "Y"];
                        game.asteroidArray[_local_2].groundX = this[("box" + _local_2) + "X"];
                        game.asteroidArray[_local_2].groundY = this[("box" + _local_2) + "Y"];
                        _local_2++;
                    }
                    _local_2 = 8;
                    while (_local_2 < 16) {
                        this["orbitR" + _local_2] = this["orbitR" + _local_2] - (1.5 * speedMod);
                        if (this["orbitR" + _local_2] <= 0) {
                            this["orbitR" + _local_2] = this["orbitR" + _local_2] + 360;
                        }
                        this[("box" + _local_2) + "X"] = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(this["orbitR" + _local_2], 500);
                        this[("box" + _local_2) + "Y"] = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(this["orbitR" + _local_2], 500);
                        this[("box" + _local_2) + "X"] = movie._x + this[("box" + _local_2) + "X"];
                        this[("box" + _local_2) + "Y"] = movie._y + this[("box" + _local_2) + "Y"];
                        game.asteroidArray[_local_2].groundX = this[("box" + _local_2) + "X"];
                        game.asteroidArray[_local_2].groundY = this[("box" + _local_2) + "Y"];
                        _local_2++;
                    }
                    _local_2 = 16;
                    while (_local_2 < 24) {
                        this["orbitR" + _local_2] = this["orbitR" + _local_2] - (1.5 * speedMod);
                        if (this["orbitR" + _local_2] <= 0) {
                            this["orbitR" + _local_2] = this["orbitR" + _local_2] + 360;
                        }
                        this[("box" + _local_2) + "X"] = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(this["orbitR" + _local_2], 1000);
                        this[("box" + _local_2) + "Y"] = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(this["orbitR" + _local_2], 1000);
                        this[("box" + _local_2) + "X"] = movie._x + this[("box" + _local_2) + "X"];
                        this[("box" + _local_2) + "Y"] = movie._y + this[("box" + _local_2) + "Y"];
                        game.asteroidArray[_local_2].groundX = this[("box" + _local_2) + "X"];
                        game.asteroidArray[_local_2].groundY = this[("box" + _local_2) + "Y"];
                        _local_2++;
                    }
                }
                pullTowardsTarget();
                updatePosition();
                if (phase == 2) {
                    if (alive == true) {
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
            }
            if (settingN == 38) {
                if (phase == 1) {
                    var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
                    if (_local_3 < 320) {
                        if (game.playerObj.movie._y > movie._y) {
                            phase = 2;
                            movie.art.art.gotoAndStop("cutscene");
                        }
                    }
                }
                if (phase == 2) {
                    timeN++;
                    if (timeN == 1) {
                        game.inCutscene = true;
                        startIntro();
                    }
                    if (timeN == 48) {
                        var _local_2 = 0;
                        while (_local_2 <= game.level1cannonArray.length) {
                            game.level1cannonArray[_local_2].destroy();
                            _local_2++;
                        }
                    }
                    if (timeN == 192) {
                        game.inCutscene = false;
                        game.forceSlowMode = false;
                        phase = 3;
                        timeN = 0;
                        dragonFlyX = 6;
                    }
                }
                if (phase == 3) {
                    timeN++;
                    if (hp > 6) {
                        if (timeN == 24) {
                            dragonFlyX = 10;
                            movie.art.art.art.head.gotoAndStop("still");
                            movie.art.art.art.head.gotoAndStop("attackbegin");
                        }
                        if (timeN == 25) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 48, 0);
                        }
                        if (timeN == 45) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 48, 0);
                        }
                        if (timeN == 55) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 48, 0);
                            timeN = 26;
                        }
                    } else if (hp > 4) {
                        if (timeN == 25) {
                            dragonFlyX = 10;
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 48, 0.1);
                        }
                        if (timeN == 45) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 18, 0.1);
                        }
                        if (timeN == 55) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 48, 0.1);
                            timeN = 26;
                        }
                    } else if (hp > 2) {
                        if (timeN == 25) {
                            dragonFlyX = 11;
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 48, 0.2);
                        }
                        if (timeN == 45) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 18, 0.2);
                        }
                        if (timeN == 55) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -5, random(12), 18, 0.2);
                            timeN = 26;
                        }
                    } else {
                        if (timeN == 25) {
                            dragonFlyX = 12;
                            game.generateFireBox(movie._x - 80, movie._y + 160, -7, random(12), random(10) + 8, 0.3);
                        }
                        if (timeN == 35) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -7, random(12), random(10) + 8, 0.3);
                        }
                        if (timeN == 45) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -7, random(12), random(10) + 8, 0.3);
                        }
                        if (timeN == 50) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -7, random(12), random(10) + 8, 0.3);
                        }
                        if (timeN == 55) {
                            game.generateFireBox(movie._x - 80, movie._y + 160, -7, random(12), random(10) + 8, 0.3);
                            timeN = 26;
                        }
                    }
                    if (game.fireboxNewest.alive == true) {
                        game.playerObj.startX = game.fireboxNewest.movie._x + (game.fireboxNewest.motionX * 10);
                        game.playerObj.startY = game.fireboxNewest.movie._y - 80;
                    }
                    var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x + 33, movie._y - 16, game.playerObj.movie._x, game.playerObj.movie._y);
                    var _local_9 = Math.round(100 - (_local_3 / 10));
                    if (_local_9 < 50) {
                        _local_9 = 50;
                        game.gameplayZoomMotion = 0;
                    }
                    game.gameplayZoomLevel = _local_9;
                    if (game.playerObj.inCannon == false) {
                        if (alive == true) {
                            if (collidable == true) {
                                if (_local_3 < 70) {
                                    movie.art.art.art.crab.gotoAndStop("still");
                                    movie.art.art.art.crab.gotoAndStop("hit");
                                    bumpDragon();
                                    dragonDamage();
                                }
                            }
                        }
                    }
                    groundX = groundX + dragonFlyX;
                    if (game.playerObj.inCannon == false) {
                        var _local_2 = 1;
                        while (_local_2 <= 4) {
                            dragonDetectPlayer(_local_2);
                            _local_2++;
                        }
                    }
                } else if (phase == 4) {
                    timeN++;
                    var _local_21 = (380 - gameplayHolder._x) - gameplayWorld._x;
                    var _local_19 = (240 - gameplayHolder._y) - gameplayWorld._y;
                    gameplayHolder.particleHolder.bossfinaldefeat._x = _local_21;
                    gameplayHolder.particleHolder.bossfinaldefeat._y = _local_19;
                    if (timeN == 48) {
                        game.gameplayZoomLevel = 100;
                        game.restoreBoxDragon(this);
                        movie.gotoAndStop("hide");
                    }
                }
                pullTowardsTarget();
                updatePosition();
            }
            var _local_2 = 0;
            while (_local_2 < game.debrisArray.length) {
                game.debrisArray[_local_2].updateGameplay();
                _local_2++;
            }
            if (alive == false) {
                if (movie._y > (game.fallZoneObj.movie._y + 100)) {
                    game.removeObject(this, game.debrisArray);
                }
            }
        }
        function bumpDragon() {
            var _local_2 = com.clubpenguin["math"].AaronsPhysics.findAngle(game.playerObj.movie._x, game.playerObj.movie._y, movie._x, movie._y);
            pushX = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_2, 40);
            pushY = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_2, 20);
            if (pushX < 0) {
                pushX = pushX * -0.5;
            }
            pushX = pushX + 10;
            game.playerObj.motionX = pushX * -0.6;
            game.playerObj.motionY = pushY * -1;
            game.playerObj.motionR = Math.abs(pushX) + Math.abs(pushY);
            if (game.playerObj.motionY >= 0) {
                game.playerObj.motionY = (Math.abs(pushY) + Math.abs(pushX)) * -0.5;
            }
            collidable = false;
        }
        function bumpPuffle() {
            var _local_2 = com.clubpenguin["math"].AaronsPhysics.findAngle(game.playerObj.movie._x, game.playerObj.movie._y, movie._x, movie._y);
            pushX = com.clubpenguin["math"].AaronsPhysics.findMotionXFromAngle(_local_2, 20);
            pushY = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_2, 20);
            motionX = pushX * 1.5;
            motionY = pushY * 1.5;
            game.playerObj.motionX = pushX * -0.2;
            game.playerObj.motionY = pushY * -1;
            game.playerObj.motionR = Math.abs(pushX) + Math.abs(pushY);
            if (game.playerObj.motionY >= 0) {
                game.playerObj.motionY = (Math.abs(pushY) + Math.abs(pushX)) * -0.5;
            }
            collidable = false;
        }
        function pullTowardsTarget() {
            if ((alive == true) && (leaving != true)) {
                if (movie._x > groundX) {
                    motionX = motionX - ((Math.abs(movie._x - groundX) * moveSpeed) * speedMod);
                } else if (movie._x < groundX) {
                    motionX = motionX + ((Math.abs(movie._x - groundX) * moveSpeed) * speedMod);
                }
                if (movie._y > groundY) {
                    motionY = motionY - ((Math.abs(movie._y - groundY) * moveSpeed) * speedMod);
                } else if (movie._y < groundY) {
                    motionY = motionY + ((Math.abs(movie._y - groundY) * moveSpeed) * speedMod);
                }
            }
        }
        function updatePosition() {
            motionX = motionX * (1 - (0.1 * speedMod));
            motionY = motionY * (1 - (0.1 * speedMod));
            movie._x = movie._x + (motionX * speedMod);
            movie._y = movie._y + (motionY * speedMod);
        }
        function dragonDamage() {
            if (hp > 0) {
                hp--;
                gameplayHolder.particleHolder.attachMovie("biff", "biff", 1);
                gameplayHolder.particleHolder.biff._x = game.playerObj.movie._x + (pushX * 3);
                gameplayHolder.particleHolder.biff._y = game.playerObj.movie._y + (pushY * 3);
                dropDebris(0, 0);
                if (hp == 0) {
                    alive = false;
                    phase = 4;
                    timeN = 0;
                    dragonFlyX = 0;
                    movie.art.art.art.head.gotoAndStop("attackend");
                    movie.art.art.art.crab.gotoAndStop("hide");
                    game.playerObj.motionX = 0;
                    game.playerObj.motionY = -27;
                    game.giantPuffleOObj.movie._x = movie._x;
                    game.giantPuffleOObj.movie._y = movie._y + 1000;
                    game.giantPuffleOObj.startX = movie._x + 1500;
                    game.giantPuffleOObj.startY = movie._y;
                    groundX = movie._x;
                    groundY = movie._y;
                    gameplayHolder.particleHolder.attachMovie("bossfinaldefeat", "bossfinaldefeat", 2);
                    gameplayHolder.particleHolder.bossfinaldefeat._x = movie._x + 33;
                    gameplayHolder.particleHolder.bossfinaldefeat._y = movie._y - 16;
                    game.playerObj.startX = movie._x;
                    game.playerObj.startY = movie._y - 200;
                    game.playMusic("win");
                    if (game[("b" + settingN) + "Defeat"] == false) {
                        game[("b" + settingN) + "Defeat"] = true;
                        game.bossDefeatsN++;
                        if (game.bossDefeatsN == 1) {
                            game.achievementUnlocked("boss1");
                        } else if (game.bossDefeatsN == 3) {
                            game.achievementUnlocked("boss2");
                        } else if (game.bossDefeatsN == 6) {
                            game.achievementUnlocked("boss3");
                        }
                        if (game.turboMode == true) {
                            game.achievementUnlocked("turbo2");
                        }
                    }
                }
            }
        }
        function takeDamage() {
            if (hp > 0) {
                hp--;
                gameplayHolder.particleHolder.attachMovie("biff", "biff", 1);
                gameplayHolder.particleHolder.biff._x = game.playerObj.movie._x + (pushX * 6);
                gameplayHolder.particleHolder.biff._y = game.playerObj.movie._y + (pushY * 6);
                dropDebris(0, 0);
                if (hp == 0) {
                    alive = false;
                    movie.art.art.goingDown = true;
                    if (game[("b" + settingN) + "Defeat"] == false) {
                        game[("b" + settingN) + "Defeat"] = true;
                        game.bossDefeatsN++;
                        if (game.bossDefeatsN == 1) {
                            game.achievementUnlocked("boss1");
                        } else if (game.bossDefeatsN == 3) {
                            game.achievementUnlocked("boss2");
                        } else if (game.bossDefeatsN == 6) {
                            game.achievementUnlocked("boss3");
                        }
                        if (game.turboMode == true) {
                            game.achievementUnlocked("turbo2");
                        }
                    }
                }
            }
        }
        function recover() {
            trace("hp = " + hp);
            if (hp <= 0) {
                alive = false;
                movie.art.art.gotoAndStop("finish");
                game.giantPuffleOObj.movie._x = movie._x;
                game.giantPuffleOObj.movie._y = movie._y;
                game.giantPuffleOObj.startX = startX;
                game.giantPuffleOObj.startY = startY;
                if (settingN == 27) {
                    game.giantPuffleOObj.hasBox = true;
                }
            } else {
                collidable = true;
                movie.art.art.gotoAndStop("still");
                if (settingN == 27) {
                    chase = true;
                    chaseStartN = timeN;
                    attacking = true;
                    attackEnd = pathTargetN;
                }
            }
        }
        function toggleAttack() {
            if (attacking == false) {
                attacking = true;
            } else if (attacking == true) {
                attacking = false;
            }
        }
        function dropDebris(_arg_4, _arg_3) {
            var _local_2 = 0;
            while (_local_2 < 5) {
                debrisN++;
                debrisObj = new com.clubpenguin.games.cannon.Debris(game, gameplayWorld, gameplayHolder, gameplayHolder.particleHolder, debrisN, movie._x + _arg_4, movie._y + _arg_3, random(5) + 1, motionX + (random(41) - 20), motionY - 40);
                gameplayHolder.particleArray.push(debrisObj);
                game.debrisArray.push(debrisObj);
                _local_2++;
            }
        }
        function playSFX(_arg_3) {
            var _local_2 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
            if (_local_2 < 200) {
                game.sfx[_arg_3 + 100].gotoAndPlay("on");
            } else if (_local_2 < 300) {
                game.sfx[_arg_3 + 80].gotoAndPlay("on");
            } else if (_local_2 < 400) {
                game.sfx[_arg_3 + 60].gotoAndPlay("on");
            } else if (_local_2 < 500) {
                game.sfx[_arg_3 + 40].gotoAndPlay("on");
            } else if (_local_2 < 600) {
                game.sfx[_arg_3 + 20].gotoAndPlay("on");
            }
        }
        function swingSFX() {
            var _local_3 = com.clubpenguin["math"].AaronsPhysics.findDistance(movie._x, movie._y, game.playerObj.movie._x, game.playerObj.movie._y);
            var _local_2 = "swing";
            if (_local_3 >= 400) {
                if (game.playerObj.movie._x > movie._x) {
                    _local_2 = "swingL";
                } else {
                    _local_2 = "swingR";
                }
            }
            if (_local_3 < 400) {
                game.sfx[_local_2 + 100].gotoAndPlay("on");
            } else if (_local_3 < 500) {
                game.sfx[_local_2 + 100].gotoAndPlay("on");
            } else if (_local_3 < 600) {
                game.sfx[_local_2 + 80].gotoAndPlay("on");
            } else if (_local_3 < 700) {
                game.sfx[_local_2 + 60].gotoAndPlay("on");
            } else if (_local_3 < 800) {
                game.sfx[_local_2 + 40].gotoAndPlay("on");
            } else if (_local_3 < 900) {
                game.sfx[_local_2 + 20].gotoAndPlay("on");
            }
        }
        function invertGravity(_arg_2) {
            trace("SWITCH gravity! to " + _arg_2);
            if (playerFellDuring == false) {
                game.gravityInverted = _arg_2;
            } else {
                trace("cancel, cant switch gravity because the player fell since the last time it was switched");
            }
            changingGravity = false;
            trace("finished changing gravity");
        }
        function bumpGravityBox(_arg_2) {
            _arg_2.gotoAndStop("bump");
            if (game.gravityInverted == false) {
                _arg_2.art.art.gotoAndStop("up");
            } else {
                _arg_2.art.art.gotoAndStop("down");
            }
        }
        function setBoxArrow() {
            if (game.gravityInverted == false) {
                movie.art.art.art.box.art.gotoAndStop("down");
            } else {
                movie.art.art.art.box.art.gotoAndStop("up");
            }
        }
        function dragonDetectPlayer(_arg_6) {
            var _local_13 = com.clubpenguin["math"].AaronsPhysics.findDistance((movie._x + movie.art.art._x) + movie.art.art["c" + _arg_6]._x, (movie._y + movie.art.art._y) + movie.art.art["c" + _arg_6]._y, game.playerObj.movie._x, game.playerObj.movie._y);
            var _local_11 = false;
            var _local_9 = (movie._x + movie.art.art._x) + movie.art.art["c" + _arg_6]._x;
            var _local_8 = (movie._y + movie.art.art._y) + movie.art.art["c" + _arg_6]._y;
            var _local_3 = game.playerObj.movie._x;
            var _local_2 = game.playerObj.movie._y;
            if (_arg_6 == 1) {
                var _local_10 = 136;
                var _local_5 = 136;
                var _local_4 = 103;
            } else if (_arg_6 == 2) {
                var _local_10 = 123;
                var _local_5 = 123;
                var _local_4 = 69;
            } else if (_arg_6 == 3) {
                var _local_10 = 188;
                var _local_5 = 188;
                var _local_4 = 139;
            } else if (_arg_6 == 4) {
                var _local_10 = 119;
                var _local_5 = 119;
                var _local_4 = 113;
            }
            if (_local_13 < _local_10) {
                if (_local_3 > (_local_9 - _local_5)) {
                    if (_local_3 < (_local_9 + _local_5)) {
                        if (_local_2 > (_local_8 - _local_4)) {
                            if (_local_2 < (_local_8 + _local_4)) {
                                _local_11 = true;
                            }
                        }
                    }
                }
            }
            if (_local_11 == true) {
                var _local_12 = false;
                _local_3 = game.playerObj.halfPosX;
                _local_2 = game.playerObj.halfPosY;
                if (_local_13 < _local_10) {
                    if (_local_3 > (_local_9 - _local_5)) {
                        if (_local_3 < (_local_9 + _local_5)) {
                            if (_local_2 > (_local_8 - _local_4)) {
                                if (_local_2 < (_local_8 + _local_4)) {
                                    _local_12 = true;
                                }
                            }
                        }
                    }
                }
            }
            if (_local_12 == true) {
                var _local_14 = false;
                _local_3 = game.playerObj.onethirdPosX;
                _local_2 = game.playerObj.onethirdPosY;
                if (_local_13 < _local_10) {
                    if (_local_3 > (_local_9 - _local_5)) {
                        if (_local_3 < (_local_9 + _local_5)) {
                            if (_local_2 > (_local_8 - _local_4)) {
                                if (_local_2 < (_local_8 + _local_4)) {
                                    _local_14 = true;
                                }
                            }
                        }
                    }
                }
            }
            if (alive == true) {
                if (_local_11 == true) {
                    if (_local_14 == true) {
                        _local_3 = game.playerObj.onethirdPosX;
                        _local_2 = game.playerObj.onethirdPosY;
                    } else if (_local_12 == true) {
                        _local_3 = game.playerObj.halfPosX;
                        _local_2 = game.playerObj.halfPosY;
                    } else {
                        _local_3 = game.playerObj.movie._x;
                        _local_2 = game.playerObj.movie._y;
                    }
                    var _local_15 = com.clubpenguin["math"].AaronsPhysics.findAngle(_local_3, _local_2, (movie._x + movie.art.art._x) + movie.art.art["c" + _arg_6]._x, (movie._y + movie.art.art._y) + movie.art.art["c" + _arg_6]._y);
                    var _local_7 = com.clubpenguin["math"].AaronsPhysics.findMotionYFromAngle(_local_15, 20);
                    if (_local_7 > 0) {
                        _local_7 = 20;
                    }
                    if (_local_7 < 0) {
                        _local_7 = -20;
                    }
                    pushX = 20;
                    game.playerObj.motionY = _local_7 * -1;
                    game.playerObj.motionX = pushX * -1;
                    game.playerObj.motionR = Math.abs(_local_7);
                }
            }
        }
        function destroy() {
            movie.removeMovieClip();
        }
    }
