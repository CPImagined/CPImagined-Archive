
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubjectMascot extends com.clubpenguin.achievements.subjects.AchievementSubject
    {
        var _shell, _debug;
        function AchievementSubjectMascot (descriptor, debug) {
            super();
        }
        function getCurrentSubjects(event) {
            var _local2 = _shell.getPlayerList();
            var _local3 = [];
            for (var _local4 in _local2) {
                if (_shell.isPlayerMascotById(_local2[_local4].player_id)) {
                    _local3.push(_local2[_local4]);
                }
            }
            return(_local3);
        }
        function shouldEventFire(event) {
            if (_shell.isPlayerMascotById(event.player_id)) {
                return(true);
            }
            return(false);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
