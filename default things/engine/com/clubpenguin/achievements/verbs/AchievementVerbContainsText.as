//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbContainsText extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var addSubjectFound, _debug;
        function AchievementVerbContainsText (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local_8 = 0;
            var _local_5 = 0;
            while (_local_5 < subjects.length) {
                var _local_3 = String(subjects[_local_5].message);
                if (_local_3.length < 1) {
                } else {
                    _local_3 = _local_3.toLowerCase();
                    debugTrace("activate - msg: " + _local_3);
                    var _local_2 = 0;
                    while (_local_2 < objects.length) {
                        debugTrace("activate - cmp: " + objects[_local_2]);
                        var _local_4 = _local_3.split(objects[_local_2], 2);
                        debugTrace("activate - splits: " + _local_4.length);
                        if (_local_4.length > 1) {
                            _local_8++;
                            addSubjectFound(subjects[_local_5]);
                        }
                        _local_2++;
                    }
                }
                _local_5++;
            }
            return(_local_8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
