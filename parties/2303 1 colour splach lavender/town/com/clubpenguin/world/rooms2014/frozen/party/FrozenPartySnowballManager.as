class com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
{
    var _INTERFACE, _ENGINE, maxSnowballs, _SHELL, throwItemCounter, snowballData;
    function FrozenPartySnowballManager(shell, engine, _interface)
    {
        super(shell, engine, _interface);
        _INTERFACE = _interface;
        _ENGINE = engine;
        var _loc3 = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
        maxSnowballs = 20;
        _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, _loc3);
        _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, _loc3);
        _ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE, _loc3);
    } // End of the function
    function throwBall(playerId, target_x, target_y, snowballVO)
    {
        var _loc9 = _INTERFACE.getIgnoreList();
        for (var _loc5 = 0; _loc5 < _loc9.length; ++_loc5)
        {
            if (playerId == _loc9[_loc5].player_id)
            {
                return;
            } // end if
        } // end of for
        var _loc3 = {};
        var _loc4 = _ENGINE.getPlayerMovieClip(playerId);
        var _loc11 = _ENGINE.getRoomMovieClip();
        var _loc17 = _loc11.customPenguinSize;
        var _loc25 = _SHELL.getRoomObject().room_id;
        var _loc7;
        var _loc12;
        var _loc21 = _SHELL.getPlayerObjectById(playerId);
        if (snowballVO == undefined || snowballVO == null)
        {
            var _loc15 = _SHELL.getPlayerObjectById(playerId).avatar_id;
            snowballVO = _loc21.avatarVO.snowball;
            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            if (playerId == _SHELL.getMyPlayerId() && _global.getCurrentParty().FrozenParty.hasFrozenPowers())
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20);
            } // end if
            if (_loc15 == _global.getCurrentParty().FrozenParty.CONSTANTS.OLAF_TRANSFORMATION_ID)
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20);
            } // end if
            if (_loc15 == _global.getCurrentParty().FrozenParty.CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID)
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE, -100, 50);
            } // end if
        } // end if
        if (_SHELL.getIsRoomIgloo())
        {
            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
        }
        else
        {
            var _loc16 = _loc11.attachMovie(snowballVO.__get__type().__get__symbolName(), "testSnowball", 1);
            if (_loc16 == undefined)
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            }
            else
            {
                _loc16.removeMovieClip();
            } // end else if
        } // end else if
        if (_loc4.is_reading)
        {
            _ENGINE.removePlayerBook(playerId);
        } // end if
        if (_loc4.is_ready && !_loc4.is_moving)
        {
            var _loc20 = _ENGINE.findAngle(_loc4._x, _loc4._y, target_x, target_y);
            var _loc18 = _ENGINE.findDirectionQuarters(_loc20);
            var _loc19 = Number(_SHELL.DANCE_FRAME + _loc18);
            _ENGINE.updatePlayerFrame(playerId, _loc19);
            var _loc10;
            if (snowballVO.__get__type() == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LASER)
            {
                _loc10 = {x: Number(_loc4._x - 10), y: Number(_loc4._y - _loc4.art_mc._height / 2)};
            }
            else if (_loc4.art_mc.body.snowballOrigin == undefined || _loc4.art_mc.body.snowballOrigin == undefined || _loc4.art_mc.body.localToGlobal == undefined)
            {
                _loc10 = {x: _loc4._x, y: _loc4._y};
            }
            else if (snowballVO.__get__type().__get__originAtHead())
            {
                _loc10 = {x: _loc4._x, y: Number(_loc4._y - _loc4.art_mc._height / 2)};
            }
            else if (snowballVO.__get__type().__get__originAtCenter())
            {
                _loc10 = {x: _loc4._x, y: Number(_loc4._y - _loc4.art_mc._height / 5)};
            }
            else
            {
                _loc10 = {x: _loc4._x, y: _loc4._y};
            } // end else if
            if (throwItemCounter >= maxSnowballs)
            {
                throwItemCounter = 0;
            } // end if
            _loc3.playerId = playerId;
            _loc3.id = throwItemCounter;
            _loc3.snowballType = snowballVO.type;
            _loc3.start_x = _loc10.x;
            _loc3.start_y = _loc10.y;
            _loc3.target_x = target_x;
            _loc3.target_y = target_y;
            var _loc22 = target_y / target_x;
            var _loc28;
            var _loc29;
            if (target_x < _loc3.start_x && target_y < _loc3.start_y)
            {
                _loc28 = 0;
            } // end if
            _loc3.distance = _ENGINE.findDistance(_loc3.start_x, _loc3.start_y, target_x, target_y);
            if (snowballVO.__get__duration() == -1)
            {
                _loc3.duration = _loc3.distance / 15;
            }
            else
            {
                _loc3.duration = _loc3.distance / 15 * snowballVO.__get__duration();
            } // end else if
            _loc3.change_x = target_x - _loc3.start_x;
            _loc3.change_y = target_y - _loc3.start_y;
            _loc3.peak = _loc3.duration / 2;
            _loc3.start_height = _loc10.y - _loc4._y;
            _loc3.max_height = _loc3.start_height + snowballVO.__get__maxHeightOffset();
            _loc3.change_height1 = _loc3.max_height - _loc3.start_height;
            _loc3.change_height2 = -_loc3.max_height;
            _loc3.wait = snowballVO.wait;
            _loc3.w = 0;
            _loc3.t = 0;
            _loc12 = snowballVO.__get__type().__get__symbolName() + throwItemCounter;
            snowballData[_loc12] = _loc3;
            if (_loc11[_loc12] != undefined)
            {
                _loc11[_loc12].removeMovieClip();
            } // end if
            _loc7 = _loc11.attachMovie(snowballVO.__get__type().__get__symbolName(), _loc12, Number(1000200 + throwItemCounter), {_x: _loc3.start_x, _y: _loc3.start_y});
            if (_loc7 == undefined)
            {
                _loc7 = _loc11.attachMovie("ball", _loc12, Number(1000200 + throwItemCounter), {_x: _loc3.start_x, _y: _loc3.start_y});
            } // end if
            _loc7.art._y = _loc3.start_height;
            _loc7._visible = false;
            _loc7._xscale = _loc7._yscale = _loc17;
            _ENGINE.updateItemDepth(_loc7, throwItemCounter);
            if (snowballVO.__get__type().__get__hasTail())
            {
                _loc7.art._rotation = com.clubpenguin.math.MathHelper.getAngleBetweenCoordinates(_loc10.x, _loc10.y, target_x, target_y);
            } // end if
            if (snowballVO.__get__type().__get__playAbovePlayer() && _loc7.getDepth() < _loc4.getDepth())
            {
                _loc7.swapDepths(_loc4.getDepth() + 1);
            } // end if
            if (snowballVO.__get__type().__get__playUnderPlayer() && _loc7.getDepth() > _loc4.getDepth())
            {
                _loc7.swapDepths(_loc4.getDepth());
            } // end if
            if (snowballVO.__get__type().__get__intelligentSort())
            {
                if (_loc3.target_y > _loc3.start_y && _loc7.getDepth() < _loc4.getDepth())
                {
                    _loc7.swapDepths(_loc4.getDepth() + 1);
                }
                else if (_loc3.target_y < _loc3.start_y && _loc7.getDepth() > _loc4.getDepth())
                {
                    _loc7.swapDepths(_loc4);
                } // end if
            } // end else if
            if (snowballVO.__get__type().__get__delayAnimStart())
            {
                _loc7.art.gotoAndStop(1);
            } // end if
            if (snowballVO.__get__type().__get__playerInvisible())
            {
                _loc4._visible = false;
                _ENGINE.getNicknameMovieClip(playerId)._visible = false;
            } // end if
            if (_loc3.snowballType.hasTrail)
            {
                _loc7.art.gotoAndStop(1);
                _loc7.art._visible = false;
            } // end if
            ++throwItemCounter;
        } // end if
        if (playerId == _SHELL.getMyPlayerId())
        {
            _global.getCurrentParty().FrozenParty.startSnowballCoolDown();
        } // end if
    } // End of the function
} // End of Class
