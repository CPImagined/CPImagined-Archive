//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
    {
        var _INTERFACE, _ENGINE, maxSnowballs, _SHELL, throwItemCounter, snowballData;
        function FrozenPartySnowballManager (shell, engine, _interface) {
            super(shell, engine, _interface);
            _INTERFACE = _interface;
            _ENGINE = engine;
            var _local_3 = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
            maxSnowballs = 20;
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, _local_3);
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, _local_3);
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE, _local_3);
        }
        function throwBall(playerId, target_x, target_y, snowballVO) {
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
            var _local_17 = _local_11.customPenguinSize;
            var _local_25 = _SHELL.getRoomObject().room_id;
            var _local_7;
            var _local_12;
            var _local_21 = _SHELL.getPlayerObjectById(playerId);
            if ((snowballVO == undefined) || (snowballVO == null)) {
                _global.getCurrentParty().FrozenParty.pebug("Check snowball for frozen one");
                var _local_15 = _SHELL.getPlayerObjectById(playerId).avatar_id;
                snowballVO = _local_21.avatarVO.snowball;
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                if ((playerId == _SHELL.getMyPlayerId()) && (_global.getCurrentParty().FrozenParty.hasFrozenPowers())) {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20);
                }
                if (_local_15 == _global.getCurrentParty().FrozenParty.CONSTANTS.OLAF_TRANSFORMATION_ID) {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20);
                }
                if (_local_15 == _global.getCurrentParty().FrozenParty.CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID) {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE, -100, 50);
                }
            }
            if (_SHELL.getIsRoomIgloo()) {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            } else {
                var _local_16 = _local_11.attachMovie(snowballVO.type.symbolName, "testSnowball", 1);
                if (_local_16 == undefined) {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                } else {
                    _local_16.removeMovieClip();
                }
            }
            if (_local_4.is_reading) {
                _ENGINE.removePlayerBook(playerId);
            }
            if (_local_4.is_ready && (!_local_4.is_moving)) {
                var _local_20 = _ENGINE.findAngle(_local_4._x, _local_4._y, target_x, target_y);
                var _local_18 = _ENGINE.findDirectionQuarters(_local_20);
                var _local_19 = Number(_SHELL.DANCE_FRAME + _local_18);
                _ENGINE.updatePlayerFrame(playerId, _local_19);
                var _local_10;
                if (snowballVO.type == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LASER) {
                    _local_10 = {x:Number(_local_4._x - 10), y:Number(_local_4._y - (_local_4.art_mc._height / 2))};
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
                var _local_22 = target_y / target_x;
                var _local_28;
                var _local_29;
                if ((target_x < _local_3.start_x) && (target_y < _local_3.start_y)) {
                    _local_28 = 0;
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
                _local_7._xscale = (_local_7._yscale = _local_17);
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
                _global.getCurrentParty().FrozenParty.startSnowballCoolDown();
            }
        }
    }
