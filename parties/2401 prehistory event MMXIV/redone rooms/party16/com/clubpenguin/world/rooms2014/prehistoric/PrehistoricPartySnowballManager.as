//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartySnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
    {
        var _ENGINE, _INTERFACE, _SHELL, maxSnowballs, throwItemCounter, snowballData, snowballHitController;
        function PrehistoricPartySnowballManager (shell, engine, _interface) {
            super(shell, engine, _interface);
            var _local_3 = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
            _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FOOD, _local_3);
        }
        function throwBall(playerId, target_x, target_y, snowballVO) {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("ENTERING PREHISTORIC SNOWBALL MANAGER THROW THE BALL");
            var _local_8 = _INTERFACE.getIgnoreList();
            var _local_4 = 0;
            while (_local_4 < _local_8.length) {
                if (playerId == _local_8[_local_4].player_id) {
                    return(undefined);
                }
                _local_4++;
            }
            var _local_2 = {};
            var _local_3 = _ENGINE.getPlayerMovieClip(playerId);
            var _local_10 = _ENGINE.getRoomMovieClip();
            var _local_17 = _local_10.customPenguinSize;
            var _local_23 = _SHELL.getRoomObject().room_id;
            var _local_6;
            var _local_11;
            var _local_13 = _SHELL.getPlayerObjectById(playerId);
            if ((snowballVO == undefined) || (snowballVO == null)) {
                com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("snowballVO == undefined || snowballVO == null");
                var _local_20 = _SHELL.getPlayerObjectById(playerId).avatarVO.avatar_id;
                snowballVO = _local_13.avatarVO.snowball;
                var _local_12 = com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isDinosaur(playerId);
                if (_local_12) {
                    com.clubpenguin.world.rooms2014.prehistoric.DinoSounds.onDinoThrowStart(_SHELL.getPlayerObjectById(playerId));
                }
                if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isPrehistoricRoom && (!_local_12)) {
                    com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("In a prehistoric room, using a food snowball");
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FOOD, -50, 20, 0.5);
                }
            }
            if (_SHELL.getIsRoomIgloo()) {
                if (_local_12) {
                    snowballVO = _local_13.avatarVO.snowball;
                } else {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                }
            } else {
                com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("throwBall():!_SHELL.getIsRoomIgloo()");
                var _local_16 = _local_10.attachMovie(snowballVO.type.symbolName, "testSnowball", 1);
                if (_local_16 == undefined) {
                    com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("trialSnowballLoad == undefined");
                    if (_local_12) {
                        snowballVO = _local_13.avatarVO.snowball;
                    } else {
                        snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
                    }
                } else {
                    com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("trialSnowballLoad != undefined");
                    _local_16.removeMovieClip();
                }
            }
            if (_local_3.is_reading) {
                _ENGINE.removePlayerBook(playerId);
            }
            if (_local_3.is_ready && (!_local_3.is_moving)) {
                var _local_19 = _ENGINE.findAngle(_local_3._x, _local_3._y, target_x, target_y);
                var _local_18 = _ENGINE.findDirectionQuarters(_local_19);
                _ENGINE.updatePlayerFrame(playerId, _SHELL.DANCE_FRAME + _local_18);
                var _local_9;
                if (((_local_3.art_mc.body.snowballOrigin == undefined) || (_local_3.art_mc.body.snowballOrigin == undefined)) || (_local_3.art_mc.body.localToGlobal == undefined)) {
                    _local_9 = {x:_local_3._x, y:_local_3._y};
                } else if (snowballVO.type.originAtHead) {
                    _local_9 = {x:_local_3._x, y:Number(_local_3._y - (_local_3.art_mc._height / 2))};
                } else if (snowballVO.type.originAtCenter) {
                    _local_9 = {x:_local_3._x, y:Number(_local_3._y - (_local_3.art_mc._height / 5))};
                } else {
                    _local_9 = {x:_local_3.art_mc.body.snowballOrigin._x, y:_local_3.art_mc.body.snowballOrigin._y};
                    _local_3.art_mc.body.localToGlobal(_local_9);
                }
                if (throwItemCounter >= maxSnowballs) {
                    throwItemCounter = 0;
                }
                _local_2.playerId = playerId;
                _local_2.id = throwItemCounter;
                _local_2.snowballType = snowballVO.type;
                _local_2.start_x = _local_9.x;
                _local_2.start_y = _local_3._y;
                _local_2.distance = _ENGINE.findDistance(_local_2.start_x, _local_2.start_y, target_x, target_y);
                _local_2.duration = _local_2.distance / 15;
                _local_2.change_x = target_x - _local_2.start_x;
                _local_2.change_y = target_y - _local_2.start_y;
                _local_2.peak = _local_2.duration / 2;
                _local_2.start_height = _local_9.y - _local_3._y;
                _local_2.max_height = _local_2.start_height + snowballVO.maxHeightOffset;
                _local_2.change_height1 = _local_2.max_height - _local_2.start_height;
                _local_2.change_height2 = -_local_2.max_height;
                _local_2.wait = snowballVO.wait;
                _local_2.w = 0;
                _local_2.t = 0;
                _local_11 = snowballVO.type.symbolName + throwItemCounter;
                snowballData[_local_11] = _local_2;
                if (_local_10[_local_11] != undefined) {
                    _local_10[_local_11].removeMovieClip();
                }
                _local_6 = _local_10.attachMovie(snowballVO.type.symbolName, _local_11, Number(1000200 + throwItemCounter), {_x:_local_2.start_x, _y:_local_2.start_y});
                if (_local_6 == undefined) {
                    _local_6 = _local_10.attachMovie("ball", _local_11, Number(1000200 + throwItemCounter), {_x:_local_2.start_x, _y:_local_2.start_y});
                }
                _local_6.art._y = _local_2.start_height;
                _local_6._visible = false;
                _local_6._xscale = (_local_6._yscale = _local_17);
                _ENGINE.updateItemDepth(_local_6, throwItemCounter);
                if (snowballVO.type.hasTail) {
                    _local_6.art._rotation = com.clubpenguin["math"].MathHelper.getAngleBetweenCoordinates(_local_9.x, _local_9.y, target_x, target_y);
                }
                if (snowballVO.type.playAbovePlayer && (_local_6.getDepth() < _local_3.getDepth())) {
                    _local_6.swapDepths(_local_3.getDepth() + 1);
                }
                if (snowballVO.type.intelligentSort) {
                    if ((_local_2.target_y > _local_2.start_y) && (_local_6.getDepth() < _local_3.getDepth())) {
                        _local_6.swapDepths(_local_3.getDepth() + 1);
                    } else if ((_local_2.target_y < _local_2.start_y) && (_local_6.getDepth() > _local_3.getDepth())) {
                        _local_6.swapDepths(_local_3);
                    }
                }
                if (snowballVO.type.delayAnimStart) {
                    _local_6.art.gotoAndStop(1);
                }
                if (snowballVO.type.playerInvisible) {
                    _local_3._visible = false;
                    _ENGINE.getNicknameMovieClip(playerId)._visible = false;
                }
                if (_local_2.snowballType.hasTrail) {
                    _local_6.art.gotoAndStop(1);
                    _local_6.art._visible = false;
                }
                throwItemCounter++;
            }
        }
        function onBallLand(event) {
            var _local_2 = _ENGINE.avatarManager.model.getSnowballHitCheck(event.snowballType);
            snowballHitController.playerSnowballHitCheck(event, _local_2);
        }
    }
