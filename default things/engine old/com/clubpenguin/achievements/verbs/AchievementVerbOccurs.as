
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbOccurs extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _debug, addSubjectFound;
        function AchievementVerbOccurs (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local2 = 0;
            com.clubpenguin.achievements.AchievementTools.__set__debug(_debug);
            objects[0]--;
            if (objects[0] <= 0) {
                _local2 = 1;
                addSubjectFound(subjects[0]);
                debugTrace("activate - event has occured a sufficient number of times.");
            } else {
                debugTrace(("activate - event must occur " + objects[0]) + " more times.");
            }
            return(_local2);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
