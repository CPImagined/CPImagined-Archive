
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubjectFactory
    {
        var _debug, __get__debug;
        function AchievementSubjectFactory (debug) {
            _debug = debug;
        }
        function createSubject(descriptor, achievementCheck) {
            debugTrace("createSubject - " + descriptor.join(" "));
            var _local3 = String(descriptor.shift());
            switch (_local3) {
                case "user" : 
                    return(new com.clubpenguin.achievements.subjects.AchievementSubjectUser(descriptor, true));
                case "mascot" : 
                    return(new com.clubpenguin.achievements.subjects.AchievementSubjectMascot(descriptor));
                case "sameSubjects" : 
                    return(new com.clubpenguin.achievements.subjects.AchievementSubjectSame(descriptor, achievementCheck));
                case "any" : 
                    return(new com.clubpenguin.achievements.subjects.AchievementSubjectAny(descriptor, false));
                case "anyWithUser" : 
                    return(new com.clubpenguin.achievements.subjects.AchievementSubjectAny(descriptor, true));
                case "event" : 
                    return(new com.clubpenguin.achievements.subjects.AchievementSubjectEvent(descriptor));
            }
            throw new com.clubpenguin.achievements.AchievementException(("Subject type not recognised:\"" + _local3) + "\"");
        }
        function set debug(state) {
            _debug = state;
            //return(__get__debug());
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
