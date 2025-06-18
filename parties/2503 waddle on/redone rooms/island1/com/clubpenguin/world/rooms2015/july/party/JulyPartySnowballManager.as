//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.party.JulyPartySnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
    {
        var _INTERFACE, _ENGINE, _SHELL, maxSnowballs, throwItemCounter, snowballData, snowballHitController;
        function JulyPartySnowballManager (shell, engine, _interface) {
            super(shell, engine, _interface);
            var _local_2 = new com.clubpenguin.world.rooms2013.superhero.SnowballHitCheck();
        }
        function throwBall(playerId, target_x, target_y, snowballVO) {
            com.clubpenguin.util.Log.debug("JulyPartySnowballManager throwBall");
            var _local_7 = _INTERFACE.getIgnoreList();
            var _local_4 = 0;
            while (_local_4 < _local_7.length) {
                if (playerId == _local_7[_local_4].player_id) {
                    return(undefined);
                }
                _local_4++;
            }
            var _local_2 = {};
            var _local_3 = _ENGINE.getPlayerMovieClip(playerId);
            var _local_11 = _ENGINE.getRoomMovieClip();
            var _local_15 = _local_11.customPenguinSize;
            var _local_22 = _SHELL.getRoomObject().room_id;
            var _local_6;
            var _local_10;
            var _local_19 = _SHELL.getPlayerObjectById(playerId);
            if ((snowballVO == undefined) || (snowballVO == null)) {
                var _local_12 = com.clubpenguin.world.rooms2015.july.party.JulyParty.localPlayerAvatarID;
                snowballVO = _local_19.avatarVO.snowball;
                if (_local_12 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_BINGBONG) {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 65);
                }
                if (_local_12 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                    snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 69);
                }
            }
            if (_SHELL.getIsRoomIgloo()) {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            }
            com.clubpenguin.util.Log.debug("snowballVO wait " + snowballVO.wait);
            if (_local_3.is_reading) {
                _ENGINE.removePlayerBook(playerId);
            }
            if (_local_3.is_ready && (!_local_3.is_moving)) {
                var _local_18 = _ENGINE.findAngle(_local_3._x, _local_3._y, target_x, target_y);
                var _local_16 = _ENGINE.findDirectionQuarters(_local_18);
                var _local_17 = Number(_SHELL.DANCE_FRAME + _local_16);
                _ENGINE.updatePlayerFrame(playerId, _local_17);
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
                _local_2.start_y = _local_9.y;
                _local_2.distance = _ENGINE.findDistance(_local_2.start_x, _local_2.start_y, target_x, target_y);
                if (snowballVO.duration == -1) {
                    _local_2.duration = _local_2.distance / 15;
                } else {
                    _local_2.duration = (_local_2.distance / 15) * snowballVO.duration;
                }
                _local_2.change_x = target_x - _local_2.start_x;
                _local_2.change_y = target_y - _local_2.start_y;
                _local_2.peak = _local_2.duration / 2;
                _local_2.start_height = _local_9.y - _local_3._y;
                _local_2.max_height = _local_2.start_height + snowballVO.maxHeightOffset;
                _local_2.change_height1 = _local_2.max_height - _local_2.start_height;
                _local_2.change_height2 = -_local_2.max_height;
                _local_2.wait = snowballVO.wait;
                com.clubpenguin.util.Log.debug("snowballInfo.wait " + _local_2.wait);
                _local_2.w = 0;
                _local_2.t = 0;
                _local_10 = snowballVO.type.symbolName + throwItemCounter;
                snowballData[_local_10] = _local_2;
                if (_local_11[_local_10] != undefined) {
                    _local_11[_local_10].removeMovieClip();
                }
                _local_6 = _local_11.attachMovie(snowballVO.type.symbolName, _local_10, Number(1000200 + throwItemCounter), {_x:_local_2.start_x, _y:_local_2.start_y});
                if (_local_6 == undefined) {
                    _local_6 = _local_11.attachMovie("ball", _local_10, Number(1000200 + throwItemCounter), {_x:_local_2.start_x, _y:_local_2.start_y});
                }
                _local_6.art._y = _local_2.start_height;
                _local_6._visible = false;
                _local_6._xscale = (_local_6._yscale = _local_15);
                _ENGINE.updateItemDepth(_local_6, throwItemCounter);
                if (snowballVO.type.hasTail) {
                    _local_6.art._rotation = com.clubpenguin["math"].MathHelper.getAngleBetweenCoordinates(_local_9.x, _local_9.y, target_x, target_y);
                }
                if (snowballVO.type.playAbovePlayer && (_local_6.getDepth() < _local_3.getDepth())) {
                    _local_6.swapDepths(_local_3.getDepth() + 1);
                }
                if (snowballVO.type.playUnderPlayer && (_local_6.getDepth() > _local_3.getDepth())) {
                    _local_6.swapDepths(_local_3.getDepth());
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
            com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playSnowballImpact();
        }
    }
