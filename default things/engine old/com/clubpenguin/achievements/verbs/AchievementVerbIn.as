
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbIn extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _shell, _isList, addSubjectFound, _debug;
        function AchievementVerbIn (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local8 = 0;
            var _local9 = subjects.length;
            var _local6 = objects.length;
            var _local7 = _shell.getCurrentRoomId();
            var _local5 = 0;
            while (_local5 < _local9) {
                debugTrace((("activate - peng:" + _local5) + " is in room ") + _local7);
                var _local4 = false;
                if (_isList) {
                    if (_local6 > 0) {
                        _local4 = true;
                        var _local2 = 0;
                        while (_local2 < _local6) {
                            if (objects[_local2] == "myIgloo") {
                                objects[_local2] = _shell.getMyIglooRoomId();
                            }
                            if ((objects[_local2] != null) && (!_shell.visitedThisRoom(objects[_local2]))) {
                                _local4 = false;
                                break;
                            }
                            _local2++;
                        }
                    }
                } else {
                    var _local2 = 0;
                    while ((_local2 < _local6) && (!_local4)) {
                        if (objects[_local2] == "myIgloo") {
                            objects[_local2] = _shell.getMyIglooRoomId();
                        }
                        debugTrace((("activate - objIdx:" + _local2) + " has Id:") + objects[_local2]);
                        if ((objects[_local2] != null) && (_local7 == objects[_local2])) {
                            debugTrace((("activate - peng:" + _local5) + " is in room ") + objects[_local2]);
                            _local4 = true;
                        }
                        _local2++;
                    }
                }
                if (_local4) {
                    _local8++;
                    addSubjectFound(subjects[_local5]);
                } else {
                    debugTrace((("activate - peng:" + _local5) + " is not in room ") + objects[_local2]);
                }
                _local5++;
            }
            debugTrace((("activate (currentRoomId:" + _local7) + ") hits: ") + _local8);
            return(_local8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
