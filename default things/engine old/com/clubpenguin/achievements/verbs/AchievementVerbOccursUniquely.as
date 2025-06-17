
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbOccursUniquely extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _uniqueTypeSeen, _uniqueType, _debug, _shell, addSubjectFound;
        function AchievementVerbOccursUniquely (descriptor, debug) {
            super(descriptor, debug);
            _uniqueTypeSeen = {};
            _uniqueType = String(descriptor.shift());
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            var _local2 = 0;
            com.clubpenguin.achievements.AchievementTools.__set__debug(_debug);
            switch (_uniqueType) {
                case "room" : 
                    var _local3 = String(_shell.getCurrentRoomId());
                    if (_uniqueTypeSeen[_local3] == undefined) {
                        _uniqueTypeSeen[_local3] = true;
                        objects[0]--;
                    } else {
                        return(0);
                    }
                    break;
                default : 
                    throw new com.clubpenguin.achievements.AchievementException(("[AchievementVerbOccursUniquely] unrecognise unique type:\"" + _uniqueType) + "\"");
            }
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
