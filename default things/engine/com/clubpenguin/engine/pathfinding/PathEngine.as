//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.pathfinding.PathEngine
    {
        var _blockedAreaClip, _start, _goal, _path, _waypointManager, _eye, _hitTestLineClip, __get__blockedAreaClip, __get__waypointsClip;
        function PathEngine () {
        }
        function getRandomPointInCircleWithClip(clip) {
            if (clip != undefined) {
                var _local_2 = Math.random() * (Math.PI*2);
                var _local_4 = Math.round(clip._x + (Math.sin(_local_2) * (Math.random() * (clip._width / 2))));
                var _local_3 = Math.round(clip._y + (Math.cos(_local_2) * (Math.random() * (clip._height / 2))));
                return(new flash.geom.Point(_local_4, _local_3));
            }
        }
        function isValidPoint(point) {
            return(!_blockedAreaClip.hitTest(point.x, point.y, true));
        }
        function getPathBetween(start, end) {
            if ((!isValidPoint(start)) || (!isValidPoint(end))) {
                return(undefined);
            }
            _start = start.clone();
            _goal = end.clone();
            if (!anyPathToTarget(start, end)) {
                return(undefined);
            }
            if (!isPathBlocked(start, end)) {
                _path = [start, end];
                return(_path);
            }
            if (!anyPathFromStartToWaypoint()) {
                return(undefined);
            }
            _path = [];
            if (_waypointManager != undefined) {
                _eye = _start;
                _waypointManager.enableAllWaypoints();
                _waypointManager.setAllWaypointsAsUnused();
                calculatePath();
            }
            _path.splice(0, 0, _start);
            _path.push(_goal);
            optimizePath();
            return(_path);
        }
        function getTotalDistanceOfPath(path) {
            var _local_1 = 0;
            var _local_4 = path.length;
            var _local_3 = 0;
            while (_local_1 < _local_4) {
                if (path[_local_1 - 1] != undefined) {
                    _local_3 = _local_3 + flash.geom.Point.distance(path[_local_1], path[_local_1 - 1]);
                }
                _local_1++;
            }
            return(_local_3);
        }
        function isPathBlocked(start, end) {
            return(com.clubpenguin.util.BitmapHitTester.doesHit(drawHitTestLine(start, end), _blockedAreaClip));
        }
        function anyPathToTarget(start, target) {
            var _local_3 = _waypointManager.waypoints;
            _local_3.splice(0, 0, start);
            var _local_4 = _local_3.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                if (!isPathBlocked(_local_3[_local_2], target)) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function anyPathFromStartToWaypoint(start) {
            var _local_3 = _waypointManager.waypoints;
            var _local_4 = _local_3.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                if (!isPathBlocked(start, _local_3[_local_2])) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function calculatePath() {
            if (((_eye.x == undefined) || (_eye.y == undefined)) || ((_goal.x == undefined) || (_goal.y == undefined))) {
                return(undefined);
            }
            if (isPathBlocked(_eye, _goal)) {
                var _local_2 = _waypointManager.getClosestActiveWaypointBetween(_eye, _goal);
                if (_local_2 == undefined) {
                    _path = [];
                    _waypointManager.enableAllWaypoints();
                    return(undefined);
                }
                if (isPathBlocked(_eye, _local_2)) {
                    _local_2.active = false;
                } else if (_eye != _local_2) {
                    _path.push(_local_2);
                    _local_2.used = true;
                    _eye = _local_2;
                    _waypointManager.enableAllWaypoints();
                } else {
                    return(undefined);
                }
                calculatePath();
            } else {
                return(undefined);
            }
        }
        function optimizePath() {
            var _local_2 = _path.length - 1;
            while (isPathBlocked(_path[0], _path[_local_2])) {
                _local_2--;
            }
            _path.splice(1, _local_2 - 1);
        }
        function drawHitTestLine(start, end) {
            if (_hitTestLineClip == undefined) {
                _hitTestLineClip = _root.createEmptyMovieClip("hitTestLineClip", _root.getNextHighestDepth());
            }
            _hitTestLineClip.clear();
            _hitTestLineClip._x = start.x;
            _hitTestLineClip._y = start.y;
            _hitTestLineClip.lineStyle(2, 16750848, 100, true, "normal", "round", "round", 1);
            var _local_3 = {x:end.x, y:end.y};
            _hitTestLineClip.globalToLocal(_local_3);
            _hitTestLineClip.lineTo(_local_3.x, _local_3.y);
            _hitTestLineClip._visible = false;
            return(_hitTestLineClip);
        }
        function set blockedAreaClip(clip) {
            _blockedAreaClip = clip;
            //return(__get__blockedAreaClip());
        }
        function set waypointsClip(waypointsClip) {
            if (waypointsClip != undefined) {
                _waypointManager = new com.clubpenguin.engine.pathfinding.WaypointManager(waypointsClip);
            }
            //return(__get__waypointsClip());
        }
    }
