//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FuturePartySnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
    {
        var _ENGINE, _SHELL, _INTERFACE, maxSnowballs, throwItemCounter, snowballData, _stageMaskRectForCollision;
        function FuturePartySnowballManager (shell, engine, _interface) {
            super(shell, engine, _interface);
            var _local_3 = new com.clubpenguin.world.rooms2013.superhero.SnowballHitCheck();
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, _local_3);
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_TORNADO, _local_3);
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_SONIC, _local_3);
        }
        function throwBall(playerId, target_x, target_y, snowballVO) {
            var _local_15 = _global.getCurrentParty().FutureParty;
            if ((playerId == _SHELL.getMyPlayerId()) && (!_local_15.isSnowballEnabled)) {
                return(undefined);
            }
            var _local_9 = _INTERFACE.getIgnoreList();
            var _local_5 = 0;
            while (_local_5 < _local_9.length) {
                if (playerId == _local_9[_local_5].player_id) {
                    return(undefined);
                }
                _local_5++;
            }
            var _local_3 = {};
            var _local_4 = _ENGINE.getPlayerMovieClip(playerId);
            var _local_11 = _ENGINE.getRoomMovieClip();
            var _local_18 = _local_11.customPenguinSize;
            var _local_27 = _SHELL.getRoomObject().room_id;
            var _local_7;
            var _local_12;
            var _local_22 = _SHELL.getPlayerObjectById(playerId);
            if ((snowballVO == undefined) || (snowballVO == null)) {
                var _local_23 = _SHELL.getPlayerObjectById(playerId).avatar_id;
                snowballVO = _local_22.avatarVO.snowball;
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, 0, 20);
                if (_local_15.MECHCONTROLLER.isPlayerMech(playerId)) {
                    var _local_16 = _local_15.MECHCONTROLLER.getRobotType(playerId);
                    if (_local_16 != -1) {
                        if (_local_16 == 0) {
                            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LASER, 0, 0, 5);
                        }
                        if (_local_16 == 1) {
                            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_SONIC, 0, 0);
                        }
                        if (_local_16 == 2) {
                            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_TORNADO, 0, 0);
                        }
                    }
                }
            }
            if (_SHELL.getIsRoomIgloo()) {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            } else {
                var _local_17 = _local_11.attachMovie(snowballVO.type.symbolName, "testSnowball", 1);
                if (_local_17 == undefined) {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                } else {
                    _local_17.removeMovieClip();
                }
            }
            if (_local_4.is_reading) {
                _ENGINE.removePlayerBook(playerId);
            }
            if (_local_4.is_ready && (!_local_4.is_moving)) {
                var _local_21 = _ENGINE.findAngle(_local_4._x, _local_4._y, target_x, target_y);
                var _local_19 = _ENGINE.findDirectionQuarters(_local_21);
                var _local_20 = Number(_SHELL.DANCE_FRAME + _local_19);
                _ENGINE.updatePlayerFrame(playerId, _local_20);
                var _local_10;
                if (snowballVO.type == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LASER) {
                    _local_10 = {x:Number(_local_4._x - 10), y:Number(_local_4._y - (_local_4.art_mc._height / 2))};
                } else if (snowballVO.type == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_TORNADO) {
                    _local_10 = {x:Number(_local_4._x - 44.8), y:Number(_local_4._y - 100)};
                } else if (((_local_4.art_mc.body.snowballOrigin == undefined) || (_local_4.art_mc.body.snowballOrigin == undefined)) || (_local_4.art_mc.body.localToGlobal == undefined)) {
                    _local_10 = {x:_local_4._x, y:_local_4._y};
                } else if (snowballVO.type.originAtHead) {
                    _local_10 = {x:_local_4._x, y:Number(_local_4._y - (_local_4.art_mc._height / 2))};
                } else if (snowballVO.type.originAtCenter) {
                    _local_10 = {x:_local_4._x, y:Number(_local_4._y - (_local_4.art_mc._height / 5))};
                } else {
                    _local_10 = {x:_local_4._x, y:_local_4._y};
                }
                if (throwItemCounter >= maxSnowballs) {
                    throwItemCounter = 0;
                }
                _local_3.playerId = playerId;
                _local_3.id = throwItemCounter;
                _local_3.snowballType = snowballVO.type;
                _local_3.start_x = _local_10.x;
                _local_3.start_y = _local_10.y;
                _local_3.target_x = target_x;
                _local_3.target_y = target_y;
                var _local_24 = target_y / target_x;
                var _local_30;
                var _local_31;
                if ((target_x < _local_3.start_x) && (target_y < _local_3.start_y)) {
                    _local_30 = 0;
                }
                _local_3.distance = _ENGINE.findDistance(_local_3.start_x, _local_3.start_y, target_x, target_y);
                if (snowballVO.duration == -1) {
                    _local_3.duration = (_local_3.distance / 15) * SNOWBALL_SPACE_DELAY;
                } else {
                    _local_3.duration = ((_local_3.distance / 15) * SNOWBALL_SPACE_DELAY) * snowballVO.duration;
                }
                _local_3.change_x = target_x - _local_3.start_x;
                _local_3.change_y = target_y - _local_3.start_y;
                _local_3.peak = _local_3.duration / 2;
                _local_3.start_height = _local_10.y - _local_4._y;
                _local_3.max_height = _local_3.start_height + snowballVO.maxHeightOffset;
                _local_3.change_height1 = _local_3.max_height - _local_3.start_height;
                _local_3.change_height2 = -_local_3.max_height;
                _local_3.wait = snowballVO.wait;
                _local_3.w = 0;
                _local_3.t = 0;
                _local_12 = snowballVO.type.symbolName + throwItemCounter;
                snowballData[_local_12] = _local_3;
                if (_local_11[_local_12] != undefined) {
                    _local_11[_local_12].removeMovieClip();
                }
                _local_7 = _local_11.attachMovie(snowballVO.type.symbolName, _local_12, Number(1000200 + throwItemCounter), {_x:_local_3.start_x, _y:_local_3.start_y});
                if (_local_7 == undefined) {
                    _local_7 = _local_11.attachMovie("ball", _local_12, Number(1000200 + throwItemCounter), {_x:_local_3.start_x, _y:_local_3.start_y});
                }
                _local_7.art._y = _local_3.start_height;
                _local_7._visible = false;
                _local_7._xscale = (_local_7._yscale = _local_18);
                _ENGINE.updateItemDepth(_local_7, throwItemCounter);
                if (snowballVO.type.hasTail) {
                    _local_7.art._rotation = com.clubpenguin["math"].MathHelper.getAngleBetweenCoordinates(_local_10.x, _local_10.y, target_x, target_y);
                }
                if (snowballVO.type.playAbovePlayer && (_local_7.getDepth() < _local_4.getDepth())) {
                    _local_7.swapDepths(_local_4.getDepth() + 1);
                }
                if (snowballVO.type.playUnderPlayer && (_local_7.getDepth() > _local_4.getDepth())) {
                    _local_7.swapDepths(_local_4.getDepth());
                }
                if (snowballVO.type.intelligentSort) {
                    if ((_local_3.target_y > _local_3.start_y) && (_local_7.getDepth() < _local_4.getDepth())) {
                        _local_7.swapDepths(_local_4.getDepth() + 1);
                    } else if ((_local_3.target_y < _local_3.start_y) && (_local_7.getDepth() > _local_4.getDepth())) {
                        _local_7.swapDepths(_local_4);
                    }
                }
                if (snowballVO.type.delayAnimStart) {
                    _local_7.art.gotoAndStop(1);
                }
                if (snowballVO.type.playerInvisible) {
                    _local_4._visible = false;
                    _ENGINE.getNicknameMovieClip(playerId)._visible = false;
                }
                if (_local_3.snowballType.hasTrail) {
                    _local_7.art.gotoAndStop(1);
                    _local_7.art._visible = false;
                }
                throwItemCounter++;
            }
            if (playerId == _SHELL.getMyPlayerId()) {
                _local_15.startSnowballCoolDown();
            }
        }
        function update() {
            var _local_4 = _ENGINE.getRoomMovieClip();
            var _local_10 = [];
            var _local_14 = getTimer();
            for (var _local_13 in snowballData) {
                var _local_3 = _local_4[_local_13];
                var _local_2 = snowballData[_local_13];
                if (_local_2.w > _local_2.wait) {
                    _local_3._visible = true;
                    if (_local_2.snowballType.delayAnimStart && (_local_3.art._currentframe == 1)) {
                        _local_3.art.gotoAndPlay(2);
                    }
                    _local_2.t++;
                    if ((!(((((_local_3._x < 0) || (_local_3._x > Stage.width)) || (_local_3._x < 0)) || (_local_3._y > Stage.height)) || (_local_3.hit))) && (_local_2.t < (_local_2.duration * 3))) {
                        if (_local_2.snowballType.isFixed) {
                            _local_3._visible = false;
                            if (_local_2.t == 1) {
                                var _local_11 = _local_3.duplicateMovieClip("snowballTrail" + _local_2.t, _local_3.getDepth() + _local_2.t);
                                _local_11._rotation = _local_3.art._rotation;
                            }
                        } else {
                            _local_3._x = _ENGINE.mathLinearTween(_local_2.t, _local_2.start_x, _local_2.change_x, _local_2.duration);
                            _local_3._y = _ENGINE.mathLinearTween(_local_2.t, _local_2.start_y, _local_2.change_y, _local_2.duration);
                            _ENGINE.updateItemDepth(_local_3, _local_2.id);
                            if (_local_2.t < _local_2.max_height) {
                                _local_3.art._y = _ENGINE.mathEaseOutQuad(_local_2.t, _local_2.start_height, _local_2.change_height1, _local_2.peak);
                            } else {
                                _local_3.art._y = _ENGINE.mathEaseInQuad(_local_2.t - _local_2.peak, _local_2.max_height, _local_2.change_height2, _local_2.peak);
                            }
                        }
                        if (_local_2.snowballType.hasTrail) {
                            var _local_11 = _local_3.duplicateMovieClip("snowballTrail" + _local_2.t, _local_3.getDepth() + _local_2.t);
                            _local_11._rotation = _local_3.art._rotation;
                        }
                        var _local_5 = com.clubpenguin.world.rooms2014.future.FutureParty.currentRoomCollisionItems;
                        if (_local_5 != undefined) {
                            var _local_7 = 0;
                            while (_local_7 < _local_5.length) {
                                if (checkForCollision(_local_5[_local_7].target, _local_3.art)) {
                                    var _local_6 = {x:_local_2.target_x, y:_local_2.target_y};
                                    com.clubpenguin.world.rooms2014.future.FutureParty.dispatchCollision(_local_7, _local_2.playerId, _local_6);
                                    _local_3._visible = false;
                                    _local_3.hit = true;
                                    break;
                                }
                                _local_7++;
                            }
                        }
                    } else {
                        _local_3._x = _local_2.target_x;
                        _local_3._y = _local_2.target_y;
                        _local_3.art._y = 0;
                        _local_3.player_id = _local_2.playerId;
                        if (_local_4.roomFunctionality.handleThrow != undefined) {
                            _local_4.roomFunctionality.handleThrow(_local_3);
                        } else if (_local_4.room.handleThrow != undefined) {
                            _local_4.room.handleThrow(_local_3);
                        } else {
                            _local_4.handleThrow(_local_3);
                        }
                        if (_local_4.snowballBlock != undefined) {
                            if (_local_4.snowballBlock.hitTest(_local_3._x, _local_3._y, true)) {
                                _local_3._visible = false;
                            }
                        }
                        var _local_12 = new com.clubpenguin.engine.projectiles.events.SnowballEvent(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, _local_2.id, _local_3, _local_2.playerId, _local_2.snowballType);
                        _SHELL.updateListeners(_SHELL.BALL_LAND, _local_12);
                        _local_10.push(_local_13);
                    }
                } else {
                    _local_2.w++;
                }
            }
            var _local_7 = 0;
            while (_local_7 < _local_10.length) {
                delete snowballData[_local_10[_local_7]];
                _local_7++;
            }
        }
        function checkForCollision(p_clip1, p_clip2, p_alphaTolerance) {
            if (_stageMaskRectForCollision) {
                _stageMaskRectForCollision._width = Stage.width;
                _stageMaskRectForCollision._height = Stage.height;
                _stageMaskRectForCollision._x = 0;
                _stageMaskRectForCollision._y = 0;
            } else {
                _stageMaskRectForCollision = _root.createEmptyMovieClip("_stageMaskRectForCollision", _root.getNextHighestDepth());
                _stageMaskRectForCollision.beginFill(16711680, 0);
                _stageMaskRectForCollision.moveTo(0, 0);
                _stageMaskRectForCollision.lineTo(Stage.width, 0);
                _stageMaskRectForCollision.lineTo(Stage.width, Stage.height);
                _stageMaskRectForCollision.lineTo(0, Stage.height);
                _stageMaskRectForCollision.endFill();
                _stageMaskRectForCollision._x = 0;
                _stageMaskRectForCollision._y = 0;
            }
            if (p_alphaTolerance == undefined) {
                p_alphaTolerance = 255;
            }
            var _local_5 = p_clip1.getBounds(_root);
            var _local_4 = p_clip2.getBounds(_root);
            if (((_local_5.xMax < _local_4.xMin) || (_local_4.xMax < _local_5.xMin)) || ((_local_5.yMax < _local_4.yMin) || (_local_4.yMax < _local_5.yMin))) {
                return(false);
            }
            var _local_3 = {};
            _local_3.xMin = Math.max(_local_5.xMin, _local_4.xMin);
            _local_3.xMax = Math.min(_local_5.xMax, _local_4.xMax);
            _local_3.yMin = Math.max(_local_5.yMin, _local_4.yMin);
            _local_3.yMax = Math.min(_local_5.yMax, _local_4.yMax);
            var _local_7 = new flash.display.BitmapData(_stageMaskRectForCollision._width, _stageMaskRectForCollision._height, false);
            var _local_8 = p_clip1.transform.concatenatedMatrix;
            _local_8.tx = _local_8.tx - _local_3.xMin;
            _local_8.ty = _local_8.ty - _local_3.yMin;
            _local_7.draw(p_clip1, _local_8, new flash.geom.ColorTransform(1, 1, 1, 1, 255, -255, -255, p_alphaTolerance));
            var _local_6 = p_clip2.transform.concatenatedMatrix;
            _local_6.tx = _local_6.tx - _local_3.xMin;
            _local_6.ty = _local_6.ty - _local_3.yMin;
            _local_7.draw(p_clip2, _local_6, new flash.geom.ColorTransform(1, 1, 1, 1, 255, 255, 255, p_alphaTolerance), "difference");
            var _local_12 = _local_7.getColorBoundsRect(4294967295, 4278255615);
            if (_local_12.width == 0) {
                return(null);
            }
            return(true);
        }
        static var SNOWBALL_SPACE_DELAY = 1.2;
    }
