//Created by Action Script Viewer - https://www.buraks.com/asv
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
            var _local_3 = 0;
            var _local_5 = objects.length;
            var _local_2 = 0;
            while (_local_2 < _local_5) {
                if (_shell.isItemInMyInventory(objects[_local_2])) {
                    _local_3++;
                    addSubjectFound(subjects[0]);
                }
                _local_2++;
            }
            return(_local_3);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
