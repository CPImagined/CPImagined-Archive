
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubjectEvent extends com.clubpenguin.achievements.subjects.AchievementSubject
    {
        var _debug;
        function AchievementSubjectEvent (descriptor, debug) {
            super();
        }
        function getCurrentSubjects(event) {
            return([event]);
        }
        function getEnterRoomEvent() {
            return(null);
        }
        function shouldEventFire(event) {
            if (event.id != null) {
                return(true);
            }
            return(false);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
