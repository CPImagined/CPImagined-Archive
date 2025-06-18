//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.SnowballManager
    {
        var _SHELL, _ENGINE, _INTERFACE, snowballHitController, maxSnowballs, throwItemCounter, snowballData, lastUpdate;
        function SnowballManager (_arg_3, _arg_4, _arg_2) {
            _SHELL = _arg_3;
            _ENGINE = _arg_4;
            _INTERFACE = _arg_2;
            snowballHitController = new com.clubpenguin.engine.projectiles.SnowballHitController(_SHELL, _INTERFACE);
            maxSnowballs = 10;
            resetData();
            _SHELL.addListener(_SHELL.BALL_LAND, com.clubpenguin.util.Delegate.create(this, onBallLand));
            _SHELL.addListener(_SHELL.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, resetData));
        }
        function setMaxSnowballs(_arg_2) {
            maxSnowballs = _arg_2;
        }
        function throwBall(_arg_8, _arg_12, _arg_13, _arg_6) {
            var _local_7 = _INTERFACE.getIgnoreList();
            var _local_4 = 0;
            while (_local_4 < _local_7.length) {
                if (_arg_8 == _local_7[_local_4].player_id) {
                    return(undefined);
                }
                _local_4++;
            }
            var _local_2 = {};
            var _local_3 = _ENGINE.getPlayerMovieClip(_arg_8);
            var _local_10 = _ENGINE.getRoomMovieClip();
            var _local_15 = _local_10.customPenguinSize;
            var _local_22 = _SHELL.getRoomObject().room_id;
            var _local_5;
            var _local_11;
            var _local_18 = _SHELL.getPlayerObjectById(_arg_8);
            if ((_arg_6 == undefined) || (_arg_6 == null)) {
                var _local_19 = _SHELL.getPlayerObjectById(_arg_8).avatarVO.avatar_id;
                _arg_6 = _local_18.avatarVO.snowball;
            }
            if (_SHELL.getIsRoomIgloo() || (_ENGINE.playerHostedRoomType == com.clubpenguin.world.rooms.common.RoomConstants.PLAYER_HOSTED_ROOM_BACKYARD)) {
                _arg_6 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            } else {
                var _local_14 = _local_10.attachMovie(_arg_6.type.symbolName, "testSnowball", 1);
                if (_local_14 == undefined) {
                    _arg_6 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                } else {
                    _local_14.removeMovieClip();
                }
            }
            if (_local_3.is_reading) {
                _ENGINE.removePlayerBook(_arg_8);
            }
            if (_local_3.is_ready && (!_local_3.is_moving)) {
                var _local_17 = _ENGINE.findAngle(_local_3._x, _local_3._y, _arg_12, _arg_13);
                var _local_16 = _ENGINE.findDirectionQuarters(_local_17);
                _ENGINE.updatePlayerFrame(_arg_8, _SHELL.DANCE_FRAME + _local_16);
                var _local_9;
                if (((_local_3.art_mc.body.snowballOrigin == undefined) || (_local_3.art_mc.body.snowballOrigin == undefined)) || (_local_3.art_mc.body.localToGlobal == undefined)) {
                    _local_9 = {x:_local_3._x, y:_local_3._y};
                } else if (_arg_6.type.originAtHead) {
                    _local_9 = {x:_local_3._x, y:Number(_local_3._y - (_local_3.art_mc._height / 2))};
                } else if (_arg_6.type.originAtCenter) {
                    _local_9 = {x:_local_3._x, y:Number(_local_3._y - (_local_3.art_mc._height / 5))};
                } else {
                    _local_9 = {x:_local_3.art_mc.body.snowballOrigin._x, y:_local_3.art_mc.body.snowballOrigin._y};
                    _local_3.art_mc.body.localToGlobal(_local_9);
                }
                if (throwItemCounter >= maxSnowballs) {
                    throwItemCounter = 0;
                }
                _local_2.playerId = _arg_8;
                _local_2.id = throwItemCounter;
                _local_2.snowballType = _arg_6.type;
                _local_2.start_x = _local_9.x;
                _local_2.start_y = _local_3._y;
                _local_2.distance = _ENGINE.findDistance(_local_2.start_x, _local_2.start_y, _arg_12, _arg_13);
                _local_2.duration = _local_2.distance / 15;
                _local_2.change_x = _arg_12 - _local_2.start_x;
                _local_2.change_y = _arg_13 - _local_2.start_y;
                _local_2.peak = _local_2.duration / 2;
                _local_2.start_height = _local_9.y - _local_3._y;
                _local_2.max_height = _local_2.start_height + _arg_6.maxHeightOffset;
                _local_2.change_height1 = _local_2.max_height - _local_2.start_height;
                _local_2.change_height2 = -_local_2.max_height;
                _local_2.wait = _arg_6.wait;
                _local_2.w = 0;
                _local_2.t = 0;
                _local_11 = _arg_6.type.symbolName + throwItemCounter;
                snowballData[_local_11] = _local_2;
                if (_local_10[_local_11] != undefined) {
                    _local_10[_local_11].removeMovieClip();
                }
                _local_5 = _local_10.attachMovie(_arg_6.type.symbolName, _local_11, Number(1000200 + throwItemCounter), {_x:_local_2.start_x, _y:_local_2.start_y});
                if (_local_5 == undefined) {
                    _local_5 = _local_10.attachMovie("ball", _local_11, Number(1000200 + throwItemCounter), {_x:_local_2.start_x, _y:_local_2.start_y});
                }
                _local_5.art._y = _local_2.start_height;
                _local_5._visible = false;
                _local_5._xscale = (_local_5._yscale = _local_15);
                _ENGINE.updateItemDepth(_local_5, throwItemCounter);
                if (_arg_6.type.hasTail) {
                    _local_5.art._rotation = com.clubpenguin["math"].MathHelper.getAngleBetweenCoordinates(_local_9.x, _local_9.y, _arg_12, _arg_13);
                }
                if (_arg_6.type.playAbovePlayer && (_local_5.getDepth() < _local_3.getDepth())) {
                    _local_5.swapDepths(_local_3.getDepth() + 1);
                }
                if (_arg_6.type.intelligentSort) {
                    if ((_local_2.target_y > _local_2.start_y) && (_local_5.getDepth() < _local_3.getDepth())) {
                        _local_5.swapDepths(_local_3.getDepth() + 1);
                    } else if ((_local_2.target_y < _local_2.start_y) && (_local_5.getDepth() > _local_3.getDepth())) {
                        _local_5.swapDepths(_local_3);
                    }
                }
                if (_arg_6.type.delayAnimStart) {
                    _local_5.art.gotoAndStop(1);
                }
                if (_arg_6.type.playerInvisible) {
                    _local_3._visible = false;
                    _ENGINE.getNicknameMovieClip(_arg_8)._visible = false;
                }
                if (_local_2.snowballType.hasTrail) {
                    _local_5.art.gotoAndStop(1);
                    _local_5.art._visible = false;
                }
                throwItemCounter++;
            }
        }
        function onBallLand(_arg_3) {
            var _local_2 = _ENGINE.avatarManager.model.getSnowballHitCheck(_arg_3.snowballType);
            snowballHitController.playerSnowballHitCheck(_arg_3, _local_2);
        }
        function update() {
            var _local_4 = _ENGINE.getRoomMovieClip();
            var _local_6 = [];
            var _local_10 = getTimer();
            for (var _local_9 in snowballData) {
                var _local_3 = _local_4[_local_9];
                var _local_2 = snowballData[_local_9];
                if (_local_2.w > _local_2.wait) {
                    _local_3._visible = true;
                    if (_local_2.snowballType.delayAnimStart && (_local_3.art._currentframe == 1)) {
                        _local_3.art.gotoAndPlay(2);
                    }
                    _local_2.t++;
                    if (_local_2.t < _local_2.duration) {
                        if (_local_2.snowballType.isFixed) {
                            _local_3._visible = false;
                            if (_local_2.t == 1) {
                                var _local_7 = _local_3.duplicateMovieClip("snowballTrail" + _local_2.t, _local_3.getDepth() + _local_2.t);
                                _local_7._rotation = _local_3.art._rotation;
                            }
                        } else {
                            _local_3._x = _ENGINE.mathLinearTween(_local_2.t, _local_2.start_x, _local_2.change_x, _local_2.duration);
                            _local_3._y = _ENGINE.mathLinearTween(_local_2.t, _local_2.start_y, _local_2.change_y, _local_2.duration);
                            _ENGINE.updateItemDepth(_local_3, _local_2.id);
                            if (_local_2.t < _local_2.peak) {
                                _local_3.art._y = _ENGINE.mathEaseOutQuad(_local_2.t, _local_2.start_height, _local_2.change_height1, _local_2.peak);
                            } else {
                                _local_3.art._y = _ENGINE.mathEaseInQuad(_local_2.t - _local_2.peak, _local_2.max_height, _local_2.change_height2, _local_2.peak);
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
                        var _local_8 = new com.clubpenguin.engine.projectiles.events.SnowballEvent(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, _local_2.id, _local_3, _local_2.playerId, _local_2.snowballType);
                        _SHELL.updateListeners(_SHELL.BALL_LAND, _local_8);
                        _local_6.push(_local_9);
                    }
                } else {
                    _local_2.w++;
                }
            }
            var _local_5 = 0;
            while (_local_5 < _local_6.length) {
                delete snowballData[_local_6[_local_5]];
                _local_5++;
            }
        }
        function resetData() {
            throwItemCounter = 0;
            lastUpdate = getTimer();
            snowballData = {};
        }
    }
