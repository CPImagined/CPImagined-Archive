
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbContainsText extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var addSubjectFound, _debug;
        function AchievementVerbContainsText (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local8 = 0;
            var _local5 = 0;
            while (_local5 < subjects.length) {
                var _local3 = String(subjects[_local5].message);
                if (_local3.length < 1) {
                } else {
                    _local3 = _local3.toLowerCase();
                    debugTrace("activate - msg: " + _local3);
                    var _local2 = 0;
                    while (_local2 < objects.length) {
                        debugTrace("activate - cmp: " + objects[_local2]);
                        var _local4 = _local3.split(objects[_local2], 2);
                        debugTrace("activate - splits: " + _local4.length);
                        if (_local4.length > 1) {
                            _local8++;
                            addSubjectFound(subjects[_local5]);
                        }
                        _local2++;
                    }
                }
                _local5++;
            }
            return(_local8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
