//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.pathfinding.WaypointManager
    {
        var _containerClip, _waypoints;
        function WaypointManager (_arg_2) {
            _containerClip = _arg_2;
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
        function createWaypointFromMovieClip(_arg_1) {
            return(new com.clubpenguin.engine.pathfinding.Waypoint(_arg_1));
        }
        function add(_arg_2) {
            _waypoints.push(_arg_2);
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
        function getClosestActiveWaypointToPoint(_arg_8) {
            var _local_3 = 0;
            var _local_7 = _waypoints.length;
            var _local_6;
            var _local_5;
            var _local_4;
            while (_local_3 < _local_7) {
                var _local_2 = com.clubpenguin.engine.pathfinding.Waypoint(_waypoints[_local_3]);
                if ((_local_2.active == true) && (_local_2.used == false)) {
                    _local_4 = flash.geom.Point.distance(_local_2, _arg_8);
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
        function getClosestActiveWaypointBetween(_arg_11, _arg_10) {
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
                    _local_5 = flash.geom.Point.distance(_local_2, _arg_11);
                    _local_4 = flash.geom.Point.distance(_local_2, _arg_10);
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
