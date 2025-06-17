//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbOccurs extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _debug, addSubjectFound;
        function AchievementVerbOccurs (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local_2 = 0;
            com.clubpenguin.achievements.AchievementTools.debug = _debug;
            objects[0]--;
            if (objects[0] <= 0) {
                _local_2 = 1;
                addSubjectFound(subjects[0]);
                debugTrace("activate - event has occured a sufficient number of times.");
            } else {
                debugTrace(("activate - event must occur " + objects[0]) + " more times.");
            }
            return(_local_2);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
