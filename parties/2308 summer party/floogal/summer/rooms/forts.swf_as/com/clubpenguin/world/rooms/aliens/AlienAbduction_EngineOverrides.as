class com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides
{
    var isInit, defaultMovePlayer, defaultSendPlayerMove, defaultUpdatePlayerPosition, defaultUpdatePlayerFrame;
    static var _abductedPlayerID;
    function AlienAbduction_EngineOverrides()
    {
    } // End of the function
    function init(abductedPlayer)
    {
        if (isInit)
        {
            return;
        } // end if
        isInit = true;
        if (abductedPlayer)
        {
            _abductedPlayerID = abductedPlayer;
        } // end if
        defaultMovePlayer = _global.getCurrentEngine().movePlayer;
        defaultSendPlayerMove = _global.getCurrentEngine().sendPlayerMove;
        defaultUpdatePlayerPosition = _global.getCurrentEngine().updatePlayerPosition;
        defaultUpdatePlayerFrame = _global.getCurrentEngine().updatePlayerPosition;
    } // End of the function
    function sendPlayerMove(x, y, is_trigger, frame)
    {
        var _loc2 = _global.getCurrentShell();
        var _loc3 = _global.getCurrentEngine();
        var _loc4 = _global.getCurrentShell().getMyPlayerId();
        if (_loc4 == com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID)
        {
            return;
        } // end if
        if (!_loc3.isMovementEnabled())
        {
            return;
        } // end if
        if (_loc2._localLoginServerData.autoLogin)
        {
            _loc2.sendAS2Clicked(_loc3.MOVE_CLICKED);
        } // end if
        _loc4 = _loc2.getMyPlayerId();
        var _loc7 = _loc3.getPlayerMovieClip(_loc4);
        if (_loc2.isPlayerJumping(_loc4) || _loc2.localPlayerIsJumping)
        {
            return;
        } // end if
        if (_loc2.isPlayerJumping(_loc4) || _loc2.localPlayerIsJumping)
        {
            return;
        } // end if
        var _loc9 = Math.round(_loc7._x);
        var _loc8 = Math.round(_loc7._y);
        var _loc11 = _loc3.findPlayerPath(_loc4, x, y);
        var _loc5 = _loc11.x;
        var _loc6 = _loc11.y;
        var _loc10 = _loc3.findDistance(_loc9, _loc8, _loc5, _loc6);
        if (_loc10 > 10)
        {
            _loc3.setPlayerAction("move");
            _loc3.movePlayer(_loc4, _loc5, _loc6, is_trigger, frame);
            _loc2.sendPlayerMove(_loc5, _loc6);
        }
        else if (frame != undefined)
        {
            _loc2.sendPlayerFrame(frame);
            
        } // end else if
    } // End of the function
    function movePlayer(player_id, target_x, target_y, is_trigger, frame)
    {
        var SHELL = _global.getCurrentShell();
        var ENGINE = _global.getCurrentEngine();
        if (player_id == com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID)
        {
            var _loc2 = _global.getCurrentEngine().getPlayerMovieClip(player_id);
            var _loc12 = _loc2._x;
            var _loc11 = _loc2._y;
            _loc2._x = _loc12;
            _loc2._y = _loc11;
            return;
        } // end if
        if (SHELL.isPlayerJumping(player_id))
        {
            return;
        } // end if
        var mc = ENGINE.getPlayerMovieClip(player_id);
        var _loc4 = SHELL.getPlayerObjectById(player_id);
        _loc4.hasNotMovedSince = -1;
        mc.cacheAsBitmap = false;
        mc.debug_mc.clear();
        if (!mc.is_ready)
        {
            ENGINE.updatePlayerPosition(player_id, target_x, target_y);
            return;
        } // end if
        var start_x = Math.round(mc._x);
        var start_y = Math.round(mc._y);
        var _loc6 = ENGINE.findDistance(start_x, start_y, target_x, target_y);
        if (_global.getCurrentShell().playerModel.isPlayerStealthModerator() && _global.getCurrentShell().playerModel.isMyPlayer(player_id))
        {
            var duration = _loc6 / 32;
        }
        else
        {
            var duration = _loc6 / 4 * (100 / _loc4.avatarVO.attributes.spriteSpeed);
        } // end else if
        var _loc13 = ENGINE.findAngle(start_x, start_y, target_x, target_y);
        var d = ENGINE.findDirection(_loc13);
        var change_x = target_x - start_x;
        var change_y = target_y - start_y;
        if (is_trigger == undefined)
        {
            is_trigger = true;
        } // end if
        var _loc7 = ENGINE.getRoomMovieClip();
        var easeFunction = _loc7.easeMethod;
        if (easeFunction == undefined)
        {
            easeFunction = ENGINE.mathLinearTween;
        } // end if
        if (_loc4.avatarVO.attributes.isFloating)
        {
            easeFunction = ENGINE.mathEaseFloat;
        } // end if
        var _loc14 = mc.is_moving;
        mc.is_moving = true;
        mc.lastMoveDirection = d;
        var _loc3;
        if (easeFunction == ENGINE.mathEaseFloat)
        {
            _loc3 = d;
        }
        else
        {
            _loc3 = d + ENGINE.MAX_STANDING_FRAME;
            if (_loc7.invertedPenguins)
            {
                _loc3 = _loc3 + 4;
                if (_loc3 > ENGINE.MAX_WALKING_FRAME)
                {
                    var _loc10 = ENGINE.MAX_STANDING_FRAME + (_loc3 - ENGINE.MAX_WALKING_FRAME);
                    _loc3 = _loc10;
                } // end if
            } // end if
        } // end else if
        ENGINE.updatePlayerFrame(player_id, _loc3);
        var t = 0;
        ENGINE.movingPlayers["p" + player_id] = mc;
        mc.updateMCPosition = function ()
        {
            ++t;
            if (mc.is_moving && t < duration && (mc.frame >= ENGINE.MIN_WALKING_FRAME && mc.frame <= ENGINE.MAX_WALKING_FRAME || easeFunction == ENGINE.mathEaseFloat))
            {
                var _loc3;
                var _loc2;
                if (easeFunction == ENGINE.mathEaseFloat)
                {
                    var _loc1 = easeFunction(t, start_x, target_x, start_y, target_y, duration);
                    _loc3 = _loc1.x;
                    _loc2 = _loc1.y;
                }
                else
                {
                    _loc3 = Math.round(easeFunction(t, start_x, change_x, duration));
                    _loc2 = Math.round(easeFunction(t, start_y, change_y, duration));
                } // end else if
                ENGINE.updatePlayerPosition(player_id, _loc3, _loc2);
            }
            else if (mc.is_moving && t >= duration)
            {
                mc.is_moving = false;
                ENGINE.updatePlayerFrame(player_id, d);
                SHELL.sendPlayerMoveDone(player_id);
                delete ENGINE.movingPlayers["p" + player_id];
                if (SHELL.isMyPlayer(player_id))
                {
                    var _loc4 = false;
                    ENGINE.playerMoved.dispatch();
                    ENGINE.setPlayerAction("wait");
                    if (is_trigger && ENGINE.isMouseActive())
                    {
                        ENGINE.checkTrigger(mc);
                    } // end if
                    if (frame != undefined)
                    {
                        ENGINE.sendPlayerFrame(frame);
                    } // end if
                } // end if
            } // end else if
        };
        if (!_loc14)
        {
            SHELL.updateListeners(SHELL.PLAYER_MOVE_START, _loc4);
        } // end if
    } // End of the function
    function updatePlayerPosition(player_id, x, y, ignoreBlockLayer)
    {
        var _loc9 = _global.getCurrentShell();
        var _loc4 = _global.getCurrentEngine();
        if (player_id == com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID)
        {
            var _loc8 = _global.getCurrentEngine().getPlayerMovieClip(player_id);
            var _loc14 = _loc8._x;
            var _loc13 = _loc8._y;
            _loc8._x = _loc14;
            _loc8._y = _loc13;
            return;
        } // end if
        var _loc3 = _loc4.getPlayerMovieClip(player_id);
        var _loc11 = _loc4.getBalloonMovieClip(player_id);
        var _loc10 = _loc4.getNicknameMovieClip(player_id);
        var _loc7 = _loc9.getPlayerObjectById(player_id);
        if (ignoreBlockLayer == undefined || !ignoreBlockLayer)
        {
            x = _loc4.getValidXPosition(x);
            y = _loc4.getValidYPosition(y);
        } // end if
        _loc3._x = x;
        _loc3._y = y;
        _loc11._x = x + _loc7.avatarVO.speechBubbleOffsetX;
        _loc11._y = y + _loc7.avatarVO.speechBubbleOffsetY;
        if (_loc3.scaleTopOffsetY != undefined)
        {
            _loc11._y = _loc11._y + _loc3.scaleTopOffsetY;
        } // end if
        _loc10._x = x;
        _loc10._y = y + _loc7.avatarVO.nicknameOffsetY;
        if (_loc3.scaleBottomOffsetY != undefined)
        {
            _loc10._y = _loc10._y + _loc3.scaleBottomOffsetY;
        } // end if
        _loc4.updatePlayerDepth(_loc3, _loc3.depth_id);
        if (_loc9.isMyPlayer(player_id))
        {
            _loc4.player_x = x;
            _loc4.player_y = y;
            var _loc12 = _loc9.getMyPlayerObject();
            _loc12.x = x;
            _loc12.y = y;
        } // end if
        _loc7.x = x;
        _loc7.y = y;
    } // End of the function
    static var CLASS_NAME = "AlienAbduction_EngineOverrides";
    var _overrides = com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides;
} // End of Class
