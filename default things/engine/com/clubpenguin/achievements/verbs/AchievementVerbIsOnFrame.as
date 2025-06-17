//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbIsOnFrame extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var addSubjectFound, _debug;
        function AchievementVerbIsOnFrame (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local_8 = 0;
            var _local_9 = subjects.length;
            var _local_6 = objects.length;
            var _local_4 = 0;
            while (_local_4 < _local_9) {
                var _local_3 = false;
                var _local_2 = 0;
                while ((_local_2 < _local_6) && (!_local_3)) {
                    if (subjects[_local_4].frame == objects[_local_2]) {
                        _local_3 = true;
                    }
                    _local_2++;
                }
                if (_local_3) {
                    _local_8++;
                    addSubjectFound(subjects[_local_4]);
                }
                _local_4++;
            }
            return(_local_8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
