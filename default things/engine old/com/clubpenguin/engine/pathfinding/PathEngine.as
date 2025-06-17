class com.clubpenguin.engine.pathfinding.PathEngine
{
    var _blockedAreaClip, _start, _goal, _path, _waypointManager, _eye, _hitTestLineClip, __get__blockedAreaClip, __get__waypointsClip, __set__blockedAreaClip, __set__waypointsClip;
    function PathEngine()
    {
    } // End of the function
    function getRandomPointInCircleWithClip(clip)
    {
        if (clip != undefined)
        {
            var _loc2 = Math.random() * 6.283185;
            var _loc4 = Math.round(clip._x + Math.sin(_loc2) * (Math.random() * (clip._width / 2)));
            var _loc3 = Math.round(clip._y + Math.cos(_loc2) * (Math.random() * (clip._height / 2)));
            return (new flash.geom.Point(_loc4, _loc3));
        } // end if
    } // End of the function
    function isValidPoint(point)
    {
        return (!_blockedAreaClip.hitTest(point.x, point.y, true));
    } // End of the function
    function getPathBetween(start, end)
    {
        if (!this.isValidPoint(start) || !this.isValidPoint(end))
        {
            return;
        } // end if
        _start = start.clone();
        _goal = end.clone();
        if (!this.anyPathToTarget(start, end))
        {
            return;
        } // end if
        if (!this.isPathBlocked(start, end))
        {
            _path = [start, end];
            return (_path);
        } // end if
        if (!this.anyPathFromStartToWaypoint())
        {
            return;
        } // end if
        _path = [];
        if (_waypointManager != undefined)
        {
            _eye = _start;
            _waypointManager.enableAllWaypoints();
            _waypointManager.setAllWaypointsAsUnused();
            this.calculatePath();
        } // end if
        _path.splice(0, 0, _start);
        _path.push(_goal);
        this.optimizePath();
        return (_path);
    } // End of the function
    function getTotalDistanceOfPath(path)
    {
        var _loc1 = 0;
        var _loc4 = path.length;
        var _loc3 = 0;
        while (_loc1 < _loc4)
        {
            if (path[_loc1 - 1] != undefined)
            {
                _loc3 = _loc3 + flash.geom.Point.distance(path[_loc1], path[_loc1 - 1]);
            } // end if
            ++_loc1;
        } // end while
        return (_loc3);
    } // End of the function
    function isPathBlocked(start, end)
    {
        return (com.clubpenguin.util.BitmapHitTester.doesHit(this.drawHitTestLine(start, end), _blockedAreaClip));
    } // End of the function
    function anyPathToTarget(start, target)
    {
        var _loc3 = _waypointManager.__get__waypoints();
        _loc3.splice(0, 0, start);
        var _loc4 = _loc3.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            if (!this.isPathBlocked(_loc3[_loc2], target))
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    function anyPathFromStartToWaypoint(start)
    {
        var _loc3 = _waypointManager.__get__waypoints();
        var _loc4 = _loc3.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            if (!this.isPathBlocked(start, _loc3[_loc2]))
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    function calculatePath()
    {
        if (_eye.x == undefined || _eye.y == undefined || (_goal.x == undefined || _goal.y == undefined))
        {
            return;
        } // end if
        if (this.isPathBlocked(_eye, _goal))
        {
            var _loc2 = _waypointManager.getClosestActiveWaypointBetween(_eye, _goal);
            if (_loc2 == undefined)
            {
                _path = [];
                _waypointManager.enableAllWaypoints();
                return;
            } // end if
            if (this.isPathBlocked(_eye, _loc2))
            {
                _loc2.__set__active(false);
            }
            else if (_eye != _loc2)
            {
                _path.push(_loc2);
                _loc2.__set__used(true);
                _eye = _loc2;
                _waypointManager.enableAllWaypoints();
            }
            else
            {
                return;
            } // end else if
            this.calculatePath();
        }
        else
        {
            return;
        } // end else if
    } // End of the function
    function optimizePath()
    {
        for (var _loc2 = _path.length - 1; this.isPathBlocked(_path[0], _path[_loc2]); --_loc2)
        {
        } // end of for
        _path.splice(1, _loc2 - 1);
    } // End of the function
    function drawHitTestLine(start, end)
    {
        if (_hitTestLineClip == undefined)
        {
            _hitTestLineClip = _root.createEmptyMovieClip("hitTestLineClip", _root.getNextHighestDepth());
        } // end if
        _hitTestLineClip.clear();
        _hitTestLineClip._x = start.x;
        _hitTestLineClip._y = start.y;
        _hitTestLineClip.lineStyle(2, 16750848, 100, true, "normal", "round", "round", 1);
        var _loc3 = {x: end.x, y: end.y};
        _hitTestLineClip.globalToLocal(_loc3);
        _hitTestLineClip.lineTo(_loc3.x, _loc3.y);
        _hitTestLineClip._visible = false;
        return (_hitTestLineClip);
    } // End of the function
    function set blockedAreaClip(clip)
    {
        _blockedAreaClip = clip;
        //return (this.blockedAreaClip());
        null;
    } // End of the function
    function set waypointsClip(waypointsClip)
    {
        if (waypointsClip != undefined)
        {
            _waypointManager = new com.clubpenguin.engine.pathfinding.WaypointManager(waypointsClip);
        } // end if
        //return (this.waypointsClip());
        null;
    } // End of the function
} // End of Class
