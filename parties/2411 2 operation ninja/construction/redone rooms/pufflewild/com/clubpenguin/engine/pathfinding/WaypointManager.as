//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.pathfinding.WaypointManager
    {
        var _containerClip, _waypoints;
        function WaypointManager (containerClip) {
            trace("[ENGINE] new WaypointManager instantiated");
            _containerClip = containerClip;
            setupWaypoints();
        }
        function setupWaypoints() {
            _waypoints = [];
            for (var _local_2 in _containerClip) {
                if (_containerClip[_local_2] instanceof MovieClip) {
                    add(createWaypointFromMovieClip(_containerClip[_local_2]));
                }
            }
        }
        function createWaypointFromMovieClip(mc) {
            return(new com.clubpenguin.engine.pathfinding.Waypoint(mc));
        }
        function add(waypoint) {
            _waypoints.push(waypoint);
        }
        function enableAllWaypoints() {
            var _local_2 = 0;
            var _local_3 = _waypoints.length;
            while (_local_2 < _local_3) {
                com.clubpenguin.engine.pathfinding.Waypoint(_waypoints[_local_2]).active = true;
                _local_2++;
            }
        }
        function setAllWaypointsAsUnused() {
            var _local_2 = 0;
            var _local_3 = _waypoints.length;
            while (_local_2 < _local_3) {
                com.clubpenguin.engine.pathfinding.Waypoint(_waypoints[_local_2]).used = false;
                _local_2++;
            }
        }
        function getClosestActiveWaypointToPoint(point) {
            var _local_3 = 0;
            var _local_7 = _waypoints.length;
            var _local_6;
            var _local_5;
            var _local_4;
            while (_local_3 < _local_7) {
                var _local_2 = com.clubpenguin.engine.pathfinding.Waypoint(_waypoints[_local_3]);
                if ((_local_2.active == true) && (_local_2.used == false)) {
                    _local_4 = flash.geom.Point.distance(_local_2, point);
                    if (isNaN(_local_5) || (_local_4 < _local_5)) {
                        _local_6 = _local_2;
                        _local_5 = _local_4;
                    }
                }
                _local_3++;
            }
            if ((_local_6.x == undefined) || (_local_6.y == undefined)) {
                return(undefined);
            }
            return(_local_6);
        }
        function getClosestActiveWaypointBetween(start, end) {
            var _local_8 = null;
            var _local_7;
            var _local_6;
            var _local_5;
            var _local_4;
            var _local_9 = _waypoints.length;
            var _local_3 = 0;
            while (_local_3 < _local_9) {
                var _local_2 = com.clubpenguin.engine.pathfinding.Waypoint(_waypoints[_local_3]);
                if ((!_local_2.active) || (_local_2.used)) {
                } else {
                    _local_5 = flash.geom.Point.distance(_local_2, start);
                    _local_4 = flash.geom.Point.distance(_local_2, end);
                    if ((_local_5 == 0) || (_local_4 == 0)) {
                    } else {
                        _local_6 = _local_5 + _local_4;
                        if (isNaN(_local_7) || (_local_6 < _local_7)) {
                            _local_8 = _local_2;
                            _local_7 = _local_6;
                        }
                    }
                }
                _local_3++;
            }
            return(_local_8);
        }
        function get waypoints() {
            return(_waypoints.slice());
        }
    }
