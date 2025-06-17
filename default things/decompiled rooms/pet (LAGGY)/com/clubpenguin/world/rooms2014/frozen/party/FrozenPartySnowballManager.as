//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
    {
        var _INTERFACE, _ENGINE, maxSnowballs, _SHELL, throwItemCounter, snowballData;
        function FrozenPartySnowballManager (_arg_6, _arg_5, _arg_4) {
            super(_arg_6, _arg_5, _arg_4);
            _INTERFACE = _arg_4;
            _ENGINE = _arg_5;
            var _local_3 = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
            maxSnowballs = 20;
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, _local_3);
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, _local_3);
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE, _local_3);
        }
        function throwBall(_arg_8, _arg_13, _arg_14, _arg_6) {
            var _local_9 = _INTERFACE.getIgnoreList();
            var _local_5 = 0;
            while (_local_5 < _local_9.length) {
                if (_arg_8 == _local_9[_local_5].player_id) {
                    return(undefined);
                }
                _local_5++;
            }
            var _local_3 = {};
            var _local_4 = _ENGINE.getPlayerMovieClip(_arg_8);
            var _local_11 = _ENGINE.getRoomMovieClip();
            var _local_17 = _local_11.customPenguinSize;
            var _local_25 = _SHELL.getRoomObject().room_id;
            var _local_7;
            var _local_12;
            var _local_21 = _SHELL.getPlayerObjectById(_arg_8);
            if ((_arg_6 == undefined) || (_arg_6 == null)) {
                _global.getCurrentParty().FrozenParty.pebug("Check snowball for frozen one");
                var _local_15 = _SHELL.getPlayerObjectById(_arg_8).avatar_id;
                _arg_6 = _local_21.avatarVO.snowball;
                _arg_6 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                if ((_arg_8 == _SHELL.getMyPlayerId()) && (_global.getCurrentParty().FrozenParty.hasFrozenPowers())) {
                    _arg_6 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20);
                }
                if (_local_15 == _global.getCurrentParty().FrozenParty.CONSTANTS.OLAF_TRANSFORMATION_ID) {
                    _arg_6 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20);
                }
                if (_local_15 == _global.getCurrentParty().FrozenParty.CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID) {
                    _arg_6 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE, -100, 50);
                }
            }
            if (_SHELL.getIsRoomIgloo()) {
                _arg_6 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            } else {
                var _local_16 = _local_11.attachMovie(_arg_6.type.symbolName, "testSnowball", 1);
                if (_local_16 == undefined) {
                    _arg_6 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                } else {
                    _local_16.removeMovieClip();
                }
            }
            if (_local_4.is_reading) {
                _ENGINE.removePlayerBook(_arg_8);
            }
            if (_local_4.is_ready && (!_local_4.is_moving)) {
                var _local_20 = _ENGINE.findAngle(_local_4._x, _local_4._y, _arg_13, _arg_14);
                var _local_18 = _ENGINE.findDirectionQuarters(_local_20);
                var _local_19 = Number(_SHELL.DANCE_FRAME + _local_18);
                _ENGINE.updatePlayerFrame(_arg_8, _local_19);
                var _local_10;
                if (_arg_6.type == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LASER) {
                    _local_10 = {x:Number(_local_4._x - 10), y:Number(_local_4._y - (_local_4.art_mc._height / 2))};
                } else if (((_local_4.art_mc.body.snowballOrigin == undefined) || (_local_4.art_mc.body.snowballOrigin == undefined)) || (_local_4.art_mc.body.localToGlobal == undefined)) {
                    _local_10 = {x:_local_4._x, y:_local_4._y};
                } else if (_arg_6.type.originAtHead) {
                    _local_10 = {x:_local_4._x, y:Number(_local_4._y - (_local_4.art_mc._height / 2))};
                } else if (_arg_6.type.originAtCenter) {
                    _local_10 = {x:_local_4._x, y:Number(_local_4._y - (_local_4.art_mc._height / 5))};
                } else {
                    _local_10 = {x:_local_4._x, y:_local_4._y};
                }
                if (throwItemCounter >= maxSnowballs) {
                    throwItemCounter = 0;
                }
                _local_3.playerId = _arg_8;
                _local_3.id = throwItemCounter;
                _local_3.snowballType = _arg_6.type;
                _local_3.start_x = _local_10.x;
                _local_3.start_y = _local_10.y;
                _local_3.target_x = _arg_13;
                _local_3.target_y = _arg_14;
                var _local_22 = _arg_14 / _arg_13;
                var _local_28;
                var _local_29;
                if ((_arg_13 < _local_3.start_x) && (_arg_14 < _local_3.start_y)) {
                    _local_28 = 0;
                }
                _local_3.distance = _ENGINE.findDistance(_local_3.start_x, _local_3.start_y, _arg_13, _arg_14);
                if (_arg_6.duration == -1) {
                    _local_3.duration = _local_3.distance / 15;
                } else {
                    _local_3.duration = (_local_3.distance / 15) * _arg_6.duration;
                }
                _local_3.change_x = _arg_13 - _local_3.start_x;
                _local_3.change_y = _arg_14 - _local_3.start_y;
                _local_3.peak = _local_3.duration / 2;
                _local_3.start_height = _local_10.y - _local_4._y;
                _local_3.max_height = _local_3.start_height + _arg_6.maxHeightOffset;
                _local_3.change_height1 = _local_3.max_height - _local_3.start_height;
                _local_3.change_height2 = -_local_3.max_height;
                _local_3.wait = _arg_6.wait;
                _local_3.w = 0;
                _local_3.t = 0;
                _local_12 = _arg_6.type.symbolName + throwItemCounter;
                snowballData[_local_12] = _local_3;
                if (_local_11[_local_12] != undefined) {
                    _local_11[_local_12].removeMovieClip();
                }
                _local_7 = _local_11.attachMovie(_arg_6.type.symbolName, _local_12, Number(1000200 + throwItemCounter), {_x:_local_3.start_x, _y:_local_3.start_y});
                if (_local_7 == undefined) {
                    _local_7 = _local_11.attachMovie("ball", _local_12, Number(1000200 + throwItemCounter), {_x:_local_3.start_x, _y:_local_3.start_y});
                }
                _local_7.art._y = _local_3.start_height;
                _local_7._visible = false;
                _local_7._xscale = (_local_7._yscale = _local_17);
                _ENGINE.updateItemDepth(_local_7, throwItemCounter);
                if (_arg_6.type.hasTail) {
                    _local_7.art._rotation = com.clubpenguin["math"].MathHelper.getAngleBetweenCoordinates(_local_10.x, _local_10.y, _arg_13, _arg_14);
                }
                if (_arg_6.type.playAbovePlayer && (_local_7.getDepth() < _local_4.getDepth())) {
                    _local_7.swapDepths(_local_4.getDepth() + 1);
                }
                if (_arg_6.type.playUnderPlayer && (_local_7.getDepth() > _local_4.getDepth())) {
                    _local_7.swapDepths(_local_4.getDepth());
                }
                if (_arg_6.type.intelligentSort) {
                    if ((_local_3.target_y > _local_3.start_y) && (_local_7.getDepth() < _local_4.getDepth())) {
                        _local_7.swapDepths(_local_4.getDepth() + 1);
                    } else if ((_local_3.target_y < _local_3.start_y) && (_local_7.getDepth() > _local_4.getDepth())) {
                        _local_7.swapDepths(_local_4);
                    }
                }
                if (_arg_6.type.delayAnimStart) {
                    _local_7.art.gotoAndStop(1);
                }
                if (_arg_6.type.playerInvisible) {
                    _local_4._visible = false;
                    _ENGINE.getNicknameMovieClip(_arg_8)._visible = false;
                }
                if (_local_3.snowballType.hasTrail) {
                    _local_7.art.gotoAndStop(1);
                    _local_7.art._visible = false;
                }
                throwItemCounter++;
            }
            if (_arg_8 == _SHELL.getMyPlayerId()) {
                _global.getCurrentParty().FrozenParty.startSnowballCoolDown();
            }
        }
    }
