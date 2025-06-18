//Created by Action Script Viewer - https://www.buraks.com/asv
    class ClientTrigger
    {
        var __targetList, __shell, __engine;
        function ClientTrigger (_shell, _engine) {
            __targetList = new Array();
            if (!_shell) {
                return;
            }
            __shell = _shell;
            if (!_engine) {
                return;
            }
            __engine = _engine;
            if (arguments.length > 2) {
                var _local_3 = 2;
                while (_local_3 < arguments.length) {
                    addTarget(arguments[_local_3]);
                    _local_3++;
                }
            }
        }
        function addTarget() {
            var _local_4;
            if (arguments.length <= 0) {
                return(undefined);
            }
            var _local_3 = 0;
            while (_local_3 < arguments.length) {
                if (typeof(arguments[_local_3]) != "movieclip") {
                } else {
                    __targetList.push(arguments[_local_3]);
                }
                _local_3++;
            }
        }
        function removeTarget() {
            var _local_5 = 0;
            if (arguments.length <= 0) {
                return(undefined);
            }
            var _local_4 = 0;
            while (_local_4 < arguments.length) {
                if (typeof(arguments[_local_4]) != "movieclip") {
                } else {
                    _local_5 = __targetList.length;
                    var _local_3 = 0;
                    while (_local_3 < _local_5) {
                        if (__targetList[_local_3] == arguments[_local_4]) {
                            __targetList.splice(_local_3, 1);
                            break;
                        }
                        _local_3++;
                    }
                }
                _local_4++;
            }
        }
        function penguinCount(Void) {
            return(countPenguinsOverTargets(COUNT_ALL, TEST_ALL, null));
        }
        function penguinThreshold(threshold) {
            if (threshold > 0) {
                return(countPenguinsOverTargets(COUNT_ALL, TEST_ALL, threshold) >= threshold);
            }
        }
        function hitTestLocal(Void) {
            return(countPenguinsOverTargets(COUNT_FIRST, TEST_LOCAL, null) == 1);
        }
        function hitTestAny(Void) {
            return(countPenguinsOverTargets(COUNT_FIRST, TEST_ALL, null) == 1);
        }
        function countPenguinsOverTargets(_stopOnFirst, _countLocalOnly, _threshold) {
            var _local_11 = new Array();
            var _local_12;
            var _local_8;
            var _local_4;
            var _local_5;
            var _local_13;
            var _local_6;
            var _local_2;
            var _local_3;
            var _local_7;
            if (__targetList.length <= 0) {
                return(0);
            }
            _local_3 = 0;
            _local_11 = new Array();
            if (_countLocalOnly) {
                _local_11.push(__shell.getPlayerObjectById(__shell.getMyPlayerId()));
            } else {
                _local_11 = __shell.getPlayerList();
            }
            _local_7 = false;
            if (_threshold > 0) {
                _local_7 = true;
            }
            _local_12 = _local_11.length;
            _local_8 = __targetList.length;
            _local_6 = 0;
            while (_local_6 < _local_12) {
                _local_4 = __engine.getPlayerMovieClip(_local_11[_local_6].player_id);
                if (_local_4) {
                    _local_2 = 0;
                    while (_local_2 < _local_8) {
                        _local_5 = __targetList[_local_2];
                        if (_local_5.hitTest(_local_4._x, _local_4._y, true)) {
                            _local_3++;
                            if (_stopOnFirst || (_local_7 && (_local_3 >= _threshold))) {
                                return(_local_3);
                            }
                        }
                        _local_2++;
                    }
                }
                _local_6++;
            }
            return(_local_3);
        }
        static var COUNT_FIRST = true;
        static var COUNT_ALL = false;
        static var TEST_LOCAL = true;
        static var TEST_ALL = false;
    }
