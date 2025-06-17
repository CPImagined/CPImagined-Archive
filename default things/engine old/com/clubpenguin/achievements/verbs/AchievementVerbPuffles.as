
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbPuffles extends com.clubpenguin.achievements.verbs.AchievementVerb
    {
        var _property, _shell, addSubjectFound, _debug;
        function AchievementVerbPuffles (descriptor, debug) {
            super(descriptor, debug);
            _property = String(descriptor.shift());
        }
        function activate(subjects, objects, objectOperation) {
            var _local2 = 0;
            if (subjects.length > 1) {
                throw new com.clubpenguin.achievements.AchievementException("AchievementVerbPuffles::activate cannot check puffles for penguins other than the user.");
            }
            if (subjects[0].player_id != _shell.getMyPlayerId()) {
                throw new com.clubpenguin.achievements.AchievementException("AchievementVerbPuffles::activate cannot check puffles for penguins other than the user. Player ID of subject did not match.");
            }
            switch (_property) {
                case "countGreaterThan" : 
                    if (_shell.getMyPuffleCount() > objects[0]) {
                        _local2 = 1;
                    }
                    break;
                default : 
                    throw new com.clubpenguin.achievements.AchievementException(("AchievementVerbPuffles did not recognise property:\"" + _property) + "\"");
                    break;
            }
            if (_local2 == 1) {
                addSubjectFound(subjects[0]);
            }
            return(_local2);
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
