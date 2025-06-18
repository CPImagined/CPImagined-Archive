//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbHit extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _debug, addSubjectFound;
        function AchievementVerbHit (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local_8 = 0;
            com.clubpenguin.achievements.AchievementTools.debug = _debug;
            var _local_6 = com.clubpenguin.achievements.AchievementTools.getClipsFromIDs(subjects);
            var _local_5 = com.clubpenguin.achievements.AchievementTools.getClipsFromIDs(objects);
            debugTrace("-----------------------------------------------------------");
            debugTrace(" hit subjects: " + subjects.join(" "));
            debugTrace(" hit objects: " + objects.join(" "));
            debugTrace("-----------------------------------------------------------");
            debugTrace(" hit subject clips: " + _local_6.join(" "));
            debugTrace(" hit object clips: " + _local_5.join(" "));
            debugTrace("-----------------------------------------------------------");
            var _local_10 = _local_6.length;
            var _local_7 = _local_5.length;
            var _local_3 = 0;
            while (_local_3 < _local_10) {
                var _local_4 = false;
                var _local_2 = 0;
                while ((_local_2 < _local_7) && (!_local_4)) {
                    if (_local_6[_local_3].hitTest(_local_5[_local_2])) {
                        debugTrace(((" subj " + _local_3) + " hit obj ") + _local_2);
                        _local_4 = true;
                    }
                    _local_2++;
                }
                if (_local_4) {
                    _local_8++;
                    addSubjectFound(subjects[_local_3]);
                }
                _local_3++;
            }
            debugTrace(" -----------------------------------------------------------");
            return(_local_8);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
