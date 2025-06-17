dynamic class com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher
{
    static var GRID_SIZE: Number = 20;
    static var STAGE_WIDTH: Number = 760;
    static var STAGE_HEIGHT: Number = 480;
    var _ENGINE;
    var _SHELL;
    var _areaMC;
    var _gridHeight;
    var _gridWidth;
    var _snowballTargetGrid;
    var _snowballTriggerList;
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
        this._areaMC.lineTo(com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.STAGE_WIDTH, 0);
        this._areaMC.lineTo(com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.STAGE_WIDTH, com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.STAGE_HEIGHT);
        this._areaMC.lineTo(0, com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.STAGE_HEIGHT);
        this._areaMC.lineTo(0, 0);
        this._areaMC.endFill();
        this._areaMC._visible = false;
        this._SHELL = shell;
        this._ENGINE = _global.getCurrentEngine();
        this._gridWidth = Math.ceil(Math.floor(this._areaMC._width) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        this._gridHeight = Math.ceil(Math.floor(this._areaMC._height) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        this._xOffset = this._areaMC._x;
        this._yOffset = this._areaMC._y;
        this._targetGrid = [];
        this._triggerList = [];
        this._snowballTargetGrid = [];
        this._snowballTriggerList = [];
    }

    function addSnowballTrigger(snowballTriggerToAdd)
    {
    }

    function checkSnowball(playerID, snowballX, snowballY)
    {
    }

    function addTrigger(triggerToAdd)
    {
        this._triggerList.push(triggerToAdd);
        var __reg10 = triggerToAdd.getBounds(this._areaMC);
        var __reg9 = Math.floor(Math.floor(__reg10.xMin) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var __reg7 = Math.floor(Math.floor(__reg10.yMin) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var __reg8 = Math.floor(Math.floor(__reg10.xMax) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var __reg6 = Math.floor(Math.floor(__reg10.yMax) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var __reg3 = __reg9;
        for (;;) 
        {
            if (__reg3 > __reg8) 
            {
                return;
            }
            if (!this._targetGrid[__reg3]) 
            {
                this._targetGrid[__reg3] = [];
            }
            var __reg2 = __reg7;
            while (__reg2 <= __reg6) 
            {
                if (this._targetGrid[__reg3][__reg2]) 
                {
                    this._targetGrid[__reg3][__reg2].addTrigger(triggerToAdd);
                }
                else 
                {
                    var __reg4 = new com.clubpenguin.world.rooms2012.common.triggers.GridTile(this._xOffset + __reg3 * com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE, this._yOffset + __reg2 * com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE, com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE, com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
                    this._targetGrid[__reg3][__reg2] = __reg4;
                    __reg4.addTrigger(triggerToAdd);
                }
                ++__reg2;
            }
            ++__reg3;
        }
    }

    function checkAllPlayers()
    {
        var __reg5 = this._SHELL.getPlayerList();
        var __reg2 = 0;
        while (__reg2 < this._triggerList.length) 
        {
            this._triggerList[__reg2].beginSnapshot();
            ++__reg2;
        }
        var __reg4 = 0;
        while (__reg4 < __reg5.length) 
        {
            this.checkTriggers(__reg5[__reg4]);
            ++__reg4;
        }
        var __reg3 = 0;
        for (;;) 
        {
            if (__reg3 >= this._triggerList.length) 
            {
                return;
            }
            this._triggerList[__reg3].endSnapshot();
            ++__reg3;
        }
    }

    function checkTriggers(object)
    {
        var __reg2 = this._ENGINE.getPlayerMovieClip(object.player_id);
        var __reg4 = Math.floor(__reg2._x / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var __reg3 = Math.floor(__reg2._y / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        if (this._targetGrid[__reg4][__reg3]) 
        {
            return this._targetGrid[__reg4][__reg3].hitTest(object, __reg2);
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
