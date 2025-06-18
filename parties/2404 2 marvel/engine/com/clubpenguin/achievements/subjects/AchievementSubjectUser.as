//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubjectUser extends com.clubpenguin.achievements.subjects.AchievementSubject
    {
        var _shell, _debug;
        function AchievementSubjectUser (descriptor, debug) {
            super();
        }
        function getCurrentSubjects(event) {
            return([_shell.getMyPlayerObject()]);
        }
        function getEnterRoomEvent() {
            return(_shell.JOIN_ROOM);
        }
        function shouldEventFire(event) {
            debugTrace((("shouldEventFire - is " + event.player_id) + " equal to ") + _shell.getMyPlayerId());
            if ((event == null) || (_shell.isMyPlayer(event.player_id))) {
                return(true);
            }
            return(false);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
