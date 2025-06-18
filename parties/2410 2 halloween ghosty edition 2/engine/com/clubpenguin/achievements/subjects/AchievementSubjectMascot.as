//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.subjects.AchievementSubjectMascot extends com.clubpenguin.achievements.subjects.AchievementSubject
    {
        var _shell, _debug;
        function AchievementSubjectMascot (descriptor, debug) {
            super();
        }
        function getCurrentSubjects(event) {
            var _local_2 = _shell.getPlayerList();
            var _local_3 = [];
            for (var _local_4 in _local_2) {
                if (_shell.isPlayerMascotById(_local_2[_local_4].player_id)) {
                    _local_3.push(_local_2[_local_4]);
                }
            }
            return(_local_3);
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
