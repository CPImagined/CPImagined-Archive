dynamic class com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides
{
    static var CLASS_NAME: String = "AlienAbduction_EngineOverrides";
    var _overrides = com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides;
    var defaultMovePlayer;
    var defaultSendPlayerMove;
    var defaultUpdatePlayerFrame;
    var defaultUpdatePlayerPosition;
    var isInit;

    function AlienAbduction_EngineOverrides()
    {
        trace("AlienAbduction_EngineOverrides : CONSTRUCTOR");
    }

    function init(abductedPlayer)
    {
        if (this.isInit) 
        {
            return undefined;
        }
        this.isInit = true;
        trace("AlienAbduction_EngineOverrides init()");
        if (abductedPlayer) 
        {
            com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID = abductedPlayer;
        }
        trace("*************** AlienAbduction_EngineOverrides  - _abductedPlayerID : " + com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID);
        this.defaultMovePlayer = _global.getCurrentEngine().movePlayer;
        this.defaultSendPlayerMove = _global.getCurrentEngine().sendPlayerMove;
        this.defaultUpdatePlayerPosition = _global.getCurrentEngine().updatePlayerPosition;
        this.defaultUpdatePlayerFrame = _global.getCurrentEngine().updatePlayerPosition;
    }

    function sendPlayerMove(x, y, is_trigger, frame)
    {
        var __reg2 = _global.getCurrentShell();
        var __reg3 = _global.getCurrentEngine();
        var __reg4 = _global.getCurrentShell().getMyPlayerId();
        trace("ENGINE_OVERRIDE:sendPlayerMove - _abductedPlayerID :" + com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID);
        trace("ENGINE_OVERRIDE:sendPlayerMove - player_id :" + __reg4);
        if (__reg4 == com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID) 
        {
            trace("****ABDUCTION CODE sendPlayerMove*********************************");
            trace("******************************************************************");
            return undefined;
        }
        trace("****NOT ABDUCTION CODE --- ENGINE:sendPlayerMove()");
        if (__reg3.isMovementEnabled()) 
        {
            trace("\nSHELL: " + __reg2);
            trace("SHELL._localLoginServerData: " + __reg2._localLoginServerData);
            if (__reg2._localLoginServerData.autoLogin) 
            {
                __reg2.sendAS2Clicked(__reg3.MOVE_CLICKED);
            }
            __reg4 = __reg2.getMyPlayerId();
            var __reg7 = __reg3.getPlayerMovieClip(__reg4);
            trace("player_id: " + __reg4);
            trace("mc: " + __reg7);
            if (__reg2.isPlayerJumping(__reg4) || __reg2.localPlayerIsJumping) 
            {
                return undefined;
            }
            if (__reg2.isPlayerJumping(__reg4) || __reg2.localPlayerIsJumping) 
            {
                return undefined;
            }
            var __reg9 = Math.round(__reg7._x);
            var __reg8 = Math.round(__reg7._y);
            trace("start_x: " + __reg9);
            trace("start_y: " + __reg8);
            var __reg11 = __reg3.findPlayerPath(__reg4, x, y);
            var __reg5 = __reg11.x;
            var __reg6 = __reg11.y;
            trace("target_x: " + __reg5);
            trace("target_y: " + __reg6);
            var __reg10 = __reg3.findDistance(__reg9, __reg8, __reg5, __reg6);
            trace("distance: " + __reg10);
            if (__reg10 > 10) 
            {
                __reg3.setPlayerAction("move");
                __reg3.movePlayer(__reg4, __reg5, __reg6, is_trigger, frame);
                __reg2.sendPlayerMove(__reg5, __reg6);
                return;
            }
            if (frame != undefined) 
            {
                __reg2.sendPlayerFrame(frame);
                return;
            }
            trace("ENGINE:ERROR:Less than minimum distance for movement");
        }
    }

    function movePlayer(player_id, target_x, target_y, is_trigger, frame)
    {
        var SHELL = _global.getCurrentShell();
        var ENGINE = _global.getCurrentEngine();
        trace("ENGINE_OVERRIDE:movePlayer - _abductedPlayerID :" + com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID);
        trace("ENGINE_OVERRIDE:movePlayer - player_id :" + player_id);
        if (player_id == com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID) 
        {
            var __reg2 = _global.getCurrentEngine().getPlayerMovieClip(player_id);
            var __reg12 = __reg2._x;
            var __reg11 = __reg2._y;
            __reg2._x = __reg12;
            __reg2._y = __reg11;
            trace("****ABDUCTION CODE movePlayer*************************************");
            trace("******************************************************************");
            trace("!!!ENGINE_OVERRIDE -- movePlayer x : " + __reg2._x);
            trace("!!!ENGINE_OVERRIDE -- movePlayer y : " + __reg2._y);
            return undefined;
        }
        trace("****NOT ABDUCTION CODE --- ENGINE:movePlayer: " + player_id);
        if (SHELL.isPlayerJumping(player_id)) 
        {
            return undefined;
        }
        var mc = ENGINE.getPlayerMovieClip(player_id);
        var __reg4 = SHELL.getPlayerObjectById(player_id);
        __reg4.hasNotMovedSince = -1;
        mc.cacheAsBitmap = false;
        mc.debug_mc.clear();
        if (!mc.is_ready) 
        {
            ENGINE.updatePlayerPosition(player_id, target_x, target_y);
            return undefined;
        }
        var start_x = Math.round(mc._x);
        var start_y = Math.round(mc._y);
        var __reg6 = ENGINE.findDistance(start_x, start_y, target_x, target_y);
        if (_global.getCurrentShell().playerModel.isPlayerStealthModerator() && _global.getCurrentShell().playerModel.isMyPlayer(player_id)) 
        {
            var duration = __reg6 / 32;
        }
        else 
        {
            var duration = __reg6 / 4 * (100 / __reg4.avatarVO.attributes.spriteSpeed);
        }
        var __reg13 = ENGINE.findAngle(start_x, start_y, target_x, target_y);
        var d = ENGINE.findDirection(__reg13);
        var change_x = target_x - start_x;
        var change_y = target_y - start_y;
        if (is_trigger == undefined) 
        {
            is_trigger = true;
        }
        var __reg7 = ENGINE.getRoomMovieClip();
        var easeFunction = __reg7.easeMethod;
        if (easeFunction == undefined) 
        {
            easeFunction = ENGINE.mathLinearTween;
        }
        if (__reg4.avatarVO.attributes.isFloating) 
        {
            easeFunction = ENGINE.mathEaseFloat;
        }
        var __reg14 = mc.is_moving;
        mc.is_moving = true;
        mc.lastMoveDirection = d;
        var __reg3 = undefined;
        if (easeFunction == ENGINE.mathEaseFloat) 
        {
            __reg3 = d;
        }
        else 
        {
            __reg3 = d + ENGINE.MAX_STANDING_FRAME;
            if (__reg7.invertedPenguins) 
            {
                __reg3 = __reg3 + 4;
                if (__reg3 > ENGINE.MAX_WALKING_FRAME) 
                {
                    var __reg10 = ENGINE.MAX_STANDING_FRAME + (__reg3 - ENGINE.MAX_WALKING_FRAME);
                    __reg3 = __reg10;
                }
            }
        }
        ENGINE.updatePlayerFrame(player_id, __reg3);
        var t = 0;
        ENGINE.movingPlayers["p" + player_id] = mc;
        mc.updateMCPosition = function ()
        {
            ++t;
            if (mc.is_moving && t < duration && (mc.frame >= ENGINE.MIN_WALKING_FRAME && mc.frame <= ENGINE.MAX_WALKING_FRAME) || easeFunction == ENGINE.mathEaseFloat) 
            {
                var __reg3 = undefined;
                var __reg2 = undefined;
                if (easeFunction == ENGINE.mathEaseFloat) 
                {
                    var __reg1 = easeFunction(t, start_x, target_x, start_y, target_y, duration);
                    __reg3 = __reg1.x;
                    __reg2 = __reg1.y;
                }
                else 
                {
                    __reg3 = Math.round(easeFunction(t, start_x, change_x, duration));
                    __reg2 = Math.round(easeFunction(t, start_y, change_y, duration));
                }
                ENGINE.updatePlayerPosition(player_id, __reg3, __reg2);
                return;
            }
            if (mc.is_moving && t >= duration) 
            {
                mc.is_moving = false;
                ENGINE.updatePlayerFrame(player_id, d);
                SHELL.sendPlayerMoveDone(player_id);
                delete (ENGINE.movingPlayers["p" + player_id]);
                if (SHELL.isMyPlayer(player_id)) 
                {
                    var __reg4 = false;
                    ENGINE.playerMoved.dispatch();
                    ENGINE.setPlayerAction("wait");
                    if (is_trigger && ENGINE.isMouseActive()) 
                    {
                        ENGINE.checkTrigger(mc);
                    }
                    if (frame != undefined) 
                    {
                        ENGINE.sendPlayerFrame(frame);
                    }
                }
            }
        }
        ;
        if (__reg14) 
        {
            return;
        }
        SHELL.updateListeners(SHELL.PLAYER_MOVE_START, __reg4);
    }

    function updatePlayerPosition(player_id, x, y, ignoreBlockLayer)
    {
        trace("!!!ENGINE_OVERRIDE : updatePlayerPosition : " + player_id);
        trace("!!!ENGINE_OVERRIDE : updatePlayerPosition : " + player_id);
        var __reg9 = _global.getCurrentShell();
        var __reg4 = _global.getCurrentEngine();
        trace("ENGINE_OVERRIDE:updatePlayerPosition - _abductedPlayerID :" + com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID);
        trace("ENGINE_OVERRIDE:updatePlayerPosition - player_id :" + player_id);
        if (player_id == com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides._abductedPlayerID) 
        {
            var __reg8 = _global.getCurrentEngine().getPlayerMovieClip(player_id);
            var __reg14 = __reg8._x;
            var __reg13 = __reg8._y;
            __reg8._x = __reg14;
            __reg8._y = __reg13;
            trace("****ABDUCTION CODE updatePlayerPosition***************************");
            trace("******************************************************************");
            return undefined;
        }
        var __reg3 = __reg4.getPlayerMovieClip(player_id);
        var __reg11 = __reg4.getBalloonMovieClip(player_id);
        var __reg10 = __reg4.getNicknameMovieClip(player_id);
        var __reg7 = __reg9.getPlayerObjectById(player_id);
        if (ignoreBlockLayer == undefined || !ignoreBlockLayer) 
        {
            x = __reg4.getValidXPosition(x);
            y = __reg4.getValidYPosition(y);
        }
        __reg3._x = x;
        __reg3._y = y;
        __reg11._x = x + __reg7.avatarVO.speechBubbleOffsetX;
        __reg11._y = y + __reg7.avatarVO.speechBubbleOffsetY;
        if (__reg3.scaleTopOffsetY != undefined) 
        {
            __reg11._y = __reg11._y + __reg3.scaleTopOffsetY;
        }
        __reg10._x = x;
        __reg10._y = y + __reg7.avatarVO.nicknameOffsetY;
        if (__reg3.scaleBottomOffsetY != undefined) 
        {
            __reg10._y = __reg10._y + __reg3.scaleBottomOffsetY;
        }
        __reg4.updatePlayerDepth(__reg3, __reg3.depth_id);
        if (__reg9.isMyPlayer(player_id)) 
        {
            __reg4.player_x = x;
            __reg4.player_y = y;
            var __reg12 = __reg9.getMyPlayerObject();
            __reg12.x = x;
            __reg12.y = y;
        }
        __reg7.x = x;
        __reg7.y = y;
    }

}
