//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FuturePartyLandSnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
    {
        var _SHELL, _INTERFACE, _ENGINE, maxSnowballs, throwItemCounter, snowballData;
        function FuturePartyLandSnowballManager (shell, engine, _interface) {
            super(shell, engine, _interface);
            var _local_2 = new com.clubpenguin.world.rooms2013.superhero.SnowballHitCheck();
        }
        function throwBall(playerId, target_x, target_y, snowballVO) {
            var _local_11 = _global.getCurrentParty().FutureParty;
            if ((playerId == _SHELL.getMyPlayerId()) && (!_local_11.isSnowballEnabled)) {
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
            var _local_12 = _ENGINE.getRoomMovieClip();
            var _local_19 = _local_12.customPenguinSize;
            var _local_28 = _SHELL.getRoomObject().room_id;
            var _local_7;
            var _local_13;
            var _local_23 = _SHELL.getPlayerObjectById(playerId);
            if ((snowballVO == undefined) || (snowballVO == null)) {
                var _local_24 = _SHELL.getPlayerObjectById(playerId).avatar_id;
                snowballVO = _local_23.avatarVO.snowball;
            }
            if (_SHELL.getIsRoomIgloo()) {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            } else {
                var _local_18 = _local_12.attachMovie(snowballVO.type.symbolName, "testSnowball", 1);
                if (_local_18 == undefined) {
                    _local_11.pebug("trial snowball loaded");
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                } else {
                    _local_18.removeMovieClip();
                }
            }
            if (_local_11.MECHCONTROLLER.isPlayerMech(playerId)) {
                var _local_16 = _local_11.MECHCONTROLLER.getRobotType(playerId);
                if (_local_16 != -1) {
                    var _local_17;
                    if (_local_16 == 0) {
                        _local_17 = 15;
                    }
                    if (_local_16 == 1) {
                        _local_17 = 7;
                    }
                    if (_local_16 == 2) {
                        _local_17 = 6;
                    }
                    _local_11.pebug((("snowball delay for robot " + _local_16) + " is ") + _local_17);
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, _local_17);
                }
            }
            if (_local_4.is_reading) {
                _ENGINE.removePlayerBook(playerId);
            }
            if (_local_4.is_ready && (!_local_4.is_moving)) {
                var _local_22 = _ENGINE.findAngle(_local_4._x, _local_4._y, target_x, target_y);
                var _local_20 = _ENGINE.findDirectionQuarters(_local_22);
                var _local_21 = Number(_SHELL.DANCE_FRAME + _local_20);
                _ENGINE.updatePlayerFrame(playerId, _local_21);
                var _local_10;
                if (_local_11.MECHCONTROLLER.isPlayerMech(playerId) && (_local_11.MECHCONTROLLER.getRobotType(playerId) == 2)) {
                    _local_10 = {x:_local_4._x, y:Number(_local_4._y) - 40};
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
                var _local_25 = target_y / target_x;
                var _local_31;
                var _local_32;
                if ((target_x < _local_3.start_x) && (target_y < _local_3.start_y)) {
                    _local_31 = 0;
                }
                _local_3.distance = _ENGINE.findDistance(_local_3.start_x, _local_3.start_y, target_x, target_y);
                if (snowballVO.duration == -1) {
                    _local_3.duration = _local_3.distance / 15;
                } else {
                    _local_3.duration = (_local_3.distance / 15) * snowballVO.duration;
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
                _local_13 = snowballVO.type.symbolName + throwItemCounter;
                snowballData[_local_13] = _local_3;
                if (_local_12[_local_13] != undefined) {
                    _local_12[_local_13].removeMovieClip();
                }
                _local_7 = _local_12.attachMovie(snowballVO.type.symbolName, _local_13, Number(1000200 + throwItemCounter), {_x:_local_3.start_x, _y:_local_3.start_y});
                if (_local_7 == undefined) {
                    _local_7 = _local_12.attachMovie("ball", _local_13, Number(1000200 + throwItemCounter), {_x:_local_3.start_x, _y:_local_3.start_y});
                }
                _local_7.art._y = _local_3.start_height;
                _local_7._visible = false;
                _local_7._xscale = (_local_7._yscale = _local_19);
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
        }
    }
