//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trainroom.CFCSnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
    {
        var _SHELL, _ENGINE, _INTERFACE, snowballHitController, maxSnowballs, resetData, onBallLand, throwItemCounter, snowballData;
        function CFCSnowballManager (shell, engine, _interface) {
            super();
            _SHELL = shell;
            _ENGINE = engine;
            _INTERFACE = _interface;
            snowballHitController = new com.clubpenguin.engine.projectiles.SnowballHitController(_SHELL, _INTERFACE);
            maxSnowballs = 10;
            resetData();
            _SHELL.addListener(_SHELL.BALL_LAND, com.clubpenguin.util.Delegate.create(this, onBallLand));
            _SHELL.addListener(_SHELL.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, resetData));
        }
        function throwBall(playerId, target_x, target_y, snowballVO) {
            if ((playerId == _SHELL.getMyPlayerId()) && (!_global.getCurrentParty().CFCParty.isSnowballEnabled)) {
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
            var _local_16 = _local_11.customPenguinSize;
            var _local_23 = _SHELL.getRoomObject().room_id;
            var _local_6;
            var _local_12;
            var _local_19 = _SHELL.getPlayerObjectById(playerId);
            if ((snowballVO == undefined) || (snowballVO == null)) {
                var _local_20 = _SHELL.getPlayerObjectById(playerId).avatarVO.avatar_id;
                snowballVO = _local_19.avatarVO.snowball;
            }
            if (_SHELL.getIsRoomIgloo()) {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            } else {
                var _local_15 = _local_11.attachMovie(snowballVO.type.symbolName, "testSnowball", 1);
                if (_local_15 == undefined) {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 0);
                } else {
                    _local_15.removeMovieClip();
                }
            }
            if (_local_4.is_reading) {
                _ENGINE.removePlayerBook(playerId);
            }
            if (_local_4.is_ready && (!_local_4.is_moving)) {
                var _local_18 = _ENGINE.findAngle(_local_4._x, _local_4._y, target_x, target_y);
                var _local_17 = _ENGINE.findDirectionQuarters(_local_18);
                _ENGINE.updatePlayerFrame(playerId, _SHELL.DANCE_FRAME + _local_17);
                var _local_10;
                if (((_local_4.art_mc.body.snowballOrigin == undefined) || (_local_4.art_mc.body.snowballOrigin == undefined)) || (_local_4.art_mc.body.localToGlobal == undefined)) {
                    _local_10 = {x:_local_4._x, y:_local_4._y};
                } else if (snowballVO.type.originAtHead) {
                    _local_10 = {x:_local_4._x, y:Number(_local_4._y - (_local_4.art_mc._height / 2))};
                } else if (snowballVO.type.originAtCenter) {
                    _local_10 = {x:_local_4._x, y:Number(_local_4._y - (_local_4.art_mc._height / 5))};
                } else {
                    _local_10 = {x:_local_4.art_mc.body.snowballOrigin._x, y:_local_4.art_mc.body.snowballOrigin._y};
                    _local_4.art_mc.body.localToGlobal(_local_10);
                }
                if (throwItemCounter >= maxSnowballs) {
                    throwItemCounter = 0;
                }
                _local_3.playerId = playerId;
                _local_3.id = throwItemCounter;
                _local_3.snowballType = snowballVO.type;
                _local_3.start_x = _local_10.x;
                _local_3.start_y = _local_4._y;
                _local_3.distance = _ENGINE.findDistance(_local_3.start_x, _local_3.start_y, target_x, target_y);
                _local_3.duration = _local_3.distance / 15;
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
                _local_6 = _local_11.attachMovie(snowballVO.type.symbolName, _local_12, Number(1000200 + throwItemCounter), {_x:_local_3.start_x, _y:_local_3.start_y});
                if (_local_6 == undefined) {
                    _local_6 = _local_11.attachMovie("ball", _local_12, Number(1000200 + throwItemCounter), {_x:_local_3.start_x, _y:_local_3.start_y});
                }
                _local_6.art._y = _local_3.start_height;
                _local_6._visible = false;
                _local_6._xscale = (_local_6._yscale = _local_16);
                _ENGINE.updateItemDepth(_local_6, throwItemCounter);
                if (snowballVO.type.hasTail) {
                    _local_6.art._rotation = com.clubpenguin["math"].MathHelper.getAngleBetweenCoordinates(_local_10.x, _local_10.y, target_x, target_y);
                }
                if (snowballVO.type.playAbovePlayer && (_local_6.getDepth() < _local_4.getDepth())) {
                    _local_6.swapDepths(_local_4.getDepth() + 1);
                }
                if (snowballVO.type.intelligentSort) {
                    if ((_local_3.target_y > _local_3.start_y) && (_local_6.getDepth() < _local_4.getDepth())) {
                        _local_6.swapDepths(_local_4.getDepth() + 1);
                    } else if ((_local_3.target_y < _local_3.start_y) && (_local_6.getDepth() > _local_4.getDepth())) {
                        _local_6.swapDepths(_local_4);
                    }
                }
                if (snowballVO.type.delayAnimStart) {
                    _local_6.art.gotoAndStop(1);
                }
                if (snowballVO.type.playerInvisible) {
                    _local_4._visible = false;
                    _ENGINE.getNicknameMovieClip(playerId)._visible = false;
                }
                if (_local_3.snowballType.hasTrail) {
                    _local_6.art.gotoAndStop(1);
                    _local_6.art._visible = false;
                }
                throwItemCounter++;
            }
            if (playerId == _SHELL.getMyPlayerId()) {
                _global.getCurrentParty().CFCParty.startSnowballCoolDown();
            }
        }
    }
