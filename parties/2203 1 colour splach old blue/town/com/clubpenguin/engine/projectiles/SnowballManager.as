class com.clubpenguin.engine.projectiles.SnowballManager
{
    var _SHELL, _ENGINE, _INTERFACE, snowballHitController, maxSnowballs, throwItemCounter, snowballData, lastUpdate;
    function SnowballManager(shell, engine, _interface)
    {
        _SHELL = shell;
        _ENGINE = engine;
        _INTERFACE = _interface;
        snowballHitController = new com.clubpenguin.engine.projectiles.SnowballHitController(_SHELL, _INTERFACE);
        maxSnowballs = 10;
        this.resetData();
        _SHELL.addListener(_SHELL.BALL_LAND, com.clubpenguin.util.Delegate.create(this, onBallLand));
        _SHELL.addListener(_SHELL.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, resetData));
    } // End of the function
    function setMaxSnowballs(value)
    {
        maxSnowballs = value;
    } // End of the function
    function throwBall(playerId, target_x, target_y, snowballVO)
    {
        var _loc7 = _INTERFACE.getIgnoreList();
        for (var _loc4 = 0; _loc4 < _loc7.length; ++_loc4)
        {
            if (playerId == _loc7[_loc4].player_id)
            {
                return;
            } // end if
        } // end of for
        var _loc2 = {};
        var _loc3 = _ENGINE.getPlayerMovieClip(playerId);
        var _loc10 = _ENGINE.getRoomMovieClip();
        var _loc15 = _loc10.customPenguinSize;
        var _loc22 = _SHELL.getRoomObject().room_id;
        var _loc5;
        var _loc11;
        var _loc18 = _SHELL.getPlayerObjectById(playerId);
        if (snowballVO == undefined || snowballVO == null)
        {
            var _loc19 = _SHELL.getPlayerObjectById(playerId).avatarVO.avatar_id;
            snowballVO = _loc18.avatarVO.snowball;
        } // end if
        if (_SHELL.getIsRoomIgloo() || _ENGINE.playerHostedRoomType == com.clubpenguin.world.rooms.common.RoomConstants.PLAYER_HOSTED_ROOM_BACKYARD)
        {
            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
        }
        else
        {
            var _loc14 = _loc10.attachMovie(snowballVO.__get__type().__get__symbolName(), "testSnowball", 1);
            if (_loc14 == undefined)
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            }
            else
            {
                _loc14.removeMovieClip();
            } // end else if
        } // end else if
        if (_loc3.is_reading)
        {
            _ENGINE.removePlayerBook(playerId);
        } // end if
        if (_loc3.is_ready && !_loc3.is_moving)
        {
            var _loc17 = _ENGINE.findAngle(_loc3._x, _loc3._y, target_x, target_y);
            var _loc16 = _ENGINE.findDirectionQuarters(_loc17);
            _ENGINE.updatePlayerFrame(playerId, _SHELL.DANCE_FRAME + _loc16);
            var _loc9;
            if (_loc3.art_mc.body.snowballOrigin == undefined || _loc3.art_mc.body.snowballOrigin == undefined || _loc3.art_mc.body.localToGlobal == undefined)
            {
                _loc9 = {x: _loc3._x, y: _loc3._y};
            }
            else if (snowballVO.__get__type().__get__originAtHead())
            {
                _loc9 = {x: _loc3._x, y: Number(_loc3._y - _loc3.art_mc._height / 2)};
            }
            else if (snowballVO.__get__type().__get__originAtCenter())
            {
                _loc9 = {x: _loc3._x, y: Number(_loc3._y - _loc3.art_mc._height / 5)};
            }
            else
            {
                _loc9 = {x: _loc3.art_mc.body.snowballOrigin._x, y: _loc3.art_mc.body.snowballOrigin._y};
                _loc3.art_mc.body.localToGlobal(_loc9);
            } // end else if
            if (throwItemCounter >= maxSnowballs)
            {
                throwItemCounter = 0;
            } // end if
            _loc2.playerId = playerId;
            _loc2.id = throwItemCounter;
            _loc2.snowballType = snowballVO.type;
            _loc2.start_x = _loc9.x;
            _loc2.start_y = _loc3._y;
            _loc2.distance = _ENGINE.findDistance(_loc2.start_x, _loc2.start_y, target_x, target_y);
            _loc2.duration = _loc2.distance / 15;
            _loc2.change_x = target_x - _loc2.start_x;
            _loc2.change_y = target_y - _loc2.start_y;
            _loc2.peak = _loc2.duration / 2;
            _loc2.start_height = _loc9.y - _loc3._y;
            _loc2.max_height = _loc2.start_height + snowballVO.__get__maxHeightOffset();
            _loc2.change_height1 = _loc2.max_height - _loc2.start_height;
            _loc2.change_height2 = -_loc2.max_height;
            _loc2.wait = snowballVO.wait;
            _loc2.w = 0;
            _loc2.t = 0;
            _loc11 = snowballVO.__get__type().__get__symbolName() + throwItemCounter;
            snowballData[_loc11] = _loc2;
            if (_loc10[_loc11] != undefined)
            {
                _loc10[_loc11].removeMovieClip();
            } // end if
            _loc5 = _loc10.attachMovie(snowballVO.__get__type().__get__symbolName(), _loc11, Number(1000200 + throwItemCounter), {_x: _loc2.start_x, _y: _loc2.start_y});
            if (_loc5 == undefined)
            {
                _loc5 = _loc10.attachMovie("ball", _loc11, Number(1000200 + throwItemCounter), {_x: _loc2.start_x, _y: _loc2.start_y});
            } // end if
            _loc5.art._y = _loc2.start_height;
            _loc5._visible = false;
            _loc5._xscale = _loc5._yscale = _loc15;
            _ENGINE.updateItemDepth(_loc5, throwItemCounter);
            if (snowballVO.__get__type().__get__hasTail())
            {
                _loc5.art._rotation = com.clubpenguin.math.MathHelper.getAngleBetweenCoordinates(_loc9.x, _loc9.y, target_x, target_y);
            } // end if
            if (snowballVO.__get__type().__get__playAbovePlayer() && _loc5.getDepth() < _loc3.getDepth())
            {
                _loc5.swapDepths(_loc3.getDepth() + 1);
            } // end if
            if (snowballVO.__get__type().__get__intelligentSort())
            {
                if (_loc2.target_y > _loc2.start_y && _loc5.getDepth() < _loc3.getDepth())
                {
                    _loc5.swapDepths(_loc3.getDepth() + 1);
                }
                else if (_loc2.target_y < _loc2.start_y && _loc5.getDepth() > _loc3.getDepth())
                {
                    _loc5.swapDepths(_loc3);
                } // end if
            } // end else if
            if (snowballVO.__get__type().__get__delayAnimStart())
            {
                _loc5.art.gotoAndStop(1);
            } // end if
            if (snowballVO.__get__type().__get__playerInvisible())
            {
                _loc3._visible = false;
                _ENGINE.getNicknameMovieClip(playerId)._visible = false;
            } // end if
            if (_loc2.snowballType.hasTrail)
            {
                _loc5.art.gotoAndStop(1);
                _loc5.art._visible = false;
            } // end if
            ++throwItemCounter;
        } // end if
    } // End of the function
    function onBallLand(event)
    {
        var _loc2 = _ENGINE.avatarManager.model.getSnowballHitCheck(event.snowballType);
        snowballHitController.playerSnowballHitCheck(event, _loc2);
    } // End of the function
    function update()
    {
        var _loc4 = _ENGINE.getRoomMovieClip();
        var _loc6 = [];
        var _loc10 = getTimer();
        for (var _loc9 in snowballData)
        {
            var _loc3 = _loc4[_loc9];
            var _loc2 = snowballData[_loc9];
            if (_loc2.w > _loc2.wait)
            {
                _loc3._visible = true;
                if (_loc2.snowballType.delayAnimStart && _loc3.art._currentframe == 1)
                {
                    _loc3.art.gotoAndPlay(2);
                } // end if
                ++_loc2.t;
                if (_loc2.t < _loc2.duration)
                {
                    if (_loc2.snowballType.isFixed)
                    {
                        _loc3._visible = false;
                        if (_loc2.t == 1)
                        {
                            var _loc7 = _loc3.duplicateMovieClip("snowballTrail" + _loc2.t, _loc3.getDepth() + _loc2.t);
                            _loc7._rotation = _loc3.art._rotation;
                        } // end if
                    }
                    else
                    {
                        _loc3._x = _ENGINE.mathLinearTween(_loc2.t, _loc2.start_x, _loc2.change_x, _loc2.duration);
                        _loc3._y = _ENGINE.mathLinearTween(_loc2.t, _loc2.start_y, _loc2.change_y, _loc2.duration);
                        _ENGINE.updateItemDepth(_loc3, _loc2.id);
                        if (_loc2.t < _loc2.peak)
                        {
                            _loc3.art._y = _ENGINE.mathEaseOutQuad(_loc2.t, _loc2.start_height, _loc2.change_height1, _loc2.peak);
                        }
                        else
                        {
                            _loc3.art._y = _ENGINE.mathEaseInQuad(_loc2.t - _loc2.peak, _loc2.max_height, _loc2.change_height2, _loc2.peak);
                        } // end else if
                    } // end else if
                }
                else
                {
                    _loc3._x = _loc2.target_x;
                    _loc3._y = _loc2.target_y;
                    _loc3.art._y = 0;
                    _loc3.player_id = _loc2.playerId;
                    if (_loc4.roomFunctionality.handleThrow != undefined)
                    {
                        _loc4.roomFunctionality.handleThrow(_loc3);
                    }
                    else if (_loc4.room.handleThrow != undefined)
                    {
                        _loc4.room.handleThrow(_loc3);
                    }
                    else
                    {
                        _loc4.handleThrow(_loc3);
                    } // end else if
                    if (_loc4.snowballBlock != undefined)
                    {
                        if (_loc4.snowballBlock.hitTest(_loc3._x, _loc3._y, true))
                        {
                            _loc3._visible = false;
                        } // end if
                    } // end if
                    var _loc8 = new com.clubpenguin.engine.projectiles.events.SnowballEvent(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, _loc2.id, _loc3, _loc2.playerId, _loc2.snowballType);
                    _SHELL.updateListeners(_SHELL.BALL_LAND, _loc8);
                    _loc6.push(_loc9);
                } // end else if
                continue;
            } // end if
            ++_loc2.w;
        } // end of for...in
        for (var _loc5 = 0; _loc5 < _loc6.length; ++_loc5)
        {
            delete snowballData[_loc6[_loc5]];
        } // end of for
    } // End of the function
    function resetData()
    {
        throwItemCounter = 0;
        lastUpdate = getTimer();
        snowballData = {};
    } // End of the function
} // End of Class
