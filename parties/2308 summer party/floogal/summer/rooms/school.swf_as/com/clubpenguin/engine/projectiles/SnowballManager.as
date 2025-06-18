dynamic class com.clubpenguin.engine.projectiles.SnowballManager
{
    var _ENGINE;
    var _INTERFACE;
    var _SHELL;
    var lastUpdate;
    var maxSnowballs;
    var snowballData;
    var snowballHitController;
    var throwItemCounter;

    function SnowballManager(shell, engine, _interface)
    {
        this._SHELL = shell;
        this._ENGINE = engine;
        this._INTERFACE = _interface;
        this.snowballHitController = new com.clubpenguin.engine.projectiles.SnowballHitController(this._SHELL, this._INTERFACE);
        this.maxSnowballs = 10;
        this.resetData();
        this._SHELL.addListener(this._SHELL.BALL_LAND, com.clubpenguin.util.Delegate.create(this, this.onBallLand));
        this._SHELL.addListener(this._SHELL.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, this.resetData));
    }

    function setMaxSnowballs(value)
    {
        this.maxSnowballs = value;
    }

    function throwBall(playerId, target_x, target_y, snowballVO)
    {
        var __reg7 = this._INTERFACE.getIgnoreList();
        var __reg5 = 0;
        while (__reg5 < __reg7.length) 
        {
            if (playerId == __reg7[__reg5].player_id) 
            {
                return undefined;
            }
            ++__reg5;
        }
        var __reg2 = {};
        var __reg3 = this._ENGINE.getPlayerMovieClip(playerId);
        var __reg11 = this._ENGINE.getRoomMovieClip();
        var __reg18 = __reg11.customPenguinSize;
        var __reg22 = this._SHELL.getRoomObject().room_id;
        var __reg4 = undefined;
        var __reg10 = undefined;
        var __reg15 = this._SHELL.getPlayerObjectById(playerId);
        if (snowballVO == undefined || snowballVO == null) 
        {
            var __reg19 = this._SHELL.getPlayerObjectById(playerId).avatarVO.avatar_id;
            snowballVO = __reg15.avatarVO.snowball;
        }
        if (this._SHELL.getIsRoomIgloo() || this._ENGINE.playerHostedRoomType == com.clubpenguin.world.rooms.common.RoomConstants.PLAYER_HOSTED_ROOM_BACKYARD) 
        {
            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
        }
        else 
        {
            var __reg14 = __reg11.attachMovie(snowballVO.__get__type().__get__symbolName(), "testSnowball", 1);
            if (__reg14 == undefined) 
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            }
            else 
            {
                __reg14.removeMovieClip();
            }
        }
        if (__reg3.is_reading) 
        {
            this._ENGINE.removePlayerBook(playerId);
        }
        if (__reg3.is_ready && !__reg3.is_moving) 
        {
            var __reg16 = this._ENGINE.findAngle(__reg3._x, __reg3._y, target_x, target_y);
            var __reg17 = this._ENGINE.findDirectionQuarters(__reg16);
            this._ENGINE.updatePlayerFrame(playerId, this._SHELL.DANCE_FRAME + __reg17);
            var __reg9 = undefined;
            if (__reg3.art_mc.body.snowballOrigin == undefined || __reg3.art_mc.body.snowballOrigin == undefined || __reg3.art_mc.body.localToGlobal == undefined) 
            {
                __reg9 = {x: __reg3._x, y: __reg3._y};
            }
            else if (snowballVO.__get__type().__get__originAtHead()) 
            {
                __reg9 = {x: __reg3._x, y: Number(__reg3._y - __reg3.art_mc._height / 2)};
            }
            else if (snowballVO.__get__type().__get__originAtCenter()) 
            {
                __reg9 = {x: __reg3._x, y: Number(__reg3._y - __reg3.art_mc._height / 5)};
            }
            else 
            {
                __reg9 = {x: __reg3.art_mc.body.snowballOrigin._x, y: __reg3.art_mc.body.snowballOrigin._y};
                __reg3.art_mc.body.localToGlobal(__reg9);
            }
            if (this.throwItemCounter >= this.maxSnowballs) 
            {
                this.throwItemCounter = 0;
            }
            __reg2.playerId = playerId;
            __reg2.id = this.throwItemCounter;
            __reg2.snowballType = snowballVO.type;
            __reg2.start_x = __reg9.x;
            __reg2.start_y = __reg3._y;
            __reg2.distance = this._ENGINE.findDistance(__reg2.start_x, __reg2.start_y, target_x, target_y);
            __reg2.duration = __reg2.distance / 15;
            __reg2.change_x = target_x - __reg2.start_x;
            __reg2.change_y = target_y - __reg2.start_y;
            __reg2.peak = __reg2.duration / 2;
            __reg2.start_height = __reg9.y - __reg3._y;
            __reg2.max_height = __reg2.start_height + snowballVO.__get__maxHeightOffset();
            __reg2.change_height1 = __reg2.max_height - __reg2.start_height;
            __reg2.change_height2 = 0 - __reg2.max_height;
            __reg2.wait = snowballVO.wait;
            __reg2.w = 0;
            __reg2.t = 0;
            __reg10 = snowballVO.__get__type().__get__symbolName() + this.throwItemCounter;
            this.snowballData[__reg10] = __reg2;
            if (__reg11[__reg10] != undefined) 
            {
                __reg11[__reg10].removeMovieClip();
            }
            __reg4 = __reg11.attachMovie(snowballVO.__get__type().__get__symbolName(), __reg10, Number(1000200 + this.throwItemCounter), {_x: __reg2.start_x, _y: __reg2.start_y});
            if (__reg4 == undefined) 
            {
                __reg4 = __reg11.attachMovie("ball", __reg10, Number(1000200 + this.throwItemCounter), {_x: __reg2.start_x, _y: __reg2.start_y});
            }
            __reg4.art._y = __reg2.start_height;
            __reg4._visible = false;
            __reg4._xscale = __reg4._yscale = __reg18;
            this._ENGINE.updateItemDepth(__reg4, this.throwItemCounter);
            if (snowballVO.__get__type().__get__hasTail()) 
            {
                __reg4.art._rotation = com.clubpenguin.math.MathHelper.getAngleBetweenCoordinates(__reg9.x, __reg9.y, target_x, target_y);
            }
            if (snowballVO.__get__type().__get__playAbovePlayer() && __reg4.getDepth() < __reg3.getDepth()) 
            {
                __reg4.swapDepths(__reg3.getDepth() + 1);
            }
            if (snowballVO.__get__type().__get__intelligentSort()) 
            {
                if (__reg2.target_y > __reg2.start_y && __reg4.getDepth() < __reg3.getDepth()) 
                {
                    __reg4.swapDepths(__reg3.getDepth() + 1);
                }
                else if (__reg2.target_y < __reg2.start_y && __reg4.getDepth() > __reg3.getDepth()) 
                {
                    __reg4.swapDepths(__reg3);
                }
            }
            if (snowballVO.__get__type().__get__delayAnimStart()) 
            {
                __reg4.art.gotoAndStop(1);
            }
            if (snowballVO.__get__type().__get__playerInvisible()) 
            {
                __reg3._visible = false;
                this._ENGINE.getNicknameMovieClip(playerId)._visible = false;
            }
            if (__reg2.snowballType.hasTrail) 
            {
                __reg4.art.gotoAndStop(1);
                __reg4.art._visible = false;
            }
            ++this.throwItemCounter;
        }
    }

    function onBallLand(event)
    {
        var __reg2 = this._ENGINE.avatarManager.model.getSnowballHitCheck(event.snowballType);
        this.snowballHitController.playerSnowballHitCheck(event, __reg2);
    }

    function update()
    {
        var __reg4 = this._ENGINE.getRoomMovieClip();
        var __reg5 = [];
        var __reg10 = getTimer();
        for (var __reg9 in this.snowballData) 
        {
            var __reg3 = __reg4[__reg9];
            var __reg2 = this.snowballData[__reg9];
            if (__reg2.w > __reg2.wait) 
            {
                __reg3._visible = true;
                if (__reg2.snowballType.delayAnimStart && __reg3.art._currentframe == 1) 
                {
                    __reg3.art.gotoAndPlay(2);
                }
                ++__reg2.t;
                if (__reg2.t < __reg2.duration) 
                {
                    if (__reg2.snowballType.isFixed) 
                    {
                        __reg3._visible = false;
                        if (__reg2.t == 1) 
                        {
                            var __reg8 = __reg3.duplicateMovieClip("snowballTrail" + __reg2.t, __reg3.getDepth() + __reg2.t);
                            __reg8._rotation = __reg3.art._rotation;
                        }
                    }
                    else 
                    {
                        __reg3._x = this._ENGINE.mathLinearTween(__reg2.t, __reg2.start_x, __reg2.change_x, __reg2.duration);
                        __reg3._y = this._ENGINE.mathLinearTween(__reg2.t, __reg2.start_y, __reg2.change_y, __reg2.duration);
                        this._ENGINE.updateItemDepth(__reg3, __reg2.id);
                        if (__reg2.t < __reg2.peak) 
                        {
                            __reg3.art._y = this._ENGINE.mathEaseOutQuad(__reg2.t, __reg2.start_height, __reg2.change_height1, __reg2.peak);
                        }
                        else 
                        {
                            __reg3.art._y = this._ENGINE.mathEaseInQuad(__reg2.t - __reg2.peak, __reg2.max_height, __reg2.change_height2, __reg2.peak);
                        }
                    }
                }
                else 
                {
                    __reg3._x = __reg2.target_x;
                    __reg3._y = __reg2.target_y;
                    __reg3.art._y = 0;
                    __reg3.player_id = __reg2.playerId;
                    if (__reg4.roomFunctionality.handleThrow == undefined) 
                    {
                        if (__reg4.room.handleThrow == undefined) 
                        {
                            __reg4.handleThrow(__reg3);
                        }
                        else 
                        {
                            __reg4.room.handleThrow(__reg3);
                        }
                    }
                    else 
                    {
                        __reg4.roomFunctionality.handleThrow(__reg3);
                    }
                    if (__reg4.snowballBlock != undefined) 
                    {
                        if (__reg4.snowballBlock.hitTest(__reg3._x, __reg3._y, true)) 
                        {
                            __reg3._visible = false;
                        }
                    }
                    var __reg7 = new com.clubpenguin.engine.projectiles.events.SnowballEvent(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, __reg2.id, __reg3, __reg2.playerId, __reg2.snowballType);
                    this._SHELL.updateListeners(this._SHELL.BALL_LAND, __reg7);
                    __reg5.push(__reg9);
                }
            }
            else 
            {
                ++__reg2.w;
            }
        }
        var __reg6 = 0;
        for (;;) 
        {
            if (__reg6 >= __reg5.length) 
            {
                return undefined;
            }
            delete this.snowballData[__reg5[__reg6]];
            ++__reg6;
        }
    }

    function resetData()
    {
        this.throwItemCounter = 0;
        this.lastUpdate = getTimer();
        this.snowballData = {};
    }

}
