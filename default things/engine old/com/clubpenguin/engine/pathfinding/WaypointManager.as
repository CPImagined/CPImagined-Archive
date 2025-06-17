class com.clubpenguin.engine.pathfinding.WaypointManager
{
    var _containerClip, _waypoints, __get__waypoints;
    function WaypointManager(containerClip)
    {
        _containerClip = containerClip;
        this.setupWaypoints();
    } // End of the function
    function setupWaypoints()
    {
        _waypoints = [];
        for (var _loc2 in _containerClip)
        {
            if (_containerClip[_loc2] instanceof MovieClip)
            {
                this.add(this.createWaypointFromMovieClip(_containerClip[_loc2]));
            } // end if
        } // end of for...in
    } // End of the function
    function createWaypointFromMovieClip(mc)
    {
        return (new com.clubpenguin.engine.pathfinding.Waypoint(mc));
    } // End of the function
    function add(waypoint)
    {
        _waypoints.push(waypoint);
    } // End of the function
    function enableAllWaypoints()
    {
        var _loc2 = 0;
        var _loc3 = _waypoints.length;
        while (_loc2 < _loc3)
        {
            (com.clubpenguin.engine.pathfinding.Waypoint)(_waypoints[_loc2]).__set__active(true);
            ++_loc2;
        } // end while
    } // End of the function
    function setAllWaypointsAsUnused()
    {
        var _loc2 = 0;
        var _loc3 = _waypoints.length;
        while (_loc2 < _loc3)
        {
            (com.clubpenguin.engine.pathfinding.Waypoint)(_waypoints[_loc2]).__set__used(false);
            ++_loc2;
        } // end while
    } // End of the function
    function getClosestActiveWaypointToPoint(point)
    {
        var _loc3 = 0;
        var _loc7 = _waypoints.length;
        var _loc6;
        var _loc5;
        var _loc4;
        while (_loc3 < _loc7)
        {
            var _loc2 = (com.clubpenguin.engine.pathfinding.Waypoint)(_waypoints[_loc3]);
            if (_loc2.__get__active() == true && _loc2.__get__used() == false)
            {
                _loc4 = flash.geom.Point.distance(_loc2, point);
                if (isNaN(_loc5) || _loc4 < _loc5)
                {
                    _loc6 = _loc2;
                    _loc5 = _loc4;
                } // end if
            } // end if
            ++_loc3;
        } // end while
        if (_loc6.x == undefined || _loc6.y == undefined)
        {
            return;
        } // end if
        return (_loc6);
    } // End of the function
    function getClosestActiveWaypointBetween(start, end)
    {
        var _loc8 = null;
        var _loc7;
        var _loc6;
        var _loc5;
        var _loc4;
        var _loc9 = _waypoints.length;
        for (var _loc3 = 0; _loc3 < _loc9; ++_loc3)
        {
            var _loc2 = (com.clubpenguin.engine.pathfinding.Waypoint)(_waypoints[_loc3]);
            if (!_loc2.__get__active() || _loc2.__get__used())
            {
                continue;
            } // end if
            _loc5 = flash.geom.Point.distance(_loc2, start);
            _loc4 = flash.geom.Point.distance(_loc2, end);
            if (_loc5 == 0 || _loc4 == 0)
            {
                continue;
            } // end if
            _loc6 = _loc5 + _loc4;
            if (isNaN(_loc7) || _loc6 < _loc7)
            {
                _loc8 = _loc2;
                _loc7 = _loc6;
            } // end if
        } // end of for
        return (_loc8);
    } // End of the function
    function get waypoints()
    {
        return (_waypoints.slice());
    } // End of the function
} // End of Class
