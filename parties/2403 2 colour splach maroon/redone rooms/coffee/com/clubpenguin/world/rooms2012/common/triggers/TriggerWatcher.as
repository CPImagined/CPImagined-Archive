class com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher
{
    var _areaMC, _SHELL, _ENGINE, _gridWidth, _gridHeight, _xOffset, _yOffset, _targetGrid, _triggerList;
    function TriggerWatcher(stageMC, shell)
    {
        if (!stageMC)
        {
        } // end if
        _areaMC = stageMC.createEmptyMovieClip("targetWatcher", stageMC.getNextHighestDepth());
        _areaMC._x = _areaMC._y = 0;
        _areaMC.beginFill(7837952, 0);
        _areaMC.moveTo(0, 0);
        _areaMC.lineTo(com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.STAGE_WIDTH, 0);
        _areaMC.lineTo(com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.STAGE_WIDTH, com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.STAGE_HEIGHT);
        _areaMC.lineTo(0, com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.STAGE_HEIGHT);
        _areaMC.lineTo(0, 0);
        _areaMC.endFill();
        _areaMC._visible = false;
        _SHELL = shell;
        _ENGINE = _global.getCurrentEngine();
        _gridWidth = Math.ceil(Math.floor(_areaMC._width) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        _gridHeight = Math.ceil(Math.floor(_areaMC._height) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        _xOffset = _areaMC._x;
        _yOffset = _areaMC._y;
        _targetGrid = [];
        _triggerList = [];
        for (var _loc4 = 0; _loc4 < _gridHeight; ++_loc4)
        {
            for (var _loc3 = 0; _loc3 < _gridWidth; ++_loc3)
            {
                _targetGrid.push(null);
            } // end of for
        } // end of for
    } // End of the function
    function addTrigger(triggerToAdd)
    {
        _triggerList.push(triggerToAdd);
        var _loc10 = triggerToAdd.getBounds(_areaMC);
        var _loc9 = Math.floor(Math.floor(_loc10.xMin) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var _loc7 = Math.floor(Math.floor(_loc10.yMin) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var _loc8 = Math.floor(Math.floor(_loc10.xMax) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var _loc6 = Math.floor(Math.floor(_loc10.yMax) / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        for (var _loc3 = _loc9; _loc3 <= _loc8; ++_loc3)
        {
            if (!_targetGrid[_loc3])
            {
                _targetGrid[_loc3] = [];
            } // end if
            for (var _loc2 = _loc7; _loc2 <= _loc6; ++_loc2)
            {
                if (!_targetGrid[_loc3][_loc2])
                {
                    var _loc4 = new com.clubpenguin.world.rooms2012.common.triggers.GridTile(_xOffset + _loc3 * com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE, _yOffset + _loc2 * com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE, com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE, com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
                    _targetGrid[_loc3][_loc2] = _loc4;
                    _loc4.addTrigger(triggerToAdd);
                    continue;
                } // end if
                _targetGrid[_loc3][_loc2].addTrigger(triggerToAdd);
            } // end of for
        } // end of for
    } // End of the function
    function checkAllPlayers()
    {
        var _loc5 = _SHELL.getPlayerList();
        for (var _loc2 = 0; _loc2 < _triggerList.length; ++_loc2)
        {
            _triggerList[_loc2].beginSnapshot();
        } // end of for
        for (var _loc4 = 0; _loc4 < _loc5.length; ++_loc4)
        {
            this.checkTriggers(_loc5[_loc4]);
        } // end of for
        for (var _loc3 = 0; _loc3 < _triggerList.length; ++_loc3)
        {
            _triggerList[_loc3].endSnapshot();
        } // end of for
    } // End of the function
    function checkTriggers(object)
    {
        var _loc2 = _ENGINE.getPlayerMovieClip(object.player_id);
        var _loc4 = Math.floor(_loc2._x / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        var _loc3 = Math.floor(_loc2._y / com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher.GRID_SIZE);
        if (_targetGrid[_loc4][_loc3])
        {
            return (_targetGrid[_loc4][_loc3].hitTest(object, _loc2));
        } // end if
    } // End of the function
    function toString()
    {
        var _loc4 = [];
        for (var _loc3 = 0; _loc3 < _targetGrid.length; ++_loc3)
        {
            for (var _loc2 = 0; _loc2 < _targetGrid[_loc3].length; ++_loc2)
            {
                if (_targetGrid[_loc3][_loc2])
                {
                    _targetGrid[_loc3][_loc2].draw(_areaMC);
                } // end if
            } // end of for
        } // end of for
        return ("");
    } // End of the function
    static var GRID_SIZE = 20;
    static var STAGE_WIDTH = 760;
    static var STAGE_HEIGHT = 480;
} // End of Class
