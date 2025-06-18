dynamic class com.clubpenguin.world.rooms.common.triggers.TriggerWatcher
{
    static var GRID_SIZE: Number = 20;
    static var STAGE_WIDTH: Number = 760;
    static var STAGE_HEIGHT: Number = 480;
    static var DEBUG: Boolean = false;
    var _ENGINE;
    var _SHELL;
    var _areaMC;
    var _gridHeight;
    var _gridWidth;
    var _targetGrid;
    var _triggerList;
    var _xOffset;
    var _yOffset;

    function TriggerWatcher(stageMC, shell)
    {
        stageMC;
        this._areaMC = stageMC.createEmptyMovieClip("targetWatcher", stageMC.getNextHighestDepth());
        this._areaMC._x = this._areaMC._y = 0;
        this._areaMC.beginFill(7837952, 0);
        this._areaMC.moveTo(0, 0);
        this._areaMC.lineTo(com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.STAGE_WIDTH, 0);
        this._areaMC.lineTo(com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.STAGE_WIDTH, com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.STAGE_HEIGHT);
        this._areaMC.lineTo(0, com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.STAGE_HEIGHT);
        this._areaMC.lineTo(0, 0);
        this._areaMC.endFill();
        this._areaMC._visible = com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.DEBUG;
        com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS = stageMC.createEmptyMovieClip("targetWatcherDebug", stageMC.getNextHighestDepth());
        com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS._x = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS._y = 0;
        if (com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.DEBUG) 
        {
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG = com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.DEBUG;
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS = stageMC.createEmptyMovieClip("targetWatcherDebug", stageMC.getNextHighestDepth());
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS._x = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS._y = 0;
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2 = stageMC.createEmptyMovieClip("targetWatcherDebug2", stageMC.getNextHighestDepth());
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2._x = com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS2._y = 0;
            stageMC.triggers_mc._visible = true;
        }
        this._SHELL = shell;
        this._ENGINE = _global.getCurrentEngine();
        this._gridWidth = Math.ceil(Math.floor(this._areaMC._width) / com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
        this._gridHeight = Math.ceil(Math.floor(this._areaMC._height) / com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
        this._xOffset = this._areaMC._x;
        this._yOffset = this._areaMC._y;
        this._targetGrid = [];
        this._triggerList = [];
        var __reg4 = 0;
        for (;;) 
        {
            if (__reg4 >= this._gridHeight) 
            {
                return;
            }
            var __reg3 = 0;
            while (__reg3 < this._gridWidth) 
            {
                this._targetGrid.push(null);
                ++__reg3;
            }
            ++__reg4;
        }
    }

    function addTrigger(triggerToAdd)
    {
        if (triggerToAdd.__get__isValid()) 
        {
            this._triggerList.push(triggerToAdd);
            var __reg9 = triggerToAdd.getBounds(this._areaMC);
            var __reg10 = Math.floor(Math.floor(__reg9.xMin) / com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
            var __reg8 = Math.floor(Math.floor(__reg9.yMin) / com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
            var __reg7 = Math.floor(Math.floor(__reg9.xMax) / com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
            var __reg6 = Math.floor(Math.floor(__reg9.yMax) / com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
            var __reg3 = __reg10;
            for (;;) 
            {
                if (__reg3 > __reg7) 
                {
                    return undefined;
                }
                if (!this._targetGrid[__reg3]) 
                {
                    this._targetGrid[__reg3] = [];
                }
                var __reg2 = __reg8;
                while (__reg2 <= __reg6) 
                {
                    if (this._targetGrid[__reg3][__reg2]) 
                    {
                        this._targetGrid[__reg3][__reg2].addTrigger(triggerToAdd);
                    }
                    else 
                    {
                        var __reg4 = new com.clubpenguin.world.rooms.common.triggers.GridTile(this._xOffset + __reg3 * com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE, this._yOffset + __reg2 * com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE, com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE, com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
                        this._targetGrid[__reg3][__reg2] = __reg4;
                        __reg4.addTrigger(triggerToAdd);
                        if (com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.DEBUG) 
                        {
                            this._targetGrid[__reg3][__reg2].draw(this._areaMC);
                        }
                    }
                    ++__reg2;
                }
                ++__reg3;
            }
        }
    }

    function checkAllPlayers()
    {
        var __reg5 = this._SHELL.getPlayerList();
        var __reg4 = 0;
        while (__reg4 < this._triggerList.length) 
        {
            this._triggerList[__reg4].beginSnapshot();
            ++__reg4;
        }
        if (com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.DEBUG) 
        {
            com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.DEBUG_CANVAS.clear();
        }
        var __reg2 = 0;
        while (__reg2 < __reg5.length) 
        {
            this.checkTriggers(__reg5[__reg2]);
            ++__reg2;
        }
        var __reg3 = 0;
        for (;;) 
        {
            if (__reg3 >= this._triggerList.length) 
            {
                return undefined;
            }
            this._triggerList[__reg3].endSnapshot();
            ++__reg3;
        }
    }

    function checkTriggers(object)
    {
        var __reg2 = this._ENGINE.getPlayerMovieClip(object.player_id);
        var __reg3 = Math.floor(__reg2._x / com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
        var __reg4 = Math.floor(__reg2._y / com.clubpenguin.world.rooms.common.triggers.TriggerWatcher.GRID_SIZE);
        if (this._targetGrid[__reg3][__reg4]) 
        {
            this._targetGrid[__reg3][__reg4].hitTest(object, __reg2);
        }
    }

    function toString()
    {
        var __reg4 = [];
        var __reg3 = 0;
        while (__reg3 < this._targetGrid.length) 
        {
            var __reg2 = 0;
            while (__reg2 < this._targetGrid[__reg3].length) 
            {
                if (this._targetGrid[__reg3][__reg2]) 
                {
                    this._targetGrid[__reg3][__reg2].draw(this._areaMC);
                }
                ++__reg2;
            }
            ++__reg3;
        }
        return "";
    }

}
