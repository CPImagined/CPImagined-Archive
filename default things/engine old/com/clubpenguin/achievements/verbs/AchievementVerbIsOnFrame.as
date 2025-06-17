
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbIsOnFrame extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var addSubjectFound, _debug;
        function AchievementVerbIsOnFrame (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local8 = 0;
            var _local9 = subjects.length;
            var _local6 = objects.length;
            var _local4 = 0;
            while (_local4 < _local9) {
                var _local3 = false;
                var _local2 = 0;
                while ((_local2 < _local6) && (!_local3)) {
                    if (subjects[_local4].frame == objects[_local2]) {
                        _local3 = true;
                    }
                    _local2++;
                }
                if (_local3) {
                    _local8++;
                    addSubjectFound(subjects[_local4]);
                }
                _local4++;
            }
            return(_local8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
