
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbHit extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _debug, addSubjectFound;
        function AchievementVerbHit (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local8 = 0;
            com.clubpenguin.achievements.AchievementTools.__set__debug(_debug);
            var _local6 = com.clubpenguin.achievements.AchievementTools.getClipsFromIDs(subjects);
            var _local5 = com.clubpenguin.achievements.AchievementTools.getClipsFromIDs(objects);
            debugTrace("-----------------------------------------------------------");
            debugTrace(" hit subjects: " + subjects.join(" "));
            debugTrace(" hit objects: " + objects.join(" "));
            debugTrace("-----------------------------------------------------------");
            debugTrace(" hit subject clips: " + _local6.join(" "));
            debugTrace(" hit object clips: " + _local5.join(" "));
            debugTrace("-----------------------------------------------------------");
            var _local10 = _local6.length;
            var _local7 = _local5.length;
            var _local3 = 0;
            while (_local3 < _local10) {
                var _local4 = false;
                var _local2 = 0;
                while ((_local2 < _local7) && (!_local4)) {
                    if (_local6[_local3].hitTest(_local5[_local2])) {
                        debugTrace(((" subj " + _local3) + " hit obj ") + _local2);
                        _local4 = true;
                    }
                    _local2++;
                }
                if (_local4) {
                    _local8++;
                    addSubjectFound(subjects[_local3]);
                }
                _local3++;
            }
            debugTrace(" -----------------------------------------------------------");
            return(_local8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
