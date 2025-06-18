dynamic class com.clubpenguin.world.rooms.common.slide.ConveyorBelt
{
    static var MINIMUM_SLIDE_DISPLACEMENT: Number = 1;
    static var PENGUIN_SIT_FRONT_CENTER: Number = 17;
    static var PENGUIN_SIT_FRONT_LEFT: Number = 18;
    static var PENGUIN_SIT_FRONT_RIGHT: Number = 24;
    static var PENGUIN_SIT_BACK_CENTER: Number = 21;
    static var PENGUIN_SIT_BACK_LEFT: Number = 20;
    static var PENGUIN_SIT_BACK_RIGHT: Number = 23;
    var _updatePenguinFrames: Boolean = true;
    var _ENGINE;
    var _SHELL;
    var endOfConveyorBeltReached;
    var frameTriggersList;

    function ConveyorBelt()
    {
        this.init();
    }

    function init()
    {
        this.endOfConveyorBeltReached = new org.osflash.signals.Signal(Number);
        this._ENGINE = _global.getCurrentEngine();
        this._SHELL = _global.getCurrentShell();
    }

    function set updatePenguinFrames(value)
    {
        this._updatePenguinFrames = value;
    }

    function addPenguintoConveyorPather(linkageName, player_id, conveyorBeltContainer)
    {
        conveyorBeltContainer.attachMovie(linkageName, linkageName + player_id, conveyorBeltContainer.getNextHighestDepth(), {_x: 0, _y: 0});
        var __reg2 = conveyorBeltContainer[linkageName + player_id];
        __reg2.gotoAndStop(1);
        this._ENGINE.teleportPlayer(player_id, __reg2.patherMC._x, __reg2.patherMC._y);
        var __reg4 = this._ENGINE.getPlayerMovieClip(player_id);
        __reg4._rotation = __reg2.patherMC._rotation;
        if (player_id == this._SHELL.getMyPlayerId()) 
        {
            this._SHELL.getPlayerObjectById(player_id).isUsingSlide = true;
        }
        __reg2.play();
        __reg2.onEnterFrame = com.clubpenguin.util.Delegate.create(this, this.updatePenguinConveyorPosition, player_id, __reg2);
    }

    function updatePenguinConveyorPosition(player_id, patherMC)
    {
        var __reg4 = this.getRegisteredTriggerFunction(patherMC._currentframe, player_id);
        if (patherMC._currentframe == patherMC._totalframes) 
        {
            var __reg5 = this._SHELL.getPlayerObjectById(player_id).frame - 16;
            this.updateFrameBasedOnSlide(player_id, __reg5);
            this._SHELL.sendPlayerFrame(__reg5);
            patherMC.gotoAndStop(1);
            delete patherMC.onEnterFrame;
            patherMC.removeMovieClip();
            patherMC = null;
            if (player_id == this._SHELL.getMyPlayerId()) 
            {
                this._SHELL.getPlayerObjectById(player_id).isUsingSlide = false;
            }
            this.endOfConveyorBeltReached.dispatch(Number(player_id));
            return;
        }
        if (__reg4 != undefined) 
        {
            __reg4();
            return;
        }
        var __reg8 = this._SHELL.getPlayerObjectById(player_id).x;
        var __reg6 = this._SHELL.getPlayerObjectById(player_id).y;
        this._ENGINE.teleportPlayer(player_id, patherMC.patherMC._x, patherMC.patherMC._y);
        var __reg7 = this._ENGINE.getPlayerMovieClip(player_id);
        __reg7._rotation = patherMC.patherMC._rotation;
        if (this._updatePenguinFrames) 
        {
            this.updateSlidingActorFrame(player_id, __reg8, patherMC.patherMC._x, __reg6, patherMC.patherMC._y);
        }
    }

    function updateSlidingActorFrame(player_id, old_x, new_x, old_y, new_y)
    {
        var __reg4 = new_x - old_x;
        var __reg3 = new_y - old_y;
        var __reg2 = 0;
        if (__reg4 > com.clubpenguin.world.rooms.common.slide.ConveyorBelt.MINIMUM_SLIDE_DISPLACEMENT) 
        {
            __reg2 = __reg3 <= com.clubpenguin.world.rooms.common.slide.ConveyorBelt.MINIMUM_SLIDE_DISPLACEMENT ? com.clubpenguin.world.rooms.common.slide.ConveyorBelt.PENGUIN_SIT_BACK_RIGHT : com.clubpenguin.world.rooms.common.slide.ConveyorBelt.PENGUIN_SIT_FRONT_RIGHT;
        }
        else if (__reg4 < 0 - com.clubpenguin.world.rooms.common.slide.ConveyorBelt.MINIMUM_SLIDE_DISPLACEMENT) 
        {
            __reg2 = __reg3 <= com.clubpenguin.world.rooms.common.slide.ConveyorBelt.MINIMUM_SLIDE_DISPLACEMENT ? com.clubpenguin.world.rooms.common.slide.ConveyorBelt.PENGUIN_SIT_BACK_LEFT : com.clubpenguin.world.rooms.common.slide.ConveyorBelt.PENGUIN_SIT_FRONT_LEFT;
        }
        else 
        {
            __reg2 = __reg3 <= com.clubpenguin.world.rooms.common.slide.ConveyorBelt.MINIMUM_SLIDE_DISPLACEMENT ? com.clubpenguin.world.rooms.common.slide.ConveyorBelt.PENGUIN_SIT_BACK_CENTER : com.clubpenguin.world.rooms.common.slide.ConveyorBelt.PENGUIN_SIT_FRONT_CENTER;
        }
        if (__reg2 > 0) 
        {
            this.updateFrameBasedOnSlide(player_id, __reg2);
        }
    }

    function updateFrameBasedOnSlide(player_id, frame)
    {
        this._ENGINE.updatePlayerFrame(player_id, frame, true);
        this._SHELL.getPlayerObjectById(player_id).frame = frame;
    }

    function registerFrameTrigger(frame, callback, clientSide)
    {
        if (this.frameTriggersList == undefined) 
        {
            this.frameTriggersList = new Array();
        }
        clientSide = clientSide == undefined ? false : clientSide;
        this.frameTriggersList.push({f: frame, callback: callback, clientSide: clientSide});
    }

    function getRegisteredTriggerFunction(frame, player_id)
    {
        if (this.frameTriggersList != undefined) 
        {
            player_id = player_id == undefined ? 0 : player_id;
            var __reg2 = 0;
            while (__reg2 < this.frameTriggersList.length) 
            {
                if (frame == Number(this.frameTriggersList[__reg2].f)) 
                {
                    if (this.frameTriggersList[__reg2].clientSide && player_id == this._SHELL.getMyPlayerId()) 
                    {
                        return this.frameTriggersList[__reg2].callback;
                    }
                }
                ++__reg2;
            }
            return undefined;
        }
    }

    function destroy()
    {
    }

}
