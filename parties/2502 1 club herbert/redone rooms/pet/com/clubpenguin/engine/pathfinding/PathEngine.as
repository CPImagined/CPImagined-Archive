//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.pathfinding.PathEngine
    {
        var _blockedAreaClip, _start, _goal, _path, _waypointManager, _eye, _hitTestLineClip, __get__blockedAreaClip, __get__waypointsClip;
        function PathEngine () {
        }
        function getRandomPointInCircleWithClip(_arg_1) {
            if (_arg_1 != undefined) {
                var _local_2 = Math.random() * (Math.PI*2);
                var _local_4 = Math.round(_arg_1._x + (Math.sin(_local_2) * (Math.random() * (_arg_1._width / 2))));
                var _local_3 = Math.round(_arg_1._y + (Math.cos(_local_2) * (Math.random() * (_arg_1._height / 2))));
                return(new flash.geom.Point(_local_4, _local_3));
            }
        }
        function isValidPoint(_arg_2) {
            return(!_blockedAreaClip.hitTest(_arg_2.x, _arg_2.y, true));
        }
        function getPathBetween(_arg_3, _arg_2) {
            if ((!isValidPoint(_arg_3)) || (!isValidPoint(_arg_2))) {
                return(undefined);
            }
            _start = _arg_3.clone();
            _goal = _arg_2.clone();
            if (!anyPathToTarget(_arg_3, _arg_2)) {
                return(undefined);
            }
            if (!isPathBlocked(_arg_3, _arg_2)) {
                _path = [_arg_3, _arg_2];
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
        function getTotalDistanceOfPath(_arg_2) {
            var _local_1 = 0;
            var _local_4 = _arg_2.length;
            var _local_3 = 0;
            while (_local_1 < _local_4) {
                if (_arg_2[_local_1 - 1] != undefined) {
                    _local_3 = _local_3 + flash.geom.Point.distance(_arg_2[_local_1], _arg_2[_local_1 - 1]);
                }
                _local_1++;
            }
            return(_local_3);
        }
        function isPathBlocked(_arg_3, _arg_2) {
            return(com.clubpenguin.util.BitmapHitTester.doesHit(drawHitTestLine(_arg_3, _arg_2), _blockedAreaClip));
        }
        function anyPathToTarget(_arg_6, _arg_5) {
            var _local_3 = _waypointManager.waypoints;
            _local_3.splice(0, 0, _arg_6);
            var _local_4 = _local_3.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                if (!isPathBlocked(_local_3[_local_2], _arg_5)) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function anyPathFromStartToWaypoint(_arg_5) {
            var _local_3 = _waypointManager.waypoints;
            var _local_4 = _local_3.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                if (!isPathBlocked(_arg_5, _local_3[_local_2])) {
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
        function drawHitTestLine(_arg_7, _arg_4) {
            if (_hitTestLineClip == undefined) {
                _hitTestLineClip = _root.createEmptyMovieClip("hitTestLineClip", _root.getNextHighestDepth());
            }
            _hitTestLineClip.clear();
            _hitTestLineClip._x = _arg_7.x;
            _hitTestLineClip._y = _arg_7.y;
            _hitTestLineClip.lineStyle(2, 16750848, 100, true, "normal", "round", "round", 1);
            var _local_3 = {x:_arg_4.x, y:_arg_4.y};
            _hitTestLineClip.globalToLocal(_local_3);
            _hitTestLineClip.lineTo(_local_3.x, _local_3.y);
            _hitTestLineClip._visible = false;
            return(_hitTestLineClip);
        }
        function set blockedAreaClip(_arg_2) {
            _blockedAreaClip = _arg_2;
            //return(__get__blockedAreaClip());
        }
        function set waypointsClip(_arg_2) {
            if (_arg_2 != undefined) {
                _waypointManager = new com.clubpenguin.engine.pathfinding.WaypointManager(_arg_2);
            }
            //return(__get__waypointsClip());
        }
    }
