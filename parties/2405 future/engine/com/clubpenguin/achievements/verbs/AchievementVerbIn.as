//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbIn extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _shell, _isList, addSubjectFound, _debug;
        function AchievementVerbIn (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local_8 = 0;
            var _local_9 = subjects.length;
            var _local_6 = objects.length;
            var _local_7 = _shell.getCurrentRoomId();
            var _local_5 = 0;
            while (_local_5 < _local_9) {
                debugTrace((("activate - peng:" + _local_5) + " is in room ") + _local_7);
                var _local_4 = false;
                if (_isList) {
                    if (_local_6 > 0) {
                        _local_4 = true;
                        var _local_2 = 0;
                        while (_local_2 < _local_6) {
                            if (objects[_local_2] == "myIgloo") {
                                objects[_local_2] = _shell.getMyIglooRoomId();
                            }
                            if ((objects[_local_2] != null) && (!_shell.visitedThisRoom(objects[_local_2]))) {
                                _local_4 = false;
                                break;
                            }
                            _local_2++;
                        }
                    }
                } else {
                    var _local_2 = 0;
                    while ((_local_2 < _local_6) && (!_local_4)) {
                        if (objects[_local_2] == "myIgloo") {
                            objects[_local_2] = _shell.getMyIglooRoomId();
                        }
                        debugTrace((("activate - objIdx:" + _local_2) + " has Id:") + objects[_local_2]);
                        if ((objects[_local_2] != null) && (_local_7 == objects[_local_2])) {
                            debugTrace((("activate - peng:" + _local_5) + " is in room ") + objects[_local_2]);
                            _local_4 = true;
                        }
                        _local_2++;
                    }
                }
                if (_local_4) {
                    _local_8++;
                    addSubjectFound(subjects[_local_5]);
                } else {
                    debugTrace((("activate - peng:" + _local_5) + " is not in room ") + objects[_local_2]);
                }
                _local_5++;
            }
            debugTrace((("activate (currentRoomId:" + _local_7) + ") hits: ") + _local_8);
            return(_local_8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
