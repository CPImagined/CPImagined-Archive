
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbOwns extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _shell, addSubjectFound, _debug;
        function AchievementVerbOwns (descriptor, debug) {
            super(descriptor, debug);
        }
        function activate(subjects, objects, objectOperation) {
            debugTrace("activate");
            if (subjects.length > 1) {
                throw new com.clubpenguin.achievements.AchievementException("AchievementVerbOwns::activate cannot check ownership for penguins other than the user.");
            }
            if (subjects[0].player_id != _shell.getMyPlayerId()) {
                throw new com.clubpenguin.achievements.AchievementException("AchievementVerbOwns::activate cannot check ownership for penguins other than the user. Player ID of subject did not match.");
            }
            var _local3 = 0;
            var _local5 = objects.length;
            var _local2 = 0;
            while (_local2 < _local5) {
                if (_shell.isItemInMyInventory(objects[_local2])) {
                    _local3++;
                    addSubjectFound(subjects[0]);
                }
                _local2++;
            }
            return(_local3);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
