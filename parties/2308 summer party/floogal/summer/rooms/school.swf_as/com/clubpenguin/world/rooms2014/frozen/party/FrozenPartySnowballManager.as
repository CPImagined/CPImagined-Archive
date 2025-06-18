dynamic class com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySnowballManager extends com.clubpenguin.engine.projectiles.SnowballManager
{
    var _ENGINE;
    var _INTERFACE;
    var _SHELL;
    var maxSnowballs;
    var snowballData;
    var throwItemCounter;

    function FrozenPartySnowballManager(shell, engine, _interface)
    {
        super(shell, engine, _interface);
        this._INTERFACE = _interface;
        this._ENGINE = engine;
        var __reg3 = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
        this.maxSnowballs = 20;
        this._ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, __reg3);
        this._ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, __reg3);
        this._ENGINE.avatarManager.model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE, __reg3);
    }

    function throwBall(playerId, target_x, target_y, snowballVO)
    {
        var __reg9 = this._INTERFACE.getIgnoreList();
        var __reg7 = 0;
        while (__reg7 < __reg9.length) 
        {
            if (playerId == __reg9[__reg7].player_id) 
            {
                return undefined;
            }
            ++__reg7;
        }
        var __reg3 = {};
        var __reg4 = this._ENGINE.getPlayerMovieClip(playerId);
        var __reg12 = this._ENGINE.getRoomMovieClip();
        var __reg20 = __reg12.customPenguinSize;
        var __reg24 = this._SHELL.getRoomObject().room_id;
        var __reg6 = undefined;
        var __reg11 = undefined;
        var __reg21 = this._SHELL.getPlayerObjectById(playerId);
        if (snowballVO == undefined || snowballVO == null) 
        {
            _global.getCurrentParty().FrozenParty.pebug("Check snowball for frozen one");
            var __reg16 = this._SHELL.getPlayerObjectById(playerId).avatar_id;
            snowballVO = __reg21.avatarVO.snowball;
            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            if (playerId == this._SHELL.getMyPlayerId() && _global.getCurrentParty().FrozenParty.hasFrozenPowers()) 
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20);
            }
            if (__reg16 == _global.getCurrentParty().FrozenParty.CONSTANTS.OLAF_TRANSFORMATION_ID) 
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20);
            }
            if (__reg16 == _global.getCurrentParty().FrozenParty.CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID) 
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE, -100, 50);
            }
        }
        if (this._SHELL.getIsRoomIgloo()) 
        {
            snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
        }
        else 
        {
            var __reg15 = __reg12.attachMovie(snowballVO.__get__type().__get__symbolName(), "testSnowball", 1);
            if (__reg15 == undefined) 
            {
                snowballVO = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL, -100, 20);
            }
            else 
            {
                __reg15.removeMovieClip();
            }
        }
        if (__reg4.is_reading) 
        {
            this._ENGINE.removePlayerBook(playerId);
        }
        if (__reg4.is_ready && !__reg4.is_moving) 
        {
            var __reg22 = this._ENGINE.findAngle(__reg4._x, __reg4._y, target_x, target_y);
            var __reg19 = this._ENGINE.findDirectionQuarters(__reg22);
            var __reg17 = Number(this._SHELL.DANCE_FRAME + __reg19);
            this._ENGINE.updatePlayerFrame(playerId, __reg17);
            var __reg10 = undefined;
            if (snowballVO.__get__type() == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LASER) 
            {
                __reg10 = {x: Number(__reg4._x - 10), y: Number(__reg4._y - __reg4.art_mc._height / 2)};
            }
            else if (__reg4.art_mc.body.snowballOrigin == undefined || __reg4.art_mc.body.snowballOrigin == undefined || __reg4.art_mc.body.localToGlobal == undefined) 
            {
                __reg10 = {x: __reg4._x, y: __reg4._y};
            }
            else if (snowballVO.__get__type().__get__originAtHead()) 
            {
                __reg10 = {x: __reg4._x, y: Number(__reg4._y - __reg4.art_mc._height / 2)};
            }
            else if (snowballVO.__get__type().__get__originAtCenter()) 
            {
                __reg10 = {x: __reg4._x, y: Number(__reg4._y - __reg4.art_mc._height / 5)};
            }
            else 
            {
                __reg10 = {x: __reg4._x, y: __reg4._y};
            }
            if (this.throwItemCounter >= this.maxSnowballs) 
            {
                this.throwItemCounter = 0;
            }
            __reg3.playerId = playerId;
            __reg3.id = this.throwItemCounter;
            __reg3.snowballType = snowballVO.type;
            __reg3.start_x = __reg10.x;
            __reg3.start_y = __reg10.y;
            __reg3.target_x = target_x;
            __reg3.target_y = target_y;
            var __reg27 = target_y / target_x;
            var __reg18 = undefined;
            var __reg23 = undefined;
            if (target_x < __reg3.start_x && target_y < __reg3.start_y) 
            {
                __reg18 = 0;
            }
            __reg3.distance = this._ENGINE.findDistance(__reg3.start_x, __reg3.start_y, target_x, target_y);
            if (snowballVO.__get__duration() == -1) 
            {
                __reg3.duration = __reg3.distance / 15;
            }
            else 
            {
                __reg3.duration = __reg3.distance / 15 * snowballVO.__get__duration();
            }
            __reg3.change_x = target_x - __reg3.start_x;
            __reg3.change_y = target_y - __reg3.start_y;
            __reg3.peak = __reg3.duration / 2;
            __reg3.start_height = __reg10.y - __reg4._y;
            __reg3.max_height = __reg3.start_height + snowballVO.__get__maxHeightOffset();
            __reg3.change_height1 = __reg3.max_height - __reg3.start_height;
            __reg3.change_height2 = 0 - __reg3.max_height;
            __reg3.wait = snowballVO.wait;
            __reg3.w = 0;
            __reg3.t = 0;
            __reg11 = snowballVO.__get__type().__get__symbolName() + this.throwItemCounter;
            this.snowballData[__reg11] = __reg3;
            if (__reg12[__reg11] != undefined) 
            {
                __reg12[__reg11].removeMovieClip();
            }
            __reg6 = __reg12.attachMovie(snowballVO.__get__type().__get__symbolName(), __reg11, Number(1000200 + this.throwItemCounter), {_x: __reg3.start_x, _y: __reg3.start_y});
            if (__reg6 == undefined) 
            {
                __reg6 = __reg12.attachMovie("ball", __reg11, Number(1000200 + this.throwItemCounter), {_x: __reg3.start_x, _y: __reg3.start_y});
            }
            __reg6.art._y = __reg3.start_height;
            __reg6._visible = false;
            __reg6._xscale = __reg6._yscale = __reg20;
            this._ENGINE.updateItemDepth(__reg6, this.throwItemCounter);
            if (snowballVO.__get__type().__get__hasTail()) 
            {
                __reg6.art._rotation = com.clubpenguin.math.MathHelper.getAngleBetweenCoordinates(__reg10.x, __reg10.y, target_x, target_y);
            }
            if (snowballVO.__get__type().__get__playAbovePlayer() && __reg6.getDepth() < __reg4.getDepth()) 
            {
                __reg6.swapDepths(__reg4.getDepth() + 1);
            }
            if (snowballVO.__get__type().__get__playUnderPlayer() && __reg6.getDepth() > __reg4.getDepth()) 
            {
                __reg6.swapDepths(__reg4.getDepth());
            }
            if (snowballVO.__get__type().__get__intelligentSort()) 
            {
                if (__reg3.target_y > __reg3.start_y && __reg6.getDepth() < __reg4.getDepth()) 
                {
                    __reg6.swapDepths(__reg4.getDepth() + 1);
                }
                else if (__reg3.target_y < __reg3.start_y && __reg6.getDepth() > __reg4.getDepth()) 
                {
                    __reg6.swapDepths(__reg4);
                }
            }
            if (snowballVO.__get__type().__get__delayAnimStart()) 
            {
                __reg6.art.gotoAndStop(1);
            }
            if (snowballVO.__get__type().__get__playerInvisible()) 
            {
                __reg4._visible = false;
                this._ENGINE.getNicknameMovieClip(playerId)._visible = false;
            }
            if (__reg3.snowballType.hasTrail) 
            {
                __reg6.art.gotoAndStop(1);
                __reg6.art._visible = false;
            }
            ++this.throwItemCounter;
        }
        if (playerId == this._SHELL.getMyPlayerId()) 
        {
            _global.getCurrentParty().FrozenParty.startSnowballCoolDown();
        }
    }

}
